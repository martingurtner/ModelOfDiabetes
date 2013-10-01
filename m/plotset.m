function [ sPlot ] = plotset(xdata, ydata, varargin)
%PLOTSET Summary of this function goes here
%   Detailed explanation goes here

if mod(nargin,2) ~=0
    error('Wrong number of parameters');
        return;
end

sPlot.xdata = xdata;
sPlot.ydata = ydata;
sPlot.func  = @plot;
sPlot.marker  = 'none';
sPlot.legend  = '';
sPlot.linestyle  = '-';
sPlot.color = [];

for i=1:2:length(varargin)
    if ~isfield(sPlot, lower(varargin{i}))
        error(sprintf('%s is not parameter of plotset structure!', varargin{i}));
        continue;
    end
    
    sPlot.(lower(varargin{i})) = varargin{i+1};
end

end

