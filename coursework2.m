%Insert name here
%Ruotong WANG
%Insert email address here
%ssyrw10@nottingham.edu.cn
%%
%%PRELIMINARY TASK-ARDUINO AND GIT INSTALATION [10 MARKS]
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

clear 

%%
%%TASK 1-READ TEMPERATURE DATA,PLOT,AND WRITETOALOG FILE [20 MARKS]
% Initialize viriables
duration = 600; % 采集时间（秒）
temperature_data = zeros(1, duration); % 存储温度数据的数组
time_data = 0:duration-1; % 时间数据数组（秒）

% Initialize Arduino
a = arduino(); 

V0_C = 0.5;  % Voltage at 0°C
TC = 10; % Temperature coefficient

% read data from Arduino
for t = 1:duration
    voltage = readVoltage(a, 'A0'); % read voltage from A0
    temperature = (voltage - V0_C) * 1000 / TC; % convert voltage to temperature
    temperature_data(t) = temperature;
    pause(1);% pause for 1 second
end

% calculate 
min_temp = min(temperature_data);
max_temp = max(temperature_data);
avg_temp = mean(temperature_data);

% plot temperature/time figure
figure;
plot(time_data, temperature_data);
xlabel('Time (s)');
ylabel('Temperature (°C)');
title('Temperature vs Time');

% use sprintf and disp to display the table
disp('Data logging initiated - 5/3/2024');
disp('Location - Nottingham');
disp(' ');
zero=sprintf('Minute \t 0 \nTemperature \t 0 °C');
disp(zero);
for minute = 1:(duration/60)
    x=sprintf('Minute \t %d',minute);
    y=sprintf('Temperature \t %.4f °C',temperature_data(minute*60));
    disp(x);
    disp(y);
    disp(' ');
end
max=sprintf('Max temp \t %.2f °C',max_temp);
min=sprintf('Min temp \t %.2f °C',min_temp);
avg=sprintf('Average temp \t %.2f °C',avg_temp);
disp(max);
disp(min);
disp(avg);
disp('Data logging terminated');

% write data into files
fileID = fopen('cabin_temperature.txt', 'w');
fprintf(fileID, 'Data logging initiated - %s\n', datestr(now, 'dd/mm/yyyy'));
fprintf(fileID, 'Location - Nottingham\n\n');

for minute = 0:(duration/60 - 1)
    fprintf(fileID, 'Minute %d\n', minute);
    fprintf(fileID, 'Temperature %.2f °C\n\n', temperature_data(minute*60 + 1));
    fprintf(fileID, ' ');
end

fprintf(fileID, 'Max temp %.2f °C\n', max_temp);
fprintf(fileID, 'Min temp %.2f °C\n', min_temp);
fprintf(fileID, 'Average temp %.2f °C\n', avg_temp);
fprintf(fileID, 'Data logging terminated\n');

fclose(fileID);
clear;
%%
%%TASK 2-LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]

a = arduino(); % Initialize Arduino
% Set monitoring duration
duration = 10000;

temp_monitor(a, duration);
clear;
%%
%%TASK 3-ALGORITHMS-TEMPERATURE PREDICTION [25MARKS]

a=arduino();%% Initialize Arduino
temp_prediction(a);
clear
%%
%%TASK 4-REFLECTIVE STATEMENT [5MARKS]

%{
Reflective Statement:

During the development of both the initial project and the LED temperature monitoring device implementation, I encountered several challenges and identified various strengths, limitations, and potential areas for improvement:

Challenges:
1. Setting up GitHub: Although I had some prior experience with version control systems, setting up GitHub for these projects required me to learn new commands and workflows.
2. MATLAB and Arduino Communication: Establishing communication between MATLAB and Arduino was more complex than anticipated, especially configuring the hardware support package and troubleshooting connection issues.
3. Hardware Setup: In task1, the ppt used in the lecture shows that our thermistor model is MCP9700A, but this is used as the basis for connecting the circuit of task1 is always incorrect, after checking, the thermistor model in our toolkit is in fact a DS18B20, and finally through the connection of a feedback circuit to complete task1

Strengths:
1. Problem-Solving Skills: I was able to overcome various challenges by applying problem-solving skills and seeking help from online resources, documentation, and peers.
2. Persistence: Despite facing setbacks and encountering difficulties, I remained persistent and dedicated to completing the projects.
3. Collaboration: Collaborating with classmates and seeking assistance from project introductory sessions helped me gain insights and overcome obstacles more efficiently.

Limitations:
1. Time Constraints: Limited time available for the projects constrained the depth of exploration and optimization of certain features, potentially limiting the robustness and sophistication of the final implementations.
2. Limited Experience: As a beginner in MATLAB and Arduino programming, I lacked extensive experience, which sometimes hindered my progress and understanding of certain concepts.
3. Hardware Limitations: The constraints of the Arduino board and components limited the complexity and scalability of the projects, restricting the range of functionalities and potential applications.

Future Improvements:
1. Continuous Learning: I plan to continue learning and exploring advanced topics in MATLAB and Arduino programming to enhance my skills and tackle more complex projects in the future.
2. Experimentation: By experimenting with different hardware configurations and software techniques, I aim to optimize the performance and functionality of future projects.
3. Documentation: Improving documentation, including code comments, project notes, and reflective statements, will facilitate better understanding and collaboration with others.
