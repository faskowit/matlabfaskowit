function [out] = fillvecinds(inds,dat,initval)
% a function to help with assigment for inline funcs
% inds: vec how long you want output to be, 1s where dat will go
% dat: dat to fill 1 in inds
% initval: what will go where the 0 in inds are

if sum(inds) ~= length(dat(:))
    error('your using this function wrong')
end
if nargin < 3
    initval = 1 ; 
end

out = ones(length(inds),1) .* initval ; 
out(logical(inds)) = dat ; 
