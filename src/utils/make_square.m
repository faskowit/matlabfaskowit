function [ a , asym ] = make_square(M,K)
% make triu + diag outta vect

if nargin < 2 
   K = 1 ; 
end

b = length(M) ;
s = sqrt(2 * b + 0.25) - 0.5 + K;
a = triu(ones(s),K) ;
a(logical(a)) = M ;
a = a + triu(a,K)' ; 

% make the asymmetric too
if nargout > 1
    asym = triu(a,K) ; 
end