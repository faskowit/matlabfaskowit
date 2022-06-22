function [newcm] = interp_cmap(startcolor,endcolor,ncolors) 
% https://stackoverflow.com/questions/33110109/interpolating-a-matlab-colormap
% https://www.mathworks.com/matlabcentral/fileexchange/51986-perceptually-uniform-colormaps

startcolor = startcolor(:)' ;
endcolor = endcolor(:)' ;

hsv=rgb2hsv([ startcolor ; endcolor ]);
interhsv=interp1(linspace(0,1,2),hsv,linspace(0,1,ncolors));
newcm=hsv2rgb(interhsv);



