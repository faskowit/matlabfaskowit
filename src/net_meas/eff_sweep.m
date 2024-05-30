function [effvec] = eff_sweep(mat,nbins)

if ~exist("nbins","var") || isempty(nbins) 
    nbins = 100 ; 
end

nnodes = size(mat,1) ;

%% setup sweep

% get unique values of mat
if isnan(nbins)
    uvals = sort(unique(mat(:)),'ascend') ; 
else
    uvals = [min(mat,[],'all') quantile(mat(:),nbins-1) max(mat,[],'all')+eps] ; 
end

%% run eet

% number uvals
nvals = length(uvals)-1 ;

% initalize effvec
effvec = nan(nvals,1) ; 

for idx = 1:nvals

    disp_prog(idx,nvals)

    tt = uvals(idx) ; 
    mask = double(mat <= tt) ; 

    effvec(idx) = my_efficiency_wei(mask,0) ; 
end