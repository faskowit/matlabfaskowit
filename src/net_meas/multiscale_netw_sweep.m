function [barcode, uvals] = multiscale_netw_sweep(mat,nbins,measurelist)

if ~exist("nbins","var") || isempty(nbins) 
    nbins = 100 ; 
end

if nargin < 3
    measurelist =  {'degree'} ; 
end

nnodes = size(mat,1) ; 

%% node operations to do

nmeas = length(measurelist) ; 
graphfuncs = cell(nmeas,1) ; 

for idx = 1:length(measurelist)

    mstring = measurelist{idx} ; 

    switch lower(mstring)
        case 'degree'
            ff = @(m_) sum(m_) ;
        case 'strength'
            ff = @(m_) sum(m_ .* abs(mat)) ; 
        case 'bclustcoef' 
            ff = @(m_) clustering_coef_bu(m_) ;
        case 'wclustcoef'
            ff = @(m_) clustering_coef_wu(m_ .* abs(mat)) ; 
        case 'sclustcoef'
            ff = @(m_) clustering_coef_wu_sign(m_ .* mat,3) ; 
        case 'closedeg'
            ff = @(m_) my_close_cent(m_) ; 
        case 'eigenvec'
            ff = @(m_) eigenvector_centrality_und(m_) ;
        otherwise
            error('not one of the implemented measures')
    end

    graphfuncs{idx} = ff ; 
end


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

% initalize the barcode
barcode = struct() ; 
for idx = 1:nmeas
    barcode.(measurelist{idx}) = zeros(nnodes,nvals)  ;  
end

for idx = 1:nvals

    disp_prog(idx,nvals)

    tt = uvals(idx) ; 
    mask = double(mat <= tt) ; 

    for jdx = 1:nmeas
        barcode.(measurelist{jdx})(:,idx) = graphfuncs{jdx}(mask) ; 
    end
end

