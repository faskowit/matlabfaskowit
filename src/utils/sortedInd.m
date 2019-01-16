function [ind] = sortedInd(vec,order)
if nargin < 2
    order = 'ascend' ;
end
[~,ind] = sort(vec,order) ;