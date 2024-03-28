% Open the text file for reading
BR4_U = fopen('H2_U', 'r');
BR4_p = fopen('H2_p', 'r');

% Skip the first six lines
for i = 1:6
    fgetl(BR4_U);
    fgetl(BR4_p);
end

% Read the data using textscan
BR4_U_data = textscan(BR4_U, '%f (%f %f %f) (%f %f %f) (%f %f %f) (%f %f %f)', 'Delimiter', ' ', 'MultipleDelimsAsOne', true, 'CollectOutput', true);
BR4_p_data = textscan(BR4_p, '%f %f %f %f %f', 'Delimiter', ' ', 'MultipleDelimsAsOne', true, 'CollectOutput', true);

% Close the file
fclose(BR4_U);
fclose(BR4_p);

% Extract the relevant data from the cell array
BR4_U_data = BR4_U_data{1};
time = BR4_U_data(:,1);
probe_U_p05 = [BR4_U_data(:,8), BR4_U_data(:,9), BR4_U_data(:,10)];
probe1_U_m05 = [BR4_U_data(:,11), BR4_U_data(:,12), BR4_U_data(:,13)];


BR4_p_data = BR4_p_data{1};
p_time = BR4_p_data(:,1);
probe_p_p05 = [BR4_p_data(:,4)];
probe_p_m05 = [BR4_p_data(:,5)];

figure;
% Plote time vs probe0_data[1]
plot(time, probe_U_p05(:, 1)); 
hold on;
plot(time, probe1_U_m05(:, 1)); 

% Add labels and title
xlabel('Time (sec)');
ylabel('Ux');
title('Ux Velocity vs Time');
subtitle('At (x,y) = (2, +/- 0.5)');
legend('+0.5', '-0.5', 'best');
% Show grid
grid on;

figure;
% Plote time vs probe0_data[1]
plot(time(8000:end), probe_U_p05(8000:end, 1)); 
hold on;
plot(time(8000:end), probe1_U_m05(8000:end, 1)); 

% Add labels and title
xlabel('Time (sec)');
ylabel('Ux');
title('Ux Velocity vs Time');
subtitle('At (x,y) = (2, +/- 0.5)');
legend('+0.5', '-0.5', 'best');
% Show grid
grid on;

figure;
% Plote time vs probe0_data[1]
plot(time, probe_U_p05(:, 2)); 
hold on;
plot(time, probe1_U_m05(:, 2));

% Add labels and title
xlabel('Time (sec)');
ylabel('Uy');
title('Uy Velocity vs Time');
subtitle('At (x,y) = (2, +/- 0.5)');
legend('+0.5', '-0.5', 'best');

% Show grid
grid on;

figure;
% Plote time vs probe0_data[1]
plot(p_time, probe_p_p05(:, 1)); 
hold on;
plot(p_time, probe_p_m05(:, 1)); 

% Add labels and title
xlabel('Time (sec)');
ylabel('Pressure');
title('Pressure vs Time');
subtitle('At (x,y) = (2, +/- 0.5)');
legend('+0.5', '-0.5', 'best');
% Show grid
grid on;


figure;
% Plote time vs probe0_data[1]
plot(p_time(8000:end), probe_p_p05(8000:end, 1)); 
hold on;
plot(p_time(8000:end), probe_p_m05(8000:end, 1)); 

% Add labels and title
xlabel('Time (sec)');
ylabel('Pressure');
title('Pressure vs Time');
subtitle('At (x,y) = (2, +/- 0.5)');
legend('+0.5', '-0.5', 'best');
% Show grid
grid on;