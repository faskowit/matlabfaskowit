function [h] = imsc_overdim(X,dd,tt,cb,varargin)

if nargin < 2 
   error('need 2 inputs') 
end

if ~exist('cb','var') || isempty(cb)
    cb = 0 ;
end
    
if ~exist('tt','var')
   tt = [] ; 
end

nd = ndims(X) ;
inds = repmat({':'},1,nd) ;
sz_iterdim = size(X,dd) ;

for idx = 1:sz_iterdim

    
    sl_inds = inds ;
    sl_inds{dd} = idx ;
    
    h = imagesc(squeeze(X(sl_inds{:})),varargin{:}) ;
    if strcmp(tt,'num')
        title(idx)
    elseif ~isempty(tt)
        title(tt{idx})
    end
    if cb
       colorbar 
    end
    
    waitforbuttonpress

end