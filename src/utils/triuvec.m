function outvec = triuvec(mat,k)

if diff(size(mat))
    error('need square matrix')
end

if nargin < 2
    warning('setting k=0') 
    k = 0 ;
end

mask = logical(triu(ones(size(mat)),k));
outvec = mat(mask) ;
