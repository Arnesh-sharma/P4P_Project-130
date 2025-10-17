%% Multi-file Bode Plot
clear; clc; close all;

data_folder = uigetdir(pwd, 'D:\');

if data_folder == 0
    disp('User cancelled operation.');
    return;
end

csv_files   = dir(fullfile(data_folder, 'WFM*.csv'));

figure('Color','w'); hold on;
title('Bode Magnitude Plot');
xlabel('Frequency (Hz)');
ylabel('Gain (dB)');
grid on;

for k = 1:length(csv_files)
    T = readtable(fullfile(data_folder, csv_files(k).name), 'VariableNamingRule', 'preserve');

    % get columns
    freq_col = find(contains(lower(T.Properties.VariableNames), 'frequency in hz'), 1);
    gain_col = find(contains(lower(T.Properties.VariableNames), 'gain in db'));
    
    if isempty(freq_col) || isempty(gain_col)
        warning('Could not find freq/gain columns in %s', csv_files(k).name);
        continue;
    end

    freq = T{:,freq_col};
    gain = T{:,gain_col};

    plot(freq, gain, 'LineWidth', 1.4, 'DisplayName', csv_files(k).name);
end

legend('Location','best');
set(gca, 'XScale','log');
box on;
