function out = offdiag(in) 
out = in(~eye(size(in))) ; 