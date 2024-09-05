function [h] = plot_multcolor(colors,varargin)

cnum = size(colors,2) ; 
if cnum ~= 3 | cnum ~= 4
    error('colors needs to be Nx3 or Nx4 mat')
end

for idx = 1:cnum
    plot(varargin{:},'Color',colors(idx,:))
end

