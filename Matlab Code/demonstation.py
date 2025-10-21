#!/usr/bin/env python3
"""
PSoC 5x5 SENSOR ARRAY VISUALIZER & FREQUENCY ANALYZER (Python Desktop App)
- Live heatmap of NxN sensor array
- FFT of the most dynamic channel (highest std over buffer window)
- Peak frequency + sampling rate estimate

Port of your MATLAB script to a PyQt5 desktop app with embedded Matplotlib.

Requirements
------------
python -m pip install pyqt5 pyserial numpy matplotlib

Run
---
python psoc_visualizer.py

Notes
-----
- Update the COM port (Windows: COM9, macOS: /dev/tty.usbmodem*, Linux: /dev/ttyACM*).
- The app attempts to sync on lines starting with 'd0:' and then reads d1:..dN-1.
- Expected frame: N lines, one per channel, format: d<index>:<float> with CR/LF terminator.
"""
from __future__ import annotations
import sys
import time
import threading
from dataclasses import dataclass
from typing import Optional, List

import numpy as np
from PyQt5 import QtCore, QtWidgets
from PyQt5.QtCore import Qt, pyqtSignal, QThread
from PyQt5.QtWidgets import (
    QApplication, QMainWindow, QWidget, QComboBox, QSpinBox, QLabel, QPushButton,
    QHBoxLayout, QVBoxLayout, QMessageBox, QCheckBox
)

# Matplotlib embedding
from matplotlib.backends.backend_qt5agg import FigureCanvasQTAgg as FigureCanvas
from matplotlib.figure import Figure

# Serial
try:
    import serial
    import serial.tools.list_ports
except Exception as e:
    serial = None

# ...existing code...
# Default and supported boards
BOARDS = {
    "JFET/ Electret": 2,
    "5x5 (25)": 5,
}

DEFAULT_BOARD_NAME = "5x5 (25)"
DEFAULT_GRID = BOARDS[DEFAULT_BOARD_NAME]
DEFAULT_NUM_PINS = DEFAULT_GRID * DEFAULT_GRID


@dataclass
class Frame:
    values: np.ndarray  # shape (num_pins,)
    t: float            # timestamp (seconds, monotonic)


class SerialReader(QThread):
    frameReady = pyqtSignal(object)   # emits Frame
    statusMsg = pyqtSignal(str)
    errorMsg = pyqtSignal(str)

    def __init__(self, port: str, baud: int = 115200, num_pins: int = DEFAULT_NUM_PINS, terminator: bytes = b"\r\n", parent=None):
        super().__init__(parent)
        self._port_name = port
        self._baud = baud
        self._term = terminator
        self._stop = threading.Event()
        self._ser: Optional[serial.Serial] = None
        self._num_pins = int(num_pins)

    def stop(self):
        self._stop.set()

    def run(self):
        if serial is None:
            self.errorMsg.emit("pyserial not installed. Run: pip install pyserial")
            return
        try:
            self._ser = serial.Serial(self._port_name, self._baud, timeout=0.5)
            self._ser.reset_input_buffer()
            self._ser.reset_output_buffer()
            self.statusMsg.emit(f"Opened {self._port_name} @ {self._baud}.")
        except Exception as e:
            self.errorMsg.emit(f"Failed to open {self._port_name}: {e}")
            return

        # Helper: read one line (stripped) as string
        def _readline_str() -> Optional[str]:
            try:
                raw = self._ser.readline()
                if not raw:
                    return None
                # Handle either CR/LF or LF endings
                line = raw.decode(errors="ignore").strip()
                return line
            except Exception:
                return None

        try:
            while not self._stop.is_set():
                # Sync: look for d0:
                line = _readline_str()
                if line is None:
                    continue
                if not line.startswith("d0:"):
                    continue
                # Begin frame acquisition
                vals = np.zeros(self._num_pins, dtype=float)
                ok = True
                # Parse d0
                try:
                    parts = line.split(":", 1)
                    vals[0] = float(parts[1])
                except Exception:
                    ok = False

                # Read d1..dN-1
                read_count = 1
                for i in range(1, self._num_pins):
                    line_i = _readline_str()
                    if line_i is None or len(line_i) == 0:
                        ok = False
                        self.statusMsg.emit("Warning: timed out mid-frame; resyncing…")
                        break
                    if not line_i.startswith("d"):
                        ok = False
                        self.statusMsg.emit(f"Warning: malformed line '{line_i}'; resyncing…")
                        break
                    try:
                        pin_s, val_s = line_i.split(":", 1)
                        pin_idx = int(pin_s[1:])
                        val = float(val_s)
                        if 0 <= pin_idx < self._num_pins:
                            vals[pin_idx] = val
                            read_count += 1
                        else:
                            ok = False
                            self.statusMsg.emit(f"Warning: unexpected pin index {pin_idx}; resyncing…")
                            break
                    except Exception:
                        ok = False
                        self.statusMsg.emit(f"Warning: parse error for line '{line_i}'; resyncing…")
                        break

                if ok and read_count == self._num_pins:
                    self.frameReady.emit(Frame(values=vals.copy(), t=time.monotonic()))
                # else: resync automatically by continuing the loop
        finally:
            try:
                if self._ser and self._ser.is_open:
                    self._ser.close()
                    self.statusMsg.emit("Serial port closed.")
            except Exception:
                pass


class MplCanvas(FigureCanvas):
    def __init__(self, grid_size: int = DEFAULT_GRID):
        self.grid_size = int(grid_size)
        self.fig = Figure(constrained_layout=True)
        super().__init__(self.fig)
        self.ax_heat = self.fig.add_subplot(2, 2, (1, 3))
        self.ax_fft = self.fig.add_subplot(2, 2, 2)
        self.ax_text = self.fig.add_subplot(2, 2, 4)
        self.ax_text.axis("off")

        # Heatmap initial
        self.im = self.ax_heat.imshow(np.zeros((self.grid_size, self.grid_size)), aspect="equal")
        self.cbar = self.fig.colorbar(self.im, ax=self.ax_heat)
        self.ax_heat.set_title("Live Sensor Array Signal Strength")
        self.ax_heat.set_xlabel("Column")
        self.ax_heat.set_ylabel("Row")
        self.ax_heat.set_xticks(range(self.grid_size))
        self.ax_heat.set_yticks(range(self.grid_size))

        # FFT initial
        self.fft_line, = self.ax_fft.plot([0], [0])
        self.ax_fft.set_title("Frequency Spectrum of Strongest Signal")
        self.ax_fft.set_xlabel("Frequency (Hz)")
        self.ax_fft.set_ylabel("Amplitude")
        self.ax_fft.grid(True)
        self.ax_fft.set_xlim(0, 1)

        # Text
        self.text_obj = self.ax_text.text(0.5, 0.5, "Waiting for data…", ha="center", va="center", fontsize=12)


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("PSoC Sensor Array Analyzer")
        self.resize(1200, 700)

        # Board selection
        self.board_combo = QComboBox()
        self.board_combo.addItems(list(BOARDS.keys()))
        self.board_combo.setCurrentText(DEFAULT_BOARD_NAME)
        self.board_combo.currentTextChanged.connect(self.on_board_changed)
        self.grid_size = BOARDS[self.board_combo.currentText()]

        # The JFET and Electret board has 2x3 pins (6 total)
        if (self.board_combo.currentText() == 'JFET/ Electret'):
            self.num_pins = 6
        else:
            self.num_pins = self.grid_size * self.grid_size

        # Serial controls
        self.port_combo = QComboBox()
        self.refresh_ports()
        self.baud_spin = QSpinBox()
        self.baud_spin.setRange(1200, 10000000)
        self.baud_spin.setValue(115200)
        self.buffer_spin = QSpinBox()
        self.buffer_spin.setRange(16, 4096)
        self.buffer_spin.setValue(256)
        self.buffer_spin.setSingleStep(16)
        self.autoscale_chk = QCheckBox("Autoscale heatmap")
        self.autoscale_chk.setChecked(True)

        self.btn_refresh = QPushButton("Refresh Ports")
        self.btn_start = QPushButton("Start")
        self.btn_stop = QPushButton("Stop")
        self.btn_stop.setEnabled(False)

        topbar = QHBoxLayout()
        topbar.addWidget(QLabel("Board Type:"))
        topbar.addWidget(self.board_combo)
        topbar.addSpacing(8)
        topbar.addWidget(QLabel("Port:"))
        topbar.addWidget(self.port_combo)
        topbar.addWidget(self.btn_refresh)
        topbar.addSpacing(12)
        topbar.addWidget(QLabel("Baud:"))
        topbar.addWidget(self.baud_spin)
        topbar.addSpacing(12)
        topbar.addWidget(QLabel("Buffer N:"))
        topbar.addWidget(self.buffer_spin)
        topbar.addSpacing(12)
        topbar.addWidget(self.autoscale_chk)
        topbar.addStretch()
        topbar.addWidget(self.btn_start)
        topbar.addWidget(self.btn_stop)

        # Canvas
        self.canvas = MplCanvas(self.grid_size)

        # Status
        self.status_label = QLabel("Idle")
        status_bar = QHBoxLayout()
        status_bar.addWidget(self.status_label)
        status_bar.addStretch()

        # Central widget
        central = QWidget()
        v = QVBoxLayout(central)
        v.addLayout(topbar)
        v.addWidget(self.canvas)
        v.addLayout(status_bar)
        self.setCentralWidget(central)

        # Data buffers
        self.buffer_size = self.buffer_spin.value()
        self.data_buffer = np.zeros((self.buffer_size, self.num_pins), dtype=float)
        self.time_buffer = np.zeros(self.buffer_size, dtype=float)
        self.buf_idx = 0
        self.frames_seen = 0

        # Thread
        self.reader: Optional[SerialReader] = None

        # Signals
        self.btn_refresh.clicked.connect(self.refresh_ports)
        self.btn_start.clicked.connect(self.start_acquire)
        self.btn_stop.clicked.connect(self.stop_acquire)
        self.buffer_spin.valueChanged.connect(self.on_buffer_changed)
        self.autoscale_chk.toggled.connect(self.on_autoscale)

    def refresh_ports(self):
        if serial is None:
            self.port_combo.clear()
            self.port_combo.addItem("<pyserial not installed>")
            return
        ports = [p.device for p in serial.tools.list_ports.comports()]
        self.port_combo.clear()
        if not ports:
            self.port_combo.addItem("<no ports>")
        else:
            self.port_combo.addItems(ports)

    def on_board_changed(self, board_name: str):
        # Stop any active reader (reader will be recreated when starting)
        if self.reader:
            self.stop_acquire()

        self.grid_size = BOARDS.get(board_name, DEFAULT_GRID)
        self.num_pins = self.grid_size * self.grid_size

        # Replace canvas with one sized for new grid
        layout = self.centralWidget().layout()
        # canvas is at index 1
        try:
            layout.removeWidget(self.canvas)
            self.canvas.setParent(None)
        except Exception:
            pass
        self.canvas = MplCanvas(self.grid_size)
        layout.insertWidget(1, self.canvas)

        # Reset buffers
        self.data_buffer = np.zeros((self.buffer_size, self.num_pins), dtype=float)
        self.time_buffer = np.zeros(self.buffer_size, dtype=float)
        self.buf_idx = 0
        self.frames_seen = 0
        self.status_label.setText(f"Selected {board_name}. Buffer reset.")

    def on_buffer_changed(self, n: int):
        self.buffer_size = int(n)
        self.data_buffer = np.zeros((self.buffer_size, self.num_pins), dtype=float)
        self.time_buffer = np.zeros(self.buffer_size, dtype=float)
        self.buf_idx = 0
        self.frames_seen = 0
        self.status_label.setText(f"Buffer reset to {self.buffer_size}.")

    def on_autoscale(self, checked: bool):
        if checked:
            self.canvas.im.set_clim(None)
        self.canvas.draw_idle()

    def start_acquire(self):
        port = self.port_combo.currentText()
        if not port or port.startswith("<"):
            QMessageBox.warning(self, "Port", "Select a valid serial port.")
            return
        baud = int(self.baud_spin.value())

        self.reader = SerialReader(port=port, baud=baud, num_pins=self.num_pins)
        self.reader.frameReady.connect(self.on_frame)
        self.reader.statusMsg.connect(self.on_status)
        self.reader.errorMsg.connect(self.on_error)
        self.reader.start()
        self.btn_start.setEnabled(False)
        self.btn_stop.setEnabled(True)
        self.status_label.setText("Reading… (Close window or press Stop to end)")

    def stop_acquire(self):
        if self.reader:
            self.reader.stop()
            self.reader.wait(1500)
            self.reader = None
        self.btn_start.setEnabled(True)
        self.btn_stop.setEnabled(False)
        self.status_label.setText("Stopped")

    @QtCore.pyqtSlot(object)
    def on_frame(self, frame: Frame):
        # Update buffers (guard against mismatched frame length)
        vals = frame.values
        if vals.size != self.num_pins:
            # ignore frames with unexpected size
            self.status_label.setText(f"Ignored frame with size {vals.size} (expected {self.num_pins})")
            return

        self.data_buffer[self.buf_idx, :] = vals
        self.time_buffer[self.buf_idx] = frame.t
        self.buf_idx = (self.buf_idx + 1) % self.buffer_size
        self.frames_seen += 1

        # Heatmap update (reshape NxN)
        try:
            heat = vals.reshape(self.grid_size, self.grid_size).T
        except Exception:
            heat = np.zeros((self.grid_size, self.grid_size))
        self.canvas.im.set_data(heat)
        if self.autoscale_chk.isChecked():
            self.canvas.im.autoscale()
        self.canvas.ax_heat.set_xticks(range(self.grid_size))
        self.canvas.ax_heat.set_yticks(range(self.grid_size))

        # FFT when buffer full (i.e., at least buffer_size frames have been seen)
        if self.frames_seen >= self.buffer_size:
            # Compute average dt -> Fs
            diffs = np.diff(self.time_buffer)
            # Handle wrap-around for circular buffer by ignoring zeros
            diffs = diffs[diffs > 0]
            if diffs.size > 0:
                Fs = 1.0 / np.mean(diffs)
            else:
                Fs = np.nan

            # Strongest (most dynamic) pin by std
            stds = np.std(self.data_buffer, axis=0)
            strongest_idx = int(np.argmax(stds))
            sig = self.data_buffer[:, strongest_idx]
            sig = sig - np.mean(sig)

            # FFT
            N = len(sig)
            Y = np.fft.rfft(sig)
            P1 = np.abs(Y) / N
            # Frequency axis up to Nyquist
            f = np.fft.rfftfreq(N, d=(1.0 / Fs) if Fs == Fs else 1.0)

            self.canvas.fft_line.set_data(f, P1)
            self.canvas.ax_fft.relim()
            self.canvas.ax_fft.autoscale_view()
            if Fs == Fs:
                self.canvas.ax_fft.set_xlim(0, Fs / 2)

            # Peak frequency
            if P1.size > 0 and f.size == P1.size:
                peak_i = int(np.argmax(P1))
                peak_f = float(f[peak_i]) if Fs == Fs else float("nan")
                self.canvas.text_obj.set_text(f"Peak Frequency: {peak_f:.2f} Hz\n(Fs: {Fs:.1f} Hz)\nStrongest pin: d{strongest_idx}")

        self.canvas.draw_idle()

    @QtCore.pyqtSlot(str)
    def on_status(self, msg: str):
        self.status_label.setText(msg)

    @QtCore.pyqtSlot(str)
    def on_error(self, msg: str):
        QMessageBox.critical(self, "Serial Error", msg)
        self.stop_acquire()

    def closeEvent(self, event):
        try:
            self.stop_acquire()
        finally:
            super().closeEvent(event)


def main():
    app = QApplication(sys.argv)
    w = MainWindow()
    w.show()
    sys.exit(app.exec_())


if __name__ == "__main__":
    main()