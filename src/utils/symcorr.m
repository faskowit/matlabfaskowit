function mat = symcorr(inMat)
% a function that assures that corr outputs symmetric matrix by averaging

mat = corr(inMat) ;
mat = (mat + mat') / 2 ;