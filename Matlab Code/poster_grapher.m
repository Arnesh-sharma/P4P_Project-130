%% Poster I/O Plot + Time-Domain Gain (Colour Version)
clear; clc; close all;

% ---------- User settings ----------
csv_filename     = 'cry5_300.csv';   % your file
KNOWN_FREQ_HZ    = [];                  % [] = auto from Input, or set e.g. 15
TIME_WINDOW_SEC  = 0.5;                 % visible time span in seconds
EXPORT_FNAME_PNG = '300Hz_electret.png';

% ---------- Load ----------
T = readtable(csv_filename, 'VariableNamingRule','preserve');

% Find columns by name (case- and space-insensitive)
colSecond = find(strcmpi(strrep(T.Properties.VariableNames,' ','_'),'second'),1);
colInput  = find(strcmpi(strrep(T.Properties.VariableNames,' ','_'),'input'),1);
colOutput = find(strcmpi(strrep(T.Properties.VariableNames,' ','_'),'output'),1);
assert(~isempty(colSecond) && ~isempty(colInput) && ~isempty(colOutput), ...
    'Could not find columns named "second", "Input", "Output".');

t = double(T{:,colSecond});
u = double(T{:,colInput});
y = double(T{:,colOutput});

dt = median(diff(t));
Fs = 1/dt;
fprintf('Samples: %d | Fs = %.3f Hz\n', numel(t), Fs);

% ---------- Frequency handling ----------
if isempty(KNOWN_FREQ_HZ)
    % Estimate from input via autocorrelation
    u_d = u - mean(u);
    [r,lags] = xcorr(u_d,'coeff');
    lags_t = lags*dt;
    zix = find(lags_t>=0);
    r = r(zix); lags_t = lags_t(zix);
    [pks,locs] = findpeaks(r,'NPeaks',3);
    if isempty(locs) || locs(1)==1
        [~,loc] = max(r(min(find(lags_t>0,1)+1,numel(r)):end));
        loc = loc + min(find(lags_t>0,1));
    else
        loc = locs(1);
    end
    T_est = lags_t(loc);
    f_use = 1/T_est;
    fprintf('Estimated frequency from Input: %.3f Hz\n',f_use);
else
    f_use = KNOWN_FREQ_HZ;
    fprintf('Using known frequency: %.3f Hz\n',f_use);
end

% ---------- Amplitudes via sine fit ----------
Au = sine_amp_fit(u,t,f_use);
Ay = sine_amp_fit(y,t,f_use);
gain_lin = Ay / max(Au,eps);
gain_dB  = 20*log10(gain_lin);

fprintf('Input amp = %.4f V | Output amp = %.4f V | Gain = %.3f\n', ...
    Au, Ay, gain_lin);

% ---------- Plot styling (colour theme) ----------
t0 = t(1);
t1 = min(t0 + TIME_WINDOW_SEC, t(end));
idx = find(t >= t0 & t <= t1);
if numel(idx) < 2, idx = 1:min(2000, numel(t)); end

figure('Color', 'w');
%tiledlayout(1,1, 'Padding', 'compact', 'TileSpacing', 'compact');
tiledlayout(1,1, 'Padding', 'loose', 'TileSpacing', 'loose');
ax = nexttile;
hold(ax, 'on');
plot(ax, t(idx), u(idx), 'LineWidth', 1.8);
plot(ax, t(idx), y(idx), 'LineWidth', 1.8);

%figure('Color', 'w');                          % default white background
%hold on;

% Default MATLAB colour order handles Input/Output automatically
%plot(t(idx), u(idx), 'LineWidth', 1.8);
%plot(t(idx), y(idx), 'LineWidth', 1.8);

grid on; box on;
%set(gca, 'FontName', 'Arial', 'FontSize', 12);
set(gca, 'FontSize', 12, 'FontName', 'Times');
%xlabel('Time (s)', 'FontWeight','bold');
%ylabel('Voltage (V)', 'FontWeight','bold');
xlabel('Time (s)', 'Interpreter', 'latex');
ylabel('Voltage (V)', 'Interpreter', 'latex');
xlim([t(idx(1)) t(idx(end))]);

% Title and Legend (adjust as needed)
title('Crystal Oscillator Sensor 300Hz', 'FontWeight','bold', 'FontSize', 14);
%title('JFET Sensors', ...
%    'FontWeight','bold', 'FontSize', 14, ...
%    'Units', 'normalized', 'Position', [0.5, 1.08, 0]);
%legend({'JFET\_v2.csv', 'JFET\_v3.csv'}, ...
%       'FontWeight', 'bold', 'FontSize', 10, ...
%       'Location', 'northeast');
%legend({Output, Input}, 'Interpreter', 'latex');
fre
%title('Electret Sensor 300Hz (Zoomed)', 'FontWeight','bold');
legend({'Input','Output'}, 'Location','northeast');

%xlim([t(idx(1)) t(idx(end))]);

% --- Annotation box (white background for clarity) ---
xl = xlim; yl = ylim;
txt = sprintf('f = %.2f Hz   |   A_{in} = %.3f V   A_{out} = %.3f V   Gain = %.2f', ...
              f_use, Au, Ay, gain_lin);
text(xl(1) + 0.02*(xl(2)-xl(1)), yl(2) - 0.08*(yl(2)-yl(1)), txt, ...
     'FontWeight','bold', 'BackgroundColor',[1 1 1 0.85], 'Margin',6);

exportgraphics(gcf, EXPORT_FNAME_PNG, 'Resolution', 300);

% ---------- Save summary ----------
summary = table(f_use, Au, Ay, gain_lin, gain_dB, ...
    'VariableNames', {'Frequency_Hz','InputAmp_V','OutputAmp_V','Gain_linear','Gain_dB'});
writetable(summary, 'io_gain_summary.csv');
disp(summary);

%% --- Local function ---
function amp = sine_amp_fit(x,t,f)
    x = x(:)-mean(x);
    t = t(:);
    w = 2*pi*f;
    S = sin(w*t); C = cos(w*t);
    A = [S, C, ones(size(t))];
    p = A \ x;
    amp = hypot(p(1), p(2));
end
