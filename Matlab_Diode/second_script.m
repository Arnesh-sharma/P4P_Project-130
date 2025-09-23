%% PLOT LIVE ADC DATA (DIFFERENCE AND RAW)
% This script continuously collects ADC data and displays two live plots:
% 1. The difference between the current reading and a pre-recorded baseline.
% 2. The live ADC transfer curve (ADC value vs. IDAC step).

% --- Clean slate ---
clear; clc; close all;

% --- Configuration ---
port = "COM7";      % <-- IMPORTANT: Change to your PSoC's COM port
baud = 115200;      % <-- IMPORTANT: Match your PSoC's UART baud rate
term = "CR/LF";     % Terminator for \r\n from PSoC
baseline_filename = 'baseline_data.mat'; % The baseline file to load

% --- Data Collection Parameters ---
IDAC_MAX_VALUE = 255;
NUM_STEPS = IDAC_MAX_VALUE + 1;

% --- Load the Baseline Data ---
try
    fprintf('Loading baseline data from %s...\n', baseline_filename);
    loaded_data = load(baseline_filename);
    baseline_adc_results = loaded_data.raw_adc_results;
    disp('✅ Baseline loaded successfully.');
catch
    error('Could not load baseline file: %s.', baseline_filename);
end

% --- Setup Plot for Live Updating ---
figure; % Create a single figure window

% --- PLOT 1: Difference from Baseline ---
subplot(2, 1, 1); % Create the top subplot (2 rows, 1 column, 1st plot)
hPlot1 = plot(0:IDAC_MAX_VALUE, zeros(NUM_STEPS, 1), '.-');
grid on;
title('Live Difference from Baseline');
xlabel('IDAC Step Value');
ylabel('ADC Difference (Current - Baseline)');
xlim([0 IDAC_MAX_VALUE]);

% --- PLOT 2: Live ADC Transfer Curve ---
subplot(2, 1, 2); % Create the bottom subplot (2 rows, 1 column, 2nd plot)
hPlot2 = plot(zeros(NUM_STEPS, 1), 0:IDAC_MAX_VALUE, '.-');
grid on;
title('Live ADC Transfer Curve');
xlabel('ADC Value (Counts)');
ylabel('IDAC Step Value');
ylim([0 IDAC_MAX_VALUE]);

disp('Starting live plotting. Press Ctrl+C in the Command Window to stop.');

% --- Setup Serial Port and Start Live Collection ---
try
    s = serialport(port, baud);
    configureTerminator(s, term);
    
    current_adc_results = zeros(NUM_STEPS, 1);

    % --- Main Loop for Continuous Plotting ---
    while true % Loop forever until stopped with Ctrl+C
        flush(s);
        fprintf('Collecting new sweep...\n');

        for idac_step = 0:IDAC_MAX_VALUE
            received_correct_step = false;
            while ~received_correct_step
                line = readline(s);
                vals = sscanf(line, 'IDAC Val: %f, Pin Val: %f');
                if numel(vals) == 2 && round(vals(1)) == idac_step
                    current_adc_results(idac_step + 1) = vals(2);
                    received_correct_step = true;
                end
            end
        end

        % --- Analysis and Plotting ---
        adc_difference = current_adc_results - baseline_adc_results;

        % NOTE: Saving the file inside this fast loop is not recommended
        % as it can cause performance issues. Consider moving it outside
        % the loop if you only need the final result.
        save('current_adc_results.mat', 'current_adc_results');

        % Update both plots with the new data
        set(hPlot1, 'YData', adc_difference);      % Update the difference plot
        set(hPlot2, 'XData', current_adc_results); % Update the transfer curve plot
        
        % Force MATLAB to draw the updated plots
        drawnow;
    end
    
catch ME
    disp('Script stopped. Closing serial port.');
    clear s;
    if ~strcmp(ME.identifier, 'MATLAB:serialport:readline:OperationTerminated')
        rethrow(ME);
    end
end