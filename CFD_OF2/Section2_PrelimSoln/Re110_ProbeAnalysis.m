% Open the text file for reading
Re110_U = fopen('U', 'r');
Re110_p = fopen('p', 'r');

% Skip the first four lines
for i = 1:4
    fgetl(Re110_U);
    fgetl(Re110_p);
end

% Read the data using textscan
U_data = textscan(Re110_U, '%f (%f %f %f) (%f %f %f)', 'Delimiter', ' ', 'MultipleDelimsAsOne', true, 'CollectOutput', true);
p_data = textscan(Re110_p, '%f %f %f', 'Delimiter', ' ', 'MultipleDelimsAsOne', true, 'CollectOutput', true);

% Close the file
fclose(Re110_U);
fclose(Re110_p);

% Extract the relevant data from the cell array
U_data = U_data{1};
time = U_data(:,1);
probe0_data_U = [U_data(:,2), U_data(:,3), U_data(:,4)];
probe1_data_U = [U_data(:,5), U_data(:,6), U_data(:,7)];

p_data = p_data{1};
p_time = p_data(:,1);
probe0_data_p = [p_data(:,2)];
probe1_data_p = [p_data(:,3)];

figure;
% Plote time vs probe0_data[1]
plot(time(8000:end), probe0_data_U(8000:end, 1)); 
hold on;
plot(time(8000:end), probe1_data_U(8000:end, 1)); 

% Add labels and title
xlabel('Normalized Time, t/(D/U)');
ylabel('u/U');
title('Ux Velocity vs Time');
subtitle('At (x,y) = (5.5, +/- 0.5)');
legend('+0.5', '-0.5', 'best');
% Show grid
grid on;

figure;
% Plote time vs probe0_data[1]
plot(time(8000:end), probe0_data_U(8000:end, 2)); 
hold on;
plot(time(8000:end), probe1_data_U(8000:end, 2));

% Add labels and title
xlabel('Normalized Time, t/(D/U )');
ylabel('v/U');
title('Uy Velocity vs Time');
subtitle('At (x,y) = (5.5, +/- 0.5)');
legend('+0.5', '-0.5', 'best');

% Show grid
grid on;

figure;
% Plote time vs probe0_data[1]
plot(p_time(8000:end), probe0_data_p(8000:end, 1)); 
hold on;
plot(p_time(8000:end), probe1_data_p(8000:end, 1)); 

% Add labels and title
xlabel('Normalized Time, t/(D/U)');
ylabel('p/ρU^2');
title('Pressure vs Time');
subtitle('At (x,y) = (5.5, +/- 0.5)');
legend('+0.5', '-0.5', 'best');
% Show grid
grid on;