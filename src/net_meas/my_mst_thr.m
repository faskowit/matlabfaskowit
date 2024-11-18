function mask = my_mst_thr(indist,frac,sortingdata)
% retain the top fraction of edges, with also the MST included

if nargin < 3
    error('need 3 args')
end

if ~isequal(size(indist),size(sortingdata))
    error('need indist to be same size as sortingdata')
end

my_mst = @(x_)full(adjacency(minspantree(graph(x_)))) ; 

N = size(indist,1) ; 
NE = (N*(N-1))/2 ; 

triumask = logical(triu(ones(N),1)) ; 
backbonefrac = (N-1)/NE ; 

% sparsest possible frac
if frac < backbonefrac
    error('fraction wanted is too sparse')
elseif frac == backbonefrac
    mask = my_mst(indist) ;
    return 
end

%% do the calc

% calc the min span tree
backbone = my_mst(indist)  ;

% sort the rest of the edges (in descending order) based on sorting data
mat = sortingdata.*1; 
mat(logical(backbone)) = -inf ; % don't include edges already in backbone 
[~,esort] = sort(mat(triumask),'descend') ; 

% calculate how many more edges to add
numedgestoadd = floor((frac-backbonefrac)*NE) ; 

mask = make_square(ismember(1:NE,esort(1:numedgestoadd))')+backbone ;

end

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

end