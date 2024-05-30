function out = odfill(mat,val) 
if nargin < 2 
    error('need two args')
end
out = mat.*1 ; 
out(logical(eye(size(mat,1)))) = val ; 
