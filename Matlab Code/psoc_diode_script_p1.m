%% Collect baseline data for diode circuit 
% Script collects a sweep of raw ADC data, and stores in file

clear; clc; close all;

disp("Available serial ports:");
disp(serialportlist("available"));

port = "COM7";      
baud = 115200;      
term = "CR/LF";     
output_filename = 'baseline_data.mat'; 

IDAC_MAX_VALUE = 255; 
NUM_STEPS = IDAC_MAX_VALUE + 1;

raw_adc_results = zeros(NUM_STEPS, 1);

% setup serial
try
    fprintf('Opening serial port %s...\n', port);
    s = serialport(port, baud);
    configureTerminator(s, term);
    flush(s);

    fprintf('Collecting one full sweep of data (0 to %d)...\n', IDAC_MAX_VALUE);
    
    for idac_step = 0:IDAC_MAX_VALUE
        
        received_correct_step = false;
        while ~received_correct_step
            line = readline(s); 
            vals = sscanf(line, 'IDAC Val: %f, Pin Val: %f');
    
            if numel(vals) == 2
                idac_val = round(vals(1));
                adc_val  = vals(2);

                % Check if this is the data point we're waiting for
                if idac_val == idac_step
                    raw_adc_results(idac_step + 1) = adc_val;
                    received_correct_step = true;
                end
            else
                fprintf('Warning: Could not parse line: "%s"\n', strtrim(line));
            end
        end 

        if mod(idac_step, 20) == 0
            fprintf('Collected data for IDAC value: %d/%d\n', idac_step, IDAC_MAX_VALUE);
        end
    end 

    disp('Data collection complete.');
    save(output_filename, 'raw_adc_results');
    fprintf('Baseline data successfully saved to %s\n', output_filename);
    clear s;
catch ME
    disp('Error or script cancelled. Closing serial port.');
    clear s;
    rethrow(ME);
end
