%% plot_beetest_line_segments.m
clear; clc; close all;

T = readtable('beetest_5_out.csv','PreserveVariableNames',true);
Y = str2double(string(table2array(T)));   % force numeric
t = (1:size(Y,1))';
names = T.Properties.VariableNames;

figure('Color','w');
for k = 1:size(Y,2)
    subplot(size(Y,2),1,k);
    idx = ~isnan(Y(:,k));                 % valid rows for this channel
    plot(t(idx), Y(idx,k), '-', 'LineWidth', 0.6);   % <-- line over valid points
    grid on; ylabel(names{k}); xlim([t(1), t(end)]);
    % optional: downsample if too dense
    % ds = 5; plot(t(idx)(1:ds:end), Y(idx,k)(1:ds:end), '-', 'LineWidth', 0.6);
end
xlabel('Sample Index');
sgtitle('Bee Sensor Readings per Channel (Line)');
