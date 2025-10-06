%% PSoC 5x5 SENSOR ARRAY VISUALIZER AND FREQUENCY ANALYZER
% This script reads data from a 5x5 sensor array connected to a PSoC via
% UART. It displays the live signal strength on a 5x5 heatmap and
% calculates the dominant frequency of the signal from the sensor that is
% detecting the strongest signal.

clear; clc; close all;

% --- Configuration ---
disp("Available serial ports:");
disp(serialportlist("available"));

port = "COM7";      % <-- IMPORTANT: Change to your PSoC's COM port
baud = 115200;      % <-- IMPORTANT: Match your PSoC's UART baud rate
terminator = "CR/LF"; 
% output_filename = 'baseline_data.mat'; % Name of the file to save

% --- Sensor Array ---
GRID_SIZE = 5; % 5x5 grid
NUM_PINS = GRID_SIZE^2; % Total number of sensors/pins
BUFFER_SIZE = 512; % Number of samples to store for FFT analysis, make this larger for better res

% --- Data Buffers ---
% Preallocate a buffer to store a history of readings for frequency analysis
data_buffer = zeros(BUFFER_SIZE, NUM_PINS);
time_buffer = zeros(BUFFER_SIZE, 1); % To calculate sampling rate
buffer_index = 1; % Current position in the buffer

% --- Setup the Figure and Plots ---
fig = figure('Name', 'PSoC Sensor Array Analyzer', 'NumberTitle', 'off');
set(fig, 'Position', [100, 100, 1000, 600]); % Set figure size

% --- PLOT 1: Live Heatmap for Signal Strength ---
subplot(2, 2, [1, 3]);
h_heatmap = imagesc(zeros(GRID_SIZE, GRID_SIZE));
title('Live Sensor Array Signal Strength');
xlabel('Column');
ylabel('Row');
colorbar; 
axis square; 
set(gca, 'XTick', 1:GRID_SIZE, 'YTick', 1:GRID_SIZE);

% --- PLOT 2: Frequency Spectrum (FFT) ---
subplot(2, 2, 2); % Top right
h_fft_plot = plot(0, 0);
title('Frequency Spectrum of Strongest Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;

subplot(2, 2, 4); % Bottom right
axis off; % Turn off axes for text display
h_text = text(0.5, 0.5, 'Peak Frequency: -- Hz', 'FontSize', 16, 'HorizontalAlignment', 'center');
xlim([0 1]);
ylim([0 1]);

disp('Starting live analysis. Press Ctrl+C in the Command Window to stop.');
fprintf('Expecting comma-separated data for %d pins, e.g., "val1,val2,...,val25\\r\\n"\n', NUM_PINS); %adjust the psoc uart code for this

try
    fprintf('Opening serial port %s...\n', port);
    s = serialport(port, baud);
    configureTerminator(s, term);
    flush(s);

    tic; % time tracking
    while ishandle(fig)
        line = readline(s);
        try
            % sscanf reads the comma-separated string into a column vector
            sensor_values = sscanf(line, '%f,');
            
            if numel(sensor_values) == NUM_PINS
                
                % Store data in buffer
                current_time = toc; % time of sample
                data_buffer(buffer_index, :) = sensor_values';
                time_buffer(buffer_index) = current_time;
                
                % Update Heat Map
                % Reshape the 1x25 vector into a 5x5 matrix for the
                % heatmap, I need to double check is the match up 
                heatmap_data = reshape(sensor_values, GRID_SIZE, GRID_SIZE)';
                set(h_heatmap, 'CData', heatmap_data);
                
                % Update colour axis
                % caxis(h_heatmap.Parent, [min(sensor_values), max(sensor_values)]);
                
                % Analyse Freq
                if buffer_index == BUFFER_SIZE
                    
                    % calculate sampling freq
                    % Average time difference between samples
                    avg_time_diff = mean(diff(time_buffer));
                    Fs = 1 / avg_time_diff;
                    
                    % find sensor with strongest signal, 
                    % use the one with the highest standard deviation
                    [~, strongest_pin_idx] = max(std(data_buffer));
                    strongest_signal = data_buffer(:, strongest_pin_idx);
                    
                    % FFT
                    %remove DC component by subtracting mean
                    signal_no_dc = strongest_signal - mean(strongest_signal);
                    Y = fft(signal_no_dc);
                    
                    % Calculate the two-sided spectrum P2, then the single-sided spectrum P1
                    P2 = abs(Y / BUFFER_SIZE);
                    P1 = P2(1:BUFFER_SIZE/2+1);
                    P1(2:end-1) = 2*P1(2:end-1);
                    
                    % Define the frequency domain f
                    f = Fs * (0:(BUFFER_SIZE/2)) / BUFFER_SIZE;
                    
                    % Update FFT Plot
                    set(h_fft_plot, 'XData', f, 'YData', P1);
                    xlim(h_fft_plot.Parent, [0, Fs/2]); % Display up to Nyquist frequency
                    
                    % Display Peak Freq
                    [max_magnitude, idx] = max(P1);
                    peak_frequency = f(idx);
                    
                    set(h_text, 'String', sprintf('Peak Frequency: %.2f Hz\n(Fs: %.2f Hz)', peak_frequency, Fs));
                    
                end
                
                % update buffer index
                buffer_index = mod(buffer_index, BUFFER_SIZE) + 1;
                
                % update plots
                drawnow limitrate;
            else
                fprintf('Warning: Expected %d values, but received %d. Line: "%s"\n', NUM_PINS, numel(sensor_values), strtrim(line));
            end
        catch parse_err
             fprintf('Error parsing line: "%s". Error: %s\n', strtrim(line), parse_err.message);
        end
    end
catch ME
    disp('Error or script cancelled. Closing serial port.');
    clear s;
    if isvalid(fig)
       close(fig);
    end
    % Rethrow error if it wasn't a manual stop
    if ~strcmp(ME.identifier, 'MATLAB:serialport:readline:OperationTerminated') && ...
       ~strcmp(ME.identifier, 'MATLAB:class:InvalidHandle')
        rethrow(ME);
    end
end


