%Arduino Hardware Package 
%Arduino Uno w/ HC-SR04 Ultra-Sonic Distance Sensor

%Developer: Gabriel Smith

clear 
close all

%% Arduino Ultrasonic Distance 
%Constant specifications
port = 'COM3'; %ensure correct com port
board = 'Uno';
trigPin = 'D10';
echoPin = 'D9';
redPin = 'D7';
yellowPin = 'D12';
greenPin = 'D8';
pinMode = 'DigitalOutput';

N = 150;     %number of data-points to take (iterations)
L = 5;       %window size for moving average filter

x = 1:N;
y = zeros(1, N); 
y_filt = zeros(1, N);
h = animatedline;
ard = arduino(port, board);

%constants for moving average (filter())
b = ones(1, L)/L;
a = 1;

configurePin(ard, redPin, pinMode);
configurePin(ard, yellowPin, pinMode);
configurePin(ard, greenPin, pinMode);

ultrasonicObj = ultrasonic(ard, trigPin, echoPin);

for i = 1:N
    y(i) = readDistance(ultrasonicObj);
    xlabel('Iteration');
    ylabel('Distance (meters)');
    addpoints(h, x(i), y(i));
    drawnow;
    
    if y(i) > 1
        writeDigitalPin(ard, greenPin, 1);
        writeDigitalPin(ard, yellowPin, 0);
        writeDigitalPin(ard, redPin, 0);
    elseif y(i) > 0.5 && y(i) < 0.9
        writeDigitalPin(ard, greenPin, 0);
        writeDigitalPin(ard, yellowPin, 1);
        writeDigitalPin(ard, redPin, 0);
    else
        writeDigitalPin(ard, greenPin, 0);
        writeDigitalPin(ard, yellowPin, 0);
        writeDigitalPin(ard, redPin, 1);
    end 

end

writeDigitalPin(ard, greenPin, 0);
writeDigitalPin(ard, yellowPin, 0);
writeDigitalPin(ard, redPin, 0);

y_filt = filter(b, a, y);
figure('Name', 'Ultrasonic Distance Sensor Project');
hold on
plot(x, y);
plot(x, y_filt);
xlabel('Iteration');
ylabel('Distance (meters)');
title('Ultrasonic Distance output');
legend({'Raw data', 'Filtered data'}, 'Location', 'northwest');
hold off;