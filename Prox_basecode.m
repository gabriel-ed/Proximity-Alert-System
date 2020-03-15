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


N = 1000;     %number of data-points to take (iterations)

x = 1:N;
y = zeros(1, N);
h = animatedline;
a = arduino(port, board);

configurePin(a, redPin, pinMode);
configurePin(a, yellowPin, pinMode);
configurePin(a, greenPin, pinMode);

ultrasonicObj = ultrasonic(a, trigPin, echoPin);

for i = 1:N
    y(i) = readDistance(ultrasonicObj);
    xlabel('Iteration');
    ylabel('Distance (meters)');
    addpoints(h, x(i), y(i));
    drawnow;
    if y(i) > 1
        writeDigitalPin(a, greenPin, 1);
        writeDigitalPin(a, yellowPin, 0);
        writeDigitalPin(a, redPin, 0);
    elseif y(i) > 0.5 && y(i) < 0.9
        writeDigitalPin(a, greenPin, 0);
        writeDigitalPin(a, yellowPin, 1);
        writeDigitalPin(a, redPin, 0);
    else
        writeDigitalPin(a, greenPin, 0);
        writeDigitalPin(a, yellowPin, 0);
        writeDigitalPin(a, redPin, 1);
    end 
        
end

writeDigitalPin(a, greenPin, 0);
writeDigitalPin(a, yellowPin, 0);
writeDigitalPin(a, redPin, 0);


