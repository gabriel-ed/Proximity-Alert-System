%Arduino Hardware Package 
%Arduino Uno w/ HC-SR04 Ultra-Sonic Distance Sensor

%Developer: Gabriel Smith

clear 
close all

%% Arduino Ultrasonic Distance 
N = 2000;     %number of data-points to take (iterations)
x = 1:N;
y = zeros(1, N);
h = animatedline;
trigPin = 'D10';
echoPin = 'D9';

a = arduino('COM3', );
ultrasonicObj = ultrasonic(a, trigPin, echoPin);

for i = 1:N
    y(i) = readDistance(ultrasonicObj);
    xlabel('Iteration');
    ylabel('Distance');
    addpoints(h, x(i), y(i));
    drawnow;
end


