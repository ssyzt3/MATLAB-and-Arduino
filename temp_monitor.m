function temp_monitor(a, duration)
% TEMP_MONITOR Monitors temperature and controls LEDs
% This function reads temperature data from a sensor connected to Arduino,
% updates a live graph, and controls LEDs based on the temperature values.
% When the temperature is below 18 degrees, the signal is output from the d10 pin and the yellow light flashes. When the temperature is within the interval of 18 and 24 degrees, the signal is output by the d8 pin and the green light is always on. When the temperature is above 24 degrees, the signal is output by d9 pin and the red light flashes.
% Syntax: temp_monitor(a, duration)
% a - Arduino object
% duration - Monitoring duration in seconds
n=1

% Initialization
tempSensorPin = 'A0'; % Analog pin connected to temperature sensor
redLEDPin = 'D9'; % Digital pin connected to LED
yellowLEDPin = 'D10';
greenLEDPin = 'D8'; 
V0_C = 0.5; % Voltage at 0°C 
TC = 0.01; % Temperature coefficient 

% Arrays for storing data
time = 0:1:duration;
temperature = zeros(1, length(time));

% Setup live plot
figure;
h = plot(time, temperature);
xlabel('Time (s)');
ylabel('Temperature (°C)');
title('Real-time Temperature Monitoring');

% Monitoring loop
while true %progress continuously
    for t = 1:length(time)
        % Read voltage from sensor
        voltage = readVoltage(a, tempSensorPin);

        % Convert voltage to temperature
        temperature(t) = (voltage - V0_C) / TC;

        % Update live plot
        set(h, 'YData', temperature);
        drawnow;

        % Control LEDs based on temperature
        if temperature(t) >= 18 && temperature(t) <= 24
            writeDigitalPin(a, greenLEDPin, 1); % Green LED on
            writeDigitalPin(a, yellowLEDPin, 0);
            writeDigitalPin(a, redLEDPin, 0); 
        elseif temperature(t) < 18
            writeDigitalPin(a, greenLEDPin, 0); 
            writeDigitalPin(a, yellowLEDPin, 1); % Yellow LED blink
            writeDigitalPin(a, redLEDPin, 0); 
            pause(0.5);
            writeDigitalPin(a, yellowLEDPin, 0);
            pause(0.5);
        else
            writeDigitalPin(a, greenLEDPin, 0); 
            writeDigitalPin(a, yellowLEDPin, 0); 
            writeDigitalPin(a, redLEDPin, 1); % Red LED blink
            pause(0.25);
            writeDigitalPin(a, redLEDPin, 0);
            pause(0.25);
        end

        pause(1); % Ensure 1-second intervals for data acquisition
    end
end
end


