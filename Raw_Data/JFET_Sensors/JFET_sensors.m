% 1kHz with 8Vpp, 6cm spacing
files = dir('C:\Users\jpat614\Documents\GitHub\P4P_Project-130\Raw_Data\JFET_Sensors\*.csv');
figure;
hold on;
for i = 1:length(files)
    sensor = readmatrix(files(i).name);
    time = sensor(3:end, 1);
    voltage = sensor(3:end,2);
    plot(time, voltage, 'DisplayName', files(i).name, 'LineWidth', 2);
end

grid on;
xlabel('Time (s)', 'Interpreter', 'latex');
ylabel('Voltage (V)', 'Interpreter', 'latex');
title('JFET Sensors');
legend('Interpreter', 'latex');
set(gca, 'FontSize', 24, 'FontName', 'Times');