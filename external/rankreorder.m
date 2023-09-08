function out=rankreorder(x,scaffold)
% method copied from: 
% https://github.com/brain-modelling-group/geomsurr/blob/master/geomsurr.m

% reorder vector x to have same rank order as vector scaffold
y(:,1)=scaffold;
y(:,2)=1:length(x);
y=sortrows(y,1);
y(:,1)=sort(x);
y=sortrows(y,2);
out=y(:,1);
end