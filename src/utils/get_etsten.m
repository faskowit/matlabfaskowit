function etsten = get_etsten(ts,diagval)

if nargin < 2
    diagval = 1 ;
end

n = size(ts,2) ;
z = zscore(ts);                 % z-score
etsten = permute(...
    bsxfun(@times,permute(z,[1,2,3]),permute(z,[1,3,2])),...
    [ 2 3 1 ]) ;

if isnan(diagval)
    return
else % set the diagonal values to the diagval
    etsten((repmat(eye(n),[ 1 1 size(etsten,3)]))==1) = diagval ; 
end
