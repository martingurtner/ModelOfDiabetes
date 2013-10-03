%% Init
x1 = [75 160 180 155 95 75 65 80 85 80]; % glucose concentration [mg/dl]
x2 = [100 185 210 220 195 175 105 100 85 90]; % glucose concentration [mg/dl]
t = [0 .5 .75 1 1.5 2 2.5 3 4 5]; % [hours]

f = fittype('G0+A*exp(-alpha*x)*cos(omega*x-phi)');
t_smooth = linspace(t(1), t(end), 100);

%% Data 1
fit1 = fit(t',x1',f, 'startpoint', [80; 200; 1; 1; 1]);

A = fit1.A;
G0 = fit1.G0;
alpha = fit1.alpha;
omega = fit1.omega;
phi = fit1.phi;

x1_smooth = G0+A*exp(-alpha*t_smooth).*cos(omega*t_smooth-phi);

%% Data 2
fit1 = fit(t',x2',f, 'startpoint', [80; 200; 1; 1; 1]);

A = fit1.A;
G0 = fit1.G0;
alpha = fit1.alpha;
omega = fit1.omega;
phi = fit1.phi;

x2_smooth = G0+A*exp(-alpha*t_smooth).*cos(omega*t_smooth-phi);

%% Plot
sPlot1 = plotset(t_smooth, x1_smooth, ...
    'Color', [0       85/255      1], ...
    'Legend', 'Data1'); 
sPlot2 = plotset(t, x1, ...
    'LineStyle', 'none', ...
    'Marker', 'x', ...
    'Color', [0       85/255      1]); 
sPlot3 = plotset(t_smooth, x2_smooth, ...
    'Color', [85/255  170/255     0], ...
    'Legend', 'Data2'); 
sPlot4 = plotset(t, x2, ...
    'LineStyle', 'none', ...
    'Marker', 'x', ...
    'Color', [85/255  170/255     0]); 
plot_([sPlot1 sPlot2 sPlot3 sPlot4], 'xlabel', 'Time [hours]', ...
    'ylabel', 'Glucose connc. [mg/dl]', ...
    'LegendLocation', 'NorthEast');

set(gcf, 'PaperPositionMode', 'auto');
print -depsc2 ../figs/ackermanTest1.eps