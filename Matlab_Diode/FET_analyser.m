%% 6-CHANNEL FET PLOTTER
% Script reads uart values from the psoc and plot them in real-time
% Use https://sekigon-gonnoc.github.io/web-serial-plotter/ does the same
% thing

% --- Clean slate ---
clear; clc; close all;

disp("Available serial ports:");
disp(serialportlist("available"));

port = "COM9";   
baud = 57600;       
term = "CR/LF";     
NUM_CHANNELS = 6;               
ADC_RESOLUTION = 10;            
V_REF = 5.0;                    
PLOT_WINDOW = 10;               

% Conversion factor from raw ADC value to voltage
max_adc_val = 2^ADC_RESOLUTION - 1;
adc_to_voltage_factor = V_REF / max_adc_val;

% Initialize empty buffers to store the data for plotting
time_data = [];
voltage_data = [];

fig = figure('Name', 'Live ADC Voltage Readings', 'NumberTitle', 'off');
hold on; 
grid on;
title('Live ADC Readings');
xlabel('Time (s)');
ylabel('Voltage (V)');
h_plots = gobjects(NUM_CHANNELS, 1); 
colors = lines(NUM_CHANNELS); 
legend_labels = cell(NUM_CHANNELS, 1);

for i = 1:NUM_CHANNELS
    h_plots(i) = plot(NaN, NaN, 'Color', colors(i,:), 'LineWidth', 1.5);
    legend_labels{i} = sprintf('Channel %d', i);
end
legend(legend_labels, 'Location', 'northeast');
hold off;

disp('Starting live plotting.');

try
    s = serialport(port, baud);
    configureTerminator(s, term);
    
    tic; % timer to measure elapsed

    while ishandle(fig)
        line = readline(s);
        
        if ~isstring(line) && ~ischar(line)
            continue;
        end
       
        try
            raw_adc_values = sscanf(line, '%f,');

            if numel(raw_adc_values) == NUM_CHANNELS
                
                current_time = toc;
                current_voltages = raw_adc_values * adc_to_voltage_factor;
                
                time_data = [time_data; current_time];
                voltage_data = [voltage_data; current_voltages']; 
                
                first_visible_index = find(time_data >= (current_time - PLOT_WINDOW), 1);
                time_data = time_data(first_visible_index:end);
                voltage_data = voltage_data(first_visible_index:end, :);
                
                % update plots
                for i = 1:NUM_CHANNELS
                    set(h_plots(i), 'XData', time_data, 'YData', voltage_data(:, i));
                end
                xlim([current_time - PLOT_WINDOW, current_time]);
                drawnow limitrate; 
            else
                fprintf('Warning: Expected %d values, but received %d. Line: "%s"\n', NUM_CHANNELS, numel(raw_adc_values), strtrim(line));
            end
        catch parse_err
             fprintf('Error parsing line: "%s". Error: %s\n', strtrim(line), parse_err.message);
        end
    end
    
catch ME
    disp('Script stopped or error occurred. Closing serial port.');
    if ~strcmp(ME.identifier, 'MATLAB:serialport:readline:OperationTerminated') && ...
       ~strcmp(ME.identifier, 'MATLAB:class:InvalidHandle')
        rethrow(ME);
    end
end

clear s;
disp('Serial port closed.');

