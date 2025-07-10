function [newcm] = interp_cmap_lin(startcolor,endcolor,ncolors) 
newcm = zeros(ncolors,3) ; 
for idx = 1:3
    newcm(:,idx) = linspace(startcolor(idx),endcolor(idx),ncolors) ; 
end