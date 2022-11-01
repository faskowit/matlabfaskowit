function h = quick_mats_scat(A,B,k) 

if nargin < 3
    k = 1 ;
end

if ~isequal(size(A),size(B)) 
    error("mats not the same size")
end

mask = logical(triu(ones(size(A,1)),k)) ; 
hh = scatter(A(mask),B(mask)) ;
cc = corr(A(mask),B(mask),"type","Spearman") ;
disp(strcat("rho: ",num2str(cc)))
if nargout > 0 
    h = hh ;
end