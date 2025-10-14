%% PLOT LIVE ADC DATA (DIFFERENCE AND RAW)
% Note: Run the psoc diode script first to get baseline data
% script plots the different between current reading and a pre-recorded
% baseline, and the transfer curve (ADC value vs IDAC step)

clear; clc; close all;

port = "COM7";      
baud = 115200;     
term = "CR/LF";     
baseline_filename = 'baseline_data.mat';
IDAC_MAX_VALUE = 255;
NUM_STEPS = IDAC_MAX_VALUE + 1;

try
    fprintf('Loading baseline data from %s...\n', baseline_filename);
    loaded_data = load(baseline_filename);
    baseline_adc_results = loaded_data.raw_adc_results;
    disp('Baseline loaded successfully.');
catch
    error('Could not load baseline file: %s.', baseline_filename);
end

%% Plot
figure; 
% Difference Plot
subplot(2, 1, 1);
hPlot1 = plot(0:IDAC_MAX_VALUE, zeros(NUM_STEPS, 1), '.-');
grid on;
title('Live Difference from Baseline');
xlabel('IDAC Step Value');
ylabel('ADC Difference (Current - Baseline)');
xlim([0 IDAC_MAX_VALUE]);

% transfer curve
subplot(2, 1, 2); 
hPlot2 = plot(zeros(NUM_STEPS, 1), 0:IDAC_MAX_VALUE, '.-');
grid on;
title('Live ADC Transfer Curve');
xlabel('ADC Value (Counts)');
ylabel('IDAC Step Value');
ylim([0 IDAC_MAX_VALUE]);

% setup serial 
try
    s = serialport(port, baud);
    configureTerminator(s, term);
    
    current_adc_results = zeros(NUM_STEPS, 1);

    while true
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
        adc_difference = current_adc_results - baseline_adc_results;

        set(hPlot1, 'YData', adc_difference);      
        set(hPlot2, 'XData', current_adc_results); 

        drawnow;
    end
    
    % Save the results
    save('current_adc_results.mat', 'current_adc_results');

catch ME
    disp('Script stopped. Closing serial port.');
    clear s;
    if ~strcmp(ME.identifier, 'MATLAB:serialport:readline:OperationTerminated')
        rethrow(ME);
    end
end