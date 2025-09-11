%% PSoC UART -> MATLAB LIVE plot (ADC vs IDAC)
% This script reads serial data and updates a plot in real-time.

% --- Clean slate ---
clear; clc; close all;

% --- Configuration ---
disp("Available serial ports:");
disp(serialportlist("available"));

port = "COM9";      % <-- IMPORTANT: Change to your PSoC's COM port
baud = 115200;      % <-- IMPORTANT: Match your PSoC's UART baud rate
term = "CR/LF";     % Terminator for \r\n from PSoC

% --- Plotting Setup ---
figure('Color', 'w', 'Name', 'PSoC Live Data');
ax = gca; % Get current axes handle
grid on;
box on;
xlabel('IDAC Value (counts)');
ylabel('ADC Value (counts)');
title('Live ADC vs. IDAC Response');

% Create an animated line object for efficient live plotting
h = animatedline(ax, 'Marker', 'o', 'LineStyle', 'none', 'Color', [0 0.4470 0.7410]);
legend('Live Data');

% --- Setup Serial Port Communication ---
try
    fprintf('Opening serial port %s...\n', port);
    s = serialport(port, baud);
    configureTerminator(s, term);
    flush(s);

    disp('Starting live plot. Press Ctrl+C in the Command Window to stop.');
    
    % Loop indefinitely until stopped by the user
    while ishandle(h) % Loop while the plot figure is open
        line = readline(s);
        
        vals = sscanf(line, 'IDAC Val: %f, Pin Val: %f');
        %vals = sscanf(line, '%f, %f');

        if numel(vals) == 2
            idac_val = vals(1);
            adc_val  = vals(2);
            
            % Add the new, raw data point to the animated line
            addpoints(h, idac_val, adc_val);
            
            % Update the plot window to show the new point
            drawnow limitrate; % 'limitrate' prevents it from trying to draw too fast
        else
            fprintf('Warning: Could not parse line: "%s"\n', strtrim(line));
        end
    end

    disp('Plot window closed. Stopping data collection.');
    clear s;

catch ME
    disp('Error or script cancelled. Closing serial port.');
    clear s;
    rethrow(ME);
end