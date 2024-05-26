%Ruotong WANG
%ssyrw10@nottingham.edu.cn
%%PRELIMINARY TASK ARDUINO AND GITIN STALATIONARS [10 MARKS]
a = arduino(); 
% create an arduino object     

% start the loop to blink led for 20 seconds
for i=1:10
    %blink for 10 times
    writeDigitalPin(a, 'D10', 1);
    %light the LED
    pause(0.5);
    %pause for 0.5 seconds 
    writeDigitalPin(a, 'D10', 0);
    %turn off the LED
    pause(0.5);
    %pause for 0.5 seconds

end

% end communication with arduino

clear a