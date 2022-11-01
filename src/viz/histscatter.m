function [h] = histscatter(x,y,varargin)

% 'ShowEmptyBins','on'
h = histogram2(x(:),y(:),varargin{:},'DisplayStyle','tile');
