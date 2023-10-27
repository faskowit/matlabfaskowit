function btwncent = my_btwn_cent(W,transdist)
% using floyd. do the inverse weight inside func

if nargin < 2
    transdist = 'inv' ;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

switch transdist
    case 'inv'
        L = 1 ./ W;
    case 'log'
        L = -log(W./ (max(W)+eps)) ; % +eps makes no 0 distances
    case 'na'
        L = W ;
    otherwise
        error('not a valid transdist') 
end

n = size(W,1) ;
[~,hops_,paths_] = distance_wei_floyd(L) ;
btwncent = zeros(n,1) ; 

for idx = 1:n
    for jdx = 1:n
        if idx >= jdx ; continue ; end
        
        pa = retrieve_shortest_path(idx,jdx,hops_,paths_) ;
        btwncent(pa(2:(end-1))) = btwncent(pa(2:(end-1)))+2 ;
    end
end

end % end of my betweenness

