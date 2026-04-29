function set_fig_pos(modval)
if nargin<1
    modval=50;
end
set(gcf,'Position',get(gcf,'Position')-mod(get(gcf,'Position'),modval))