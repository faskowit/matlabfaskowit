function [outVec] = countcount(vec,cats)
% basically histcounts, but without the automatic binning, returns column
% vector

if nargin < 2
   cats = unique(vec) ;
end

outVec = arrayfun(@(x)sum(vec(:) == x), cats(:)) ;
