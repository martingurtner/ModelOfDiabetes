clear all;

delta = 2.92;
gamma = 4.34;
beta = 0.208;
alpha = 0.780;

%%
A = [-alpha beta;...
    -gamma -delta];
B = [0 ; 0];
C = [0 1;1 0];
D = [0;0];

N = 100; % number of samples
tFinal = 3; % [hour]
x0 = [0;1];
u = zeros(1, N);
t = linspace(0, tFinal, N); % time vector of simulated system response

sys=ss(A,B,C,D, ...
    'TimeUnit', 'hours', ...
    'StateName', {'Insulin concr.', 'Glucose concr.'}, ...
    'StateUnit', {'Units/liter', 'Grams/liter'}, ...
    'OutputName', {'Glucose concr.', 'Insulin concr.'}, ...
    'OutputUnit', {'Grams/liter', 'Units/liter'});

y = lsim(sys, u, t, x0);

close all;
sPlot = plotset(t, y(:,1));
plot_(sPlot, 'xlabel', 'Time [hours]', ...
    'ylabel', 'Glucose connc. [Grams/liter]');

set(gcf, 'PaperPositionMode', 'auto');
print -depsc2 ../figs/boliesTestGlucose.eps

figure(1);
sPlot = plotset(t, y(:,2));
plot_(sPlot, 'xlabel', 'Time [hours]', ...
    'ylabel', 'Insuline connc. [Units/liter]');

set(gcf, 'PaperPositionMode', 'auto');
print -depsc2 ../figs/boliesTestInsulin.eps

%% Coefficients of the time response (without factor g_0)
% for g
Ag = (l2+delta)/(l2-l1);
Bg = -(l1+delta)/(l2-l1);
% for h
Ah = -(l1+delta)*(l2+delta)/(l2-l1)/gamma;
Bh = (l1+delta)*(l2+delta)/(l2-l1)/gamma;

