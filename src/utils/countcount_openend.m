function [outVec] = countcount_openend(vec,cats)
% basically histcounts, but without the automatic binning, returns column
% vector

if nargin < 2
   cats = unique(vec) ;
end

cats = cats(:) ; 
outVec = arrayfun(@(x)sum(vec(:) == x), cats(1:end-1)) ;
outVec = [ outVec ; sum(vec(:)>=cats(end)) ] ; 