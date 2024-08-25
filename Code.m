G = tf([1],[1 1 0])
H = tf([1],[1])
figure(1);
step(G);
figure(2);
step(feedback(G,H));
Closed_loop_transfer_function = feedback(G,H)
poles = pzmap(feedback(G,H))
figure(3);
ramp = tf([1],[1 0]);
N = tf([1],[1 1 1 0]);
step(N);%close loop * 1/s
hold on;
step(ramp);
legend('CL TF * 1/S','Ramp itself');
figure(4);
margin(G);
grid on;

%approximated phase plot
%Generate x values for the entire range
x = linspace(0.01, 100, 10000);

% Generate y values for the straight line part
y = zeros(size(x));

% Define the starting y value and the slope for the decreasing straight line
starting_y = -90;
slope = -45;

% Set the constant y value for the range 0.01 to 0.1
y(x < 0.1) = starting_y;

% Calculate the y values for the decreasing straight line
y(x >= 0.1) = starting_y + slope * log10(x(x > 0.1) / 0.1);

% For the range x >= 10, y = -180
y(x > 10) = -180;

% Plotting
figure(5);
semilogx(x, y);  % Plot straight line part
title('Approximated Phase Plot');
xlabel('W(rad/sec)');
ylabel('Phase(degree)');
ylim([-190, -80]);  % Set y-axis limits
grid on;

%approximated magnitude plot
% Generate x values for the entire range
x = linspace(0.01, 100, 1000000);

% Generate y values for the straight line part
y = zeros(size(x));

% Define the slope for the first decreasing straight line
slope1 = -20;

% Calculate the y values for the first decreasing straight line
y(x <= 1) = slope1 * log10(x(x <= 1));

% Define the slope for the second decreasing straight line starting from where the first slope ended
slope2 = -40;

% Find the y value where the first slope ends at x = 1
y_at_x1 = slope1 * log10(1);

% Calculate the y values for the second decreasing straight line
y(x > 1) = slope2 * log10(x(x > 1)) + y_at_x1;

% Adjust the y value at x = 1 to be exactly 0
y(x == 1) = 0;% Plotting
figure(6);
semilogx(x, y);  % Plot straight line part
title('Approximated Magnitude Semilog Plot');
xlabel('Magnitude in dB');
ylabel('W(rad/sec)');
grid on;
