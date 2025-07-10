function [out] = fillvecinds(inds,dat,initval)
% a function to help with assigment for inline funcs

if sum(inds) ~= length(dat(:))
    error('your using this function wrong')
end
if nargin < 3
    initval = 1 ; 
end

out = ones(length(inds),1) .* initval ; 
out(logical(inds)) = dat ; 
