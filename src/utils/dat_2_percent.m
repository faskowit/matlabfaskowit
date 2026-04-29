function out = dat_2_percent(in,prct)

if nargin < 2
    prct = 0:1:100 ; 
end

[i,j] = size(in) ; 

e = prctile(in,prct,'all') ; 
out = reshape(discretize(in(:),e),i,j) ; 
