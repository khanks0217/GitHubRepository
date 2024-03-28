% Open the text file for reading
U_Y = fopen('u_y_U.xy', 'r');

U_Y_data = textscan(U_Y, '%f %f %f %f %f %f', 'Delimiter', ' ', 'MultipleDelimsAsOne', true, 'CollectOutput', true);

fclose(U_Y);
U_Y_data = U_Y_data{1};
y_vals = U_Y_data(:,2);
u = U_Y_data(:,4);

rho =1;
u_inf = 1;
b = 4;

f = @(y) rho * (u_inf - u) .* u;

D = integral(f, -b,b, "ArrayValued", true);

disp(['Drag force D: ', num2str(D(65))]);

figure;
plot(y_vals, D);
% Add labels and title
xlabel('Y Value');
ylabel('Drag Coeff (C)');
title('Drag Coeff vs y');
% Show grid
grid on;




% % Skip the first six lines
% for i = 1:3
%     fgetl(Forces);
% end


% % Read the data using textscan
% F_data = textscan(Forces, '%f ((%f %f %f) (%f %f %f) (%f %f %f)) ((%f %f %f) (%f %f %f) (%f %f %f))', 'Delimiter', ' ', 'MultipleDelimsAsOne', true, 'CollectOutput', true);
% 
% % Close the file
% fclose(Forces);
% 
% 
% % Extract the relevant data from the cell array
% A_ref = 0.1571; %((2*pi*0.5)/2)*0.1; [m^2]
% len = (2*pi*0.5)/2; 
% F_data = F_data{1};
% time = F_data(:,1);
% 
% F_pressure = [F_data(:,2),F_data(:,3),F_data(:,4)];
% F_visoucs = [F_data(:,5),F_data(:,6),F_data(:,7)];
% F_porous = [F_data(:,8),F_data(:,9),F_data(:,10)];
% F_x = F_pressure(:,1) + F_visoucs(:,1) + F_porous(:,1);
% F_y = F_pressure(:,2) + F_visoucs(:,2) + F_porous(:,2);
% F_z = F_pressure(:,3) + F_visoucs(:,3) + F_porous(:,3);
% F_total = F_x + F_y + F_z;
% 
% Cd = 2 * (F_total/A_ref);
% 
% 
% figure;
% % Plote time vs probe0_data[1]
% %plot(time(5:end), Cd(5:end,1));
% plot(time, Cd);
% hold on;
% 
% % Add labels and title
% xlabel('Time (sec)');
% ylabel('Drag Coeff (C)');
% title('Drag Coeff vs Time');
% legend('Cd', 'C = 1/20');
% % Show grid
% grid on;

