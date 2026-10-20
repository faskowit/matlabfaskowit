function out = zscorenan(in)

if ~ismatrix(in)
    error('max 2 dims')
end
if isvector(in)
    in = in(:) ; 
end

[h,w] = size(in) ;
out = nan(h,w) ; 

for idx = 1:w

    nonan = ~isnan(in(:,idx)) ; 
    out(nonan,idx) = zscore(in(nonan,idx));

end
 