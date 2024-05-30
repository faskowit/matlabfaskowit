function [h] = plot_patch(inX,inLower,inUpper,patchcolor,varargin)  

if nargin < 4
    patchcolor = [ 0 0.447 0.741 ] ; 
end

if length(inX) ~= length(inLower) || length(inX) ~= length(inUpper)
    error('sizes of X and Y dont match up yo')
end

h = fill([inX(:)' fliplr(inX(:)')], [inLower(:)' fliplr(inUpper(:)')], patchcolor , 'edgealpha', 0 , varargin{:}) ; 
