clear
clc
close all

scriptFolder = fileparts(mfilename('fullpath'));
dataFile = fullfile(scriptFolder, '..', 'data', 'workspace_project_1.mat');
load(dataFile);

Ts = time(2) - time(1)
time(1:10)
diff(time(1:10))
Ts = mean(diff(time)) %sampling period
%через сколько секунд записывается следующая точка, а не сколько длится весь эксперимент

figure
plot(time,Vpos)
hold on
plot(time,Vacc)
hold off

legend ('Position sensor', 'Acceleration sensor')
xlabel("Time (s)")
ylabel("Voltage (V)")
grid on

position = 3.00*(Vpos - 0.5);
acceleration = 5.09*(Vacc - 0.1);

figure
plot(time, position)
hold on
plot(time, acceleration)
hold off

xlabel('Time (s)')
ylabel('Measured value')
legend('Position (cm)', 'Acceleration (G)')
title('Converted Experimental Data')
grid on

% Low-frequency motion (0.5 Hz)
% High-frequency motion (5 Hz)
positionLow = position(1:2001);
accelerationLow = acceleration(1:2001);

positionHigh = position(4001:6001);
accelerationHigh = acceleration(4001:6001);

v = [0: 0.0050: 10]

size(v)
size(positionLow)
size(positionHigh)
size(accelerationLow)
size(accelerationHigh)
length(v)
length(positionLow)

timeLow = time(1:2001);
timeHigh = time(4001:6001);

figure
plot(timeLow, positionLow)
hold on
plot(timeHigh, positionHigh)
hold off
legend('Low-frequency', 'High-frequency')
xlabel('Time (s)')
ylabel('Position (cm)')
title('Position: Low vs High Frequency Motion')
grid on

figure
plot(timeLow, accelerationLow)
hold on
plot(timeHigh, accelerationHigh)
hold off
legend('Low-frequency', 'High-frequency')
xlabel('Time (s)')
ylabel('Acceleration (G)')
title('Acceleration: Low vs High Frequency Motion')
grid on

%Calculation the root-mean-square (RMS) of the position and acceleration vectors for the low and high-frequency tests. The RMS is a common way to measure the overall strength or power of periodic signals.
positionLow2=positionLow.^2
positionLowMean = mean(positionLow2)
posLowRMS = sqrt(positionLowMean)

posHighRMS = sqrt(mean(positionHigh.^2))
accLowRMS = sqrt(mean(accelerationLow.^2))
accHighRMS = sqrt(mean(accelerationHigh.^2))

%Using concatenation to create three vectors, each with two elements
frequency = [0.5 5]
positionRMS = [posLowRMS posHighRMS]
accelerationRMS = [accLowRMS accHighRMS]

figure
plot(frequency, positionRMS, '-o')
xlabel('Frequency (Hz)')
ylabel('Position RMS (cm)')
title('Position RMS versus Frequency')
grid on

figure
plot(frequency, accelerationRMS, '-o')
xlabel('Frequency (Hz)')
ylabel('Acceleration RMS (G)')
title('Acceleration RMS versus Frequency')
grid on


%in one graph 
figure
plot(frequency, positionRMS, '-o')
hold on
plot(frequency, accelerationRMS, '-o')
hold off
legend('Position RMS', 'Acceleration RMS')
xlabel('Frequency (Hz)')
ylabel('RMS')
title('RMS versus Frequency')
grid on

%Standard deviation
posLowSTD = std(positionLow);
posHighSTD = std(positionHigh);
accLowSTD = std(accelerationLow);
accHighSTD = std(accelerationHigh);

posLowSTD
posHighSTD
accLowSTD
accHighSTD

%Peak-to-peak amplitude
posLowP2P = max(positionLow) - min(positionLow);
posHighP2P = max(positionHigh) - min(positionHigh);
accLowP2P = max(accelerationLow) - min(accelerationLow);
accHighP2P = max(accelerationHigh) - min(accelerationHigh);

posLowP2P
posHighP2P
accLowP2P
accHighP2P

%Compare ride quality through acceleration
%To compare ride quality, the acceleration response was analyzed for both test frequencies. Since ride comfort is strongly related to vibration level, larger acceleration values indicate poorer ride quality. The results show that the 5 Hz test has significantly higher acceleration RMS, standard deviation, and peak-to-peak amplitude than the 0.5 Hz test. This indicates that the suspension experiences stronger dynamic excitation at the higher frequency, leading to worse ride quality.
