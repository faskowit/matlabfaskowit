function pos = set_fig_pos(modval,cornerval)
if nargin<1
    modval=50;
end
if nargin<2
    cornerval=0;
end

if length(modval)>1
    pos = modval ; 
else    
    pos = get(gcf,'Position')-mod(get(gcf,'Position'),modval) ; 
end
if cornerval 
    pos(1:2) = cornerval ;
end
set(gcf,'Position',pos)