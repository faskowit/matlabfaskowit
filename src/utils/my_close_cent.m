function cc = my_close_cent(W,transdist)
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

d = distance_wei_floyd(L) ;
d(isinf(d)) = nan ; % if there are infs... make into nan
dd = sum(d,2,'omitnan') ;
dd(dd==0) = eps ; % if there are 0's (row of nan)... make tiny tiny number
cc = 1./dd(:) ;

end % end of closeness