function [fig_handle] = plot_( plotdata, varargin )
%PLOT_ Summary of this function goes here
%   Detailed explanation goes here


s.xlabel = '';
s.ylabel = '';
s.linewidth = 2;
s.labelfontsize = 12;
s.tickfontsize = 10;
s.legendfontsize = 10;
s.colororder = [  0       85/255      1; ...
        85/255  170/255     0; ...
        1       170/255     0; ...
        ];
    
% s.colororder = [
%       0.070588      0.40784      0.70196 ; ...
%       0.92941      0.14118      0.14902 ; ...
%       0.60784       0.7451      0.23922 ; ...
%       0.48235      0.17647       0.4549 ; ...
%             1      0.78039            0 ; ...
%       0.30196       0.7451      0.93333 ; ...
%       0.82353       0.4549            0 ; ...   
%       ];
s.legendlocation = 'SouthEast';
s.height=375; % width/golden ratio
s.width=500;

for i=1:2:length(varargin)
    if ~isfield(s, lower(varargin{i}))
        error(sprintf('%s is not parameter of plotset structure!', varargin{i}));
        continue;
    end
    
    s.(lower(varargin{i})) = varargin{i+1};
end

hLegendH = [];
hLegendS = {};     
hPlot = zeros(1,length(plotdata));     
fig_handle = figure;
    
hold on;
j = 1;
for i=1:length(plotdata)
    filedNames = fieldnames(plotdata(i));
    hPlot(i) = plotdata(i).func(plotdata(i).xdata, plotdata(i).ydata);
    
    if( ~strcmp(plotdata(i).legend, ''))
        hLegendH(j) = hPlot(i);
        hLegendS{j} = plotdata(i).legend;
        j = j + 1;
    end
    
    if(isempty(plotdata(i).color))
        color = s.colororder(i,:);
    else
        color = plotdata(i).color;
    end
    
    set(hPlot(i)                            , ...
    'Color'           , color         , ...
    'LineWidth'       , s.linewidth           , ...
    'Marker'          , plotdata(i).marker   , ...
    'LineStyle'          , plotdata(i).linestyle   , ...
    'MarkerSize'      , 7                   , ...
    'MarkerEdgeColor' , color         , ...
    'MarkerFaceColor' , [1 1 1]             );
end

hold off

hXLabel = xlabel(s.xlabel);
hYLabel = ylabel(s.ylabel);

if(length(hLegendH) ~= 0)
    hLegend = legend( ...
        hLegendH          , ...
        hLegendS           , ...
        'Location', s.legendlocation );
else
    hLegend = [];
end
grid on;

set( gca                                , ...
    'FontName'   , 'Helvetica' );
set([hXLabel, hYLabel]                  , ...
    'FontName'   , 'AvantGarde');
set([hXLabel, hYLabel]                  , ...
    'FontSize'   , s.labelfontsize          );
set([hLegend, gca]             , ...
    'FontSize'   , s.legendfontsize           );
set(gca, ...
  'Box'         , 'off'         , ...
  'TickDir'     , 'out'         , ...
  'TickLength'  , [.02 .02]     , ...
  'XMinorTick'  , 'on'          , ...
  'YMinorTick'  , 'on'          , ...
  'YGrid'       , 'on'          , ...
  'XColor'      , [.3 .3 .3]    , ...
  'YColor'      , [.3 .3 .3]    , ...
  'FontSize'    , s.tickfontsize  , ...
  'LineWidth'   , 1         );

% Here we preserve the size of the image when we save it.
set(gcf,'InvertHardcopy','on');
papersize = get(gcf, 'PaperSize');
left = (papersize(1)- s.width)/2;
bottom = (papersize(2)- s.height)/2;
myfiguresize = [left, bottom, s.width, s.height];
set(gcf,'PaperPosition', myfiguresize);
end
