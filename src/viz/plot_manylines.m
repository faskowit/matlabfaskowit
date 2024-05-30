function [ h ] = plot_manylines(inX,inY,varargin)
% inlines should be matrix, where each column is data you want to plot

inX = inX(:); 

if length(inX) ~= size(inY,1)
    error('sizes of X and Y dont match up yo')
end

x = repmat(inX,1,size(inY,2)) ; 
x =[ x ; nan(1,size(inY,2)) ] ; 

y = [ inY ; nan(1,size(inY,2)) ] ; 

% make inlines into one line, then plot eet
h = plot(x(:),y(:),varargin{:}) ;  