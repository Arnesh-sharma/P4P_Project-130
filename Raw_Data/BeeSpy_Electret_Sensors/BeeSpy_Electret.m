% 1kHz with 8Vpp, 6cm spacing
files = dir('C:\Users\jpat614\Documents\GitHub\P4P_Project-130\Raw_Data\BeeSpy_Electret_Sensors\*.csv');
figure;
hold on;
length(files)
for i = 1:length(files)
    electret = readmatrix(files(i).name);
    time = electret(3:end, 1);
    voltage = electret(3:end,2);
    plot(time, voltage, 'DisplayName', files(i).name);
end

xlabel('Time (s)');
ylabel('Voltage (V)');
title('Electret BeeSpy');
legend();
grid on;