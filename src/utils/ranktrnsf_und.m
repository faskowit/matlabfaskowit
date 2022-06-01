function mat = ranktrnsf_und(inmat,ignorezero) 
% transform numbers in undirected matrix into ranks

if nargin < 2
   ignorezero = 1 ; 
end

n = size(inmat) ;
m = logical(triu(ones(n),0)) ;
if ignorezero
   m = m & inmat~=0 ; 
end
mat = zeros(n) ;

rnk = tiedrank(inmat(m)) ;
mat(m) = rnk ;
mat = mat + triu(mat,1)' ;
