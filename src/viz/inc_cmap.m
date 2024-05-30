function map = inc_cmap(cm,m)
% copied from parula function 
values = cm;

P = size(values,1);
map = interp1(1:size(values,1), values, linspace(1,P,m), 'linear');