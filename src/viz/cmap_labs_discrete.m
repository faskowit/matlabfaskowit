function [ cbarHandle ] = cmap_labs_discrete(labs)
% https://www.mathworks.com/matlabcentral/answers/102056-how-can-i-make-the-ticks-in-the-colorbar-appear-at-the-center-of-each-color-in-matlab-7-0-r14

numcolors = length(labs) ;

cbarHandle = colorbar('YTick',...
    1+0.5*(numcolors-1)/numcolors:(numcolors-1)/numcolors:numcolors,...
    'YTickLabel',labs, 'YLim', [1 numcolors]);

