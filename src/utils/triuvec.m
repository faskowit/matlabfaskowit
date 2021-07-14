function outvec = triuvec(mat,k)

if diff(size(mat))
    error('need square matrix')
end

mask = logical(triu(ones(size(mat)),k));
outvec = mat(mask) ;
