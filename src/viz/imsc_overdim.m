function [h] = imsc_overdim(X,ddim,ttile,ccolorbar,varargin)

if nargin < 2 
   error('need 2 inputs') 
end

if ~exist('ccolorbar','var') || isempty(ccolorbar)
    ccolorbar = 0 ;
    disp('feffeffe')
end
    
if ~exist('ttile','var')
   ttile = [] ; 
end

nd = ndims(X) ;
inds = repmat({':'},1,nd) ;
sz_iterdim = size(X,ddim) ;

for idx = 1:sz_iterdim

    
    sl_inds = inds ;
    sl_inds{ddim} = idx ;
    
    h = imagesc(squeeze(X(sl_inds{:})),varargin{:}) ;
    if strcmp(ttile,'num')
        title(idx)
    elseif ~isempty(ttile)
        title(ttile{idx})
    end
    if sum(abs(ccolorbar),'all')>0
       colorbar 
       if length(ccolorbar) == 2
            clim(ccolorbar)
       end
    end
    
    waitforbuttonpress

end