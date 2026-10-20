function [ a , asym ] = make_square_tl(M,K)
% make tril + diag outta vect

if nargin < 2 
   K = 1 ; 
end

b = length(M) ;
s = sqrt(2 * b + 0.25) - 0.5 + K;
a = tril(ones(s),-K) ;
a(logical(a)) = M ;
a = a + tril(a,-K)' ; 

% make the asymmetric too
if nargout > 1
    asym = tril(a,-K) ; 
end