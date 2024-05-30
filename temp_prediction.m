function temp_prediction(a)
    % temp_prediction - Function to predict temperature and control LEDs based on prediction.
    % The function continuously monitors the rate of change in temperature and predicts the temperature over the next five minutes. When the rate of temperature change is greater than positive 4 degrees per minute, the red light is always on for warning, greater than negative 4 degrees per minute then the yellow light is always on for warning, and the rest of the time the green light is always on to indicate that the rate of temperature change is acceptable.
    
    % Initialize variables
    TC=10;
    V0_C=0.5;
    pretemp = 0;
    duration = 300; % 5 minutes (300 seconds) for prediction
    predictemp=zeros(1,duration);
    redLEDPin = 'D9'; % Digital pin connected to red LED
    yellowLEDPin = 'D10'; % Digital pin connected to yellow LED
    greenLEDPin = 'D8'; % Digital pin connected to green LED
    
    % Infinite loop to continuously monitor temperature
    while true
        % Read the current temperature
        voltage = readVoltage(a, 'A0');
        currenttemp = (voltage - V0_C) * 1000 / TC; % Assuming MCP9700A sensor
        
        % Calculate the rate of temperature change
        rate = (currenttemp - pretemp) / 1; % Change per second
        %predicted temperature in 5 minutes
        for n=1:300
            if rate==0
                predictemp(n)=currenttemp;
            else 
                predictemp(n)=rate*n;
            end
        end
        disp(currenttemp);
        disp(predictemp);
        
       
        % Control LEDs based on the predicted temperature
        if rate*60 >= -4 && rate*60 <= 4
            writeDigitalPin(a, greenLEDPin, 1); % Green LED on
            writeDigitalPin(a, yellowLEDPin, 0);
            writeDigitalPin(a, redLEDPin, 0);
        elseif rate*60 < -4
            writeDigitalPin(a, greenLEDPin, 0);
            writeDigitalPin(a, yellowLEDPin, 1); % Yellow LED on
            writeDigitalPin(a, redLEDPin, 0);
        else
            writeDigitalPin(a, greenLEDPin, 0);
            writeDigitalPin(a, yellowLEDPin, 0);
            writeDigitalPin(a, redLEDPin, 1); % Red LED on
        end
        
        % Update the previous temperature
        pretemp = currenttemp;
        
        % Pause before the next reading
        pause(1);
    end
end
