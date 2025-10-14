%% PSoC 5x5 SENSOR ARRAY VISUALIZER AND FREQUENCY ANALYZER - For Demo Day
% Script reads each sensor data from psoc, generates a heat map for
% intensity of signal and fft of the most intense signal
% Note: This will need to be updated to match the sensor array 

clear; clc; close all;

disp("Available serial ports:");
disp(serialportlist("available"));
port = "COM9";      
baud = 115200;    
terminator = "CR/LF";

GRID_SIZE = 5;
NUM_PINS = GRID_SIZE^2;
BUFFER_SIZE = 10; % samples for FFT analysis (increase this later)
data_buffer = zeros(BUFFER_SIZE, NUM_PINS); % FFT history
time_buffer = zeros(BUFFER_SIZE, 1); % Stores timestamps for Fs calculation
buffer_index = 1; 

%% Plots
fig = figure('Name', 'PSoC Sensor Array Analyzer', 'NumberTitle', 'off');
set(fig, 'Position', [100, 100, 1200, 600]); 

% Heatmap Plot
subplot(2, 2, [1, 3]);
h_heatmap = imagesc(zeros(GRID_SIZE, GRID_SIZE));
title('Live Sensor Array Signal Strength', 'FontSize', 14);
xlabel('Column');
ylabel('Row');
colorbar;
axis square;
set(gca, 'XTick', 1:GRID_SIZE, 'YTick', 1:GRID_SIZE, 'FontSize', 10);

% FFT Plot
subplot(2, 2, 2); 
h_fft_plot = plot(0, 0, 'LineWidth', 1.5);
title('Frequency Spectrum of Strongest Signal', 'FontSize', 14);
xlabel('Frequency (Hz)');
ylabel('Amplitude');
grid on;
xlim([0, 1]); 

% peak freq & sampling freq
subplot(2, 2, 4); 
axis off; 
h_text = text(0.5, 0.5, 'Waiting for data...', 'FontSize', 16, 'HorizontalAlignment', 'center');
xlim([0 1]);
ylim([0 1]);

disp('Starting live analysis. Close the figure to stop.');

try
    fprintf('Opening serial port %s...\n', port);
    s = serialport(port, baud);
    configureTerminator(s, terminator);
    
    tic; 

    while ishandle(fig)
        is_synced = false;
        line = "";
        while ~is_synced && ishandle(fig)
            line = readline(s);
            if (isstring(line) || ischar(line)) && startsWith(strtrim(line), "d0:")
                is_synced = true; 
            end
        end

        if ~ishandle(fig)
            break; 
        end 

        sensor_values = zeros(NUM_PINS, 1);
        read_count = 0;

        vals = sscanf(line, 'd%d:%f');
        if numel(vals) == 2 && vals(1) == 0
            sensor_values(1) = vals(2);
            read_count = 1;
        end

        for i = 2:NUM_PINS
            line = readline(s);
            if ~isstring(line) && ~ischar(line) || strlength(line) == 0
                fprintf('Warning: Readline timed out mid-frame.\n');
                break; 
            end
            
            vals = sscanf(line, 'd%d:%f');
            if numel(vals) == 2
                pin_idx = vals(1);
                pin_val = vals(2);
                if pin_idx > 0 && pin_idx < NUM_PINS % Expecting d1 to d24 (d25 is extra)
                    sensor_values(pin_idx + 1) = pin_val;
                    read_count = read_count + 1;
                else
                    fprintf('Warning: Unexpected pin index %d found mid-frame. Re-syncing.\n', pin_idx);
                    break; 
                end
            end
        end
        
        % process data once a full frame was recieved
        if read_count == NUM_PINS
            current_time = toc;
            data_buffer(buffer_index, :) = sensor_values';
            time_buffer(buffer_index) = current_time;
            
            % update heatmap
            heatmap_data = reshape(sensor_values, GRID_SIZE, GRID_SIZE)';
            set(h_heatmap, 'CData', heatmap_data);
            clim(h_heatmap.Parent, 'auto'); 
            
            % Do FFT once the buffer is full
            if buffer_index == BUFFER_SIZE
                avg_time_diff = mean(diff(time_buffer));
                Fs = 1 / avg_time_diff;
                
                % Find the sensor with the most dynamic signal (highest standard deviation)
                [~, strongest_pin_idx] = max(std(data_buffer));
                strongest_signal = data_buffer(:, strongest_pin_idx);
                
                % Remove DC offset before FFT
                signal_no_dc = strongest_signal - mean(strongest_signal);
                
                % FFT Calculation
                Y = fft(signal_no_dc);
                P2 = abs(Y / BUFFER_SIZE);
                P1 = P2(1:BUFFER_SIZE/2+1);
                P1(2:end-1) = 2*P1(2:end-1);
                f = Fs * (0:(BUFFER_SIZE/2)) / BUFFER_SIZE;

                set(h_fft_plot, 'XData', f, 'YData', P1);
                xlim(h_fft_plot.Parent, [0, Fs/2]); 
                
                % Find and display the peak frequency
                [~, idx] = max(P1);
                peak_frequency = f(idx);
                set(h_text, 'String', sprintf('Peak Frequency: %.2f Hz\n(Fs: %.1f Hz)', peak_frequency, Fs));
            end

            buffer_index = mod(buffer_index, BUFFER_SIZE) + 1;
            drawnow;
            
        else
            fprintf('Warning: Incomplete frame received (%d/%d values). Re-syncing...\n', read_count, NUM_PINS);
        end
    end
    
catch ME
    disp('Error or script cancelled. Closing serial port.');
    clear s;
    if ishandle(fig)
       close(fig);
    end
    rethrow(ME);
end

disp('Serial port closed.');

