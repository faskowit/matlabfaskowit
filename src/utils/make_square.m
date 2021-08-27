function [ a , aFull ] = make_square(M,K)
% make triu + diag outta vect

if nargin < 2 
   K = 0 ; 
end

b = length(M) ;
s = sqrt(2 * b + 0.25) - 0.5 + K;
a = triu(ones(s),K) ;
a(~~a) = M' ;
aFull = a + triu(a,1)';