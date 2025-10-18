%% Back-calculate effective sampling rate using a known 50 Hz tone, then FFT
clear; clc; close all;

% ---------------- USER SETTINGS ----------------
CSV_FILE = 'beetest_5_out.csv';   % your CSV with columns d0..dK
LOGGED_CH_TO_USE = 1;             % 1 = d0, 2 = d1, etc. Pick the cleanest channel
ADC_SPS  = 7691;                  % from PSoC config (Sample rate (SPS))
NSEQ     = 13;                    % SAR sequencer channels configured
KNOWN_TONE_HZ = 50;               % known present tone
FMAX_PLOT_HZ  = 500;              % limit for plotting
% ------------------------------------------------

%% Load CSV and rebuild per-channel series (one sample per scan)
T = readtable(CSV_FILE, 'VariableNamingRule','preserve');
is_dcol = startsWith(T.Properties.VariableNames,'d','IgnoreCase',true) ...
       & ~isnan(str2double(erase(T.Properties.VariableNames,'d')));
assert(any(is_dcol), 'No d0..dN columns found.');
D = T{:,is_dcol};
ch_names = T.Properties.VariableNames(is_dcol);
n_logged = size(D,2);

num_valid_cells  = nnz(~isnan(D));
n_scans          = floor(num_valid_cells / n_logged);

Y = zeros(n_scans, n_logged);
for k = 1:n_logged
    v = D(:,k); v = v(~isnan(v));
    if numel(v) < n_scans, v(end+1:n_scans,1) = v(end); end
    Y(:,k) = v(1:n_scans);
end

y = double(Y(:, LOGGED_CH_TO_USE));
y = y - mean(y);     % remove DC

% Theoretical per-scan Fs (if nothing was dropped)
Fs_theory = ADC_SPS / NSEQ;

fprintf('CSV: %s | Logged channels: %d | Samples per channel: %d\n', ...
    CSV_FILE, n_logged, n_scans);
fprintf('Theoretical Fs_scan = ADC_SPS/NSEQ = %.6f Hz\n', Fs_theory);

%% Method A: Interpolated-FFT peak alignment to 50 Hz
% (zero-pad + Hann window + parabolic interpolation on peak)
N = numel(y);
w = hann(N);
Nfft = 2^nextpow2(N*2);                   % modest zero padding
Yf = fft(y .* w, Nfft);
f  = (0:Nfft-1)/Nfft * Fs_theory;
half = 1:floor(Nfft/2);
mag = abs(Yf(half));
f1  = f(half);

% find max near expected 50 Hz window (±20%)
f_lo = 0.8*KNOWN_TONE_HZ; f_hi = 1.2*KNOWN_TONE_HZ;
[~, idx_win_lo] = min(abs(f1 - f_lo));
[~, idx_win_hi] = min(abs(f1 - f_hi));
[~, idx_local]  = max(mag(idx_win_lo:idx_win_hi));
idx = idx_win_lo + idx_local - 1;

% parabolic interpolation around idx (k-1,k,k+1 bins) for better peak freq
if idx>1 && idx < numel(mag)
    alpha = mag(idx-1); beta = mag(idx); gamma = mag(idx+1);
    p = 0.5*(alpha - gamma)/(alpha - 2*beta + gamma); % bin offset
    f_peak = f1(idx) + p*(f1(2)-f1(1));
else
    f_peak = f1(idx);
end
scale_factor_A = KNOWN_TONE_HZ / max(f_peak, eps);
Fs_est_A = Fs_theory * scale_factor_A;

%% Method B: Phase-slope (Hilbert) estimate of Fs
% analytic signal -> unwrap phase -> slope (rad/sample) = 2*pi*f / Fs
z = hilbert(y);
phi = unwrap(angle(z));
n = (0:N-1).';
% Restrict fit around the tone by pre-filtering a bit to reduce noise/leakage
% (simple bandpass around 50 Hz using a short FIR)
bp = designfilt('bandpassfir','FilterOrder',100, ...
    'CutoffFrequency1', KNOWN_TONE_HZ*0.6, ...
    'CutoffFrequency2', KNOWN_TONE_HZ*1.4, ...
    'SampleRate', Fs_theory);
y_bp = filtfilt(bp, y);
z_bp = hilbert(y_bp);
phi_bp = unwrap(angle(z_bp));

% Linear regression: phi_bp = a*n + b
A = [n, ones(N,1)];
ab = A \ phi_bp;              % least-squares
slope_rad_per_sample = ab(0+1);   % a
Fs_est_B = (2*pi*KNOWN_TONE_HZ) / max(slope_rad_per_sample, eps);

%% Optional: drift estimate over sliding windows (phase-slope)
win = round(5*Fs_theory);             % 5-second windows (on theoretical Fs)
step = round(2.5*Fs_theory);          % 50% overlap
idxs = 1:step:(N-win);
Fs_local = nan(size(idxs));
for i = 1:numel(idxs)
    ii = idxs(i):(idxs(i)+win-1);
    if ii(end) > N, break; end
    nn = (ii - ii(1)).';
    Awin = [nn, ones(numel(nn),1)];
    abw = Awin \ phi_bp(ii);
    slope_w = abw(1);
    Fs_local(i) = (2*pi*KNOWN_TONE_HZ) / max(slope_w, eps);
end

%% Pick a final Fs (average the two methods; they usually agree closely)
Fs_final = mean([Fs_est_A, Fs_est_B], 'omitnan');

fprintf('\nKnown tone: %.3f Hz\n', KNOWN_TONE_HZ);
fprintf('Peak-align estimate: Fs_A = %.6f Hz (f_peak@theory = %.3f Hz)\n', Fs_est_A, f_peak);
fprintf('Phase-slope estimate: Fs_B = %.6f Hz\n', Fs_est_B);
if any(~isnan(Fs_local))
    fprintf('Drift (phase-slope, min..max): [%.6f .. %.6f] Hz\n', ...
        min(Fs_local,[],'omitnan'), max(Fs_local,[],'omitnan'));
end
fprintf('Chosen Fs_final = %.6f Hz\n', Fs_final);

%% Recompute FFT with Fs_final (clean, single-sided)
Nfft2 = 2^nextpow2(N*2);
Yf2 = fft(y .* w, Nfft2);
f2  = (0:Nfft2-1)/Nfft2 * Fs_final;
half2 = 1:floor(Nfft2/2);
mag2  = abs(Yf2(half2)) / (sum(w)/2);   % approx amplitude correction
f2s   = f2(half2);

% Plots
figure('Name','Time series (corrected timebase)');
t = (0:N-1).'/Fs_final;
plot(t, y); grid on;
xlabel('Time (s)'); ylabel('Amplitude (codes)');
title(sprintf('%s (Fs_{final}=%.6f Hz, N=%d)', ch_names{LOGGED_CH_TO_USE}, Fs_final, N), ...
    'Interpreter','none');

figure('Name','FFT with corrected Fs');
plot(f2s, mag2); grid on;
xlim([0, FMAX_PLOT_HZ]);
xlabel('Frequency (Hz)'); ylabel('|Y(f)| (approx)');
title(sprintf('Single-sided FFT (Fs_{final}=%.6f Hz)', Fs_final));

% Show local-Fs drift if computed
if any(~isnan(Fs_local))
    figure('Name','Estimated Fs drift (phase-slope, sliding windows)');
    tt = (idxs-1)/Fs_theory;
    plot(tt, Fs_local, '.-'); grid on;
    xlabel('Time (s, theory scale)'); ylabel('Fs estimate (Hz)');
    title('Local effective Fs via phase-slope');
end
