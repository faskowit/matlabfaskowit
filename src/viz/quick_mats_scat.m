function h = quick_mats_scat(A,B,k,addsquares) 

if nargin < 3
    k = 1 ;
end

if nargin < 4
    addsquares = false ;
end

if ~isequal(size(A),size(B)) 
    error("mats not the same size")
end

if addsquares
    tiledlayout(2,3) ; 
end

mask = logical(triu(ones(size(A,1)),k)) ; 

if addsquares
    nexttile(3)
    imagesc(A,'alphadata',(mask)) ; colorbar ; title('X')
    nexttile(6)
    imagesc(B,'alphadata',(mask)) ; colorbar ; title('Y')
    nexttile(1,[ 2 2 ])
end

hh = scatter(A(mask),B(mask)) ;
cc = corr(A(mask),B(mask),"type","Spearman") ;
disp(strcat("rho: ",num2str(cc)))
if nargout > 0 
    if addsquares
        h = gca ;
    else
        h = hh;
    end
end