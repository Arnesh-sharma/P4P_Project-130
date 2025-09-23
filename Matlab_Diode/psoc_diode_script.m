%% PSoC UART -> MATLAB Plot of ADC Step Differences
% This script collects a sweep of raw ADC data, 
% calculates the difference between the initial adc readings and new
% readings and plots the result

% --- Clean slate ---
clear; clc; close all;

% --- Configuration ---
disp("Available serial ports:");
disp(serialportlist("available"));

port = "COM7";      % <-- IMPORTANT: Change to your PSoC's COM port
baud = 115200;      % <-- IMPORTANT: Match your PSoC's UART baud rate
term = "CR/LF";     % Terminator for \r\n from PSoC
output_filename = 'baseline_data.mat'; % Name of the file to save

% --- Data Collection Parameters ---
IDAC_MAX_VALUE = 255; % The max IDAC value to test (0-255 for 8-bit)
NUM_STEPS = IDAC_MAX_VALUE + 1;

% --- Preallocate array for the raw data ---
raw_adc_results = zeros(NUM_STEPS, 1);

% --- Setup Serial Port and Collect Data ---
try
    fprintf('Opening serial port %s...\n', port);
    s = serialport(port, baud);
    configureTerminator(s, term);
    flush(s);

    fprintf('Collecting one full sweep of data (0 to %d)...\n', IDAC_MAX_VALUE);
    
    for idac_step = 0:IDAC_MAX_VALUE
        
        received_correct_step = false;
        while ~received_correct_step
            line = readline(s); % Read from PSoC
            vals = sscanf(line, 'IDAC Val: %f, Pin Val: %f');
    
            if numel(vals) == 2
                idac_val = round(vals(1));
                adc_val  = vals(2);

                % Check if this is the data point we're waiting for
                if idac_val == idac_step
                    raw_adc_results(idac_step + 1) = adc_val;
                    received_correct_step = true; % Exit inner loop and move to next step
                end
            else
                fprintf('Warning: Could not parse line: "%s"\n', strtrim(line));
            end
        end % End of while loop for a single step
        
        % Give live feedback to the user
        if mod(idac_step, 20) == 0
            fprintf('Collected data for IDAC value: %d/%d\n', idac_step, IDAC_MAX_VALUE);
        end

    end % End of for loop for the full sweep

    disp('Data collection complete.');
    save(output_filename, 'raw_adc_results');
    fprintf('\n✅ Baseline data successfully saved to %s\n', output_filename);
    clear s;
catch ME
    disp('Error or script cancelled. Closing serial port.');
    clear s;
    rethrow(ME);
end
