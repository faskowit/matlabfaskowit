function [out] = mksq(dat,K)
% just an alias for make square
if nargin < 2 
   K = 1 ; 
end
out = make_square(dat,K) ; 
