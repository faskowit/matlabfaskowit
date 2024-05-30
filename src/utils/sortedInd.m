function [ind] = sortedInd(vec,order)
if nargin < 2
    order = 'ascend' ;
end
if ~isvector(vec)
    error('need vector data')
end
[~,ind] = sort(vec,order) ;