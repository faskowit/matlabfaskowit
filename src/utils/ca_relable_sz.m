function  out = ca_relable_sz(ca)

ca = ca(:) ;
uu = unique(ca) ; 

sz = arrayfun(@(x)sum(ca(:) == x),uu) ;

[~,srtSz] = sort(sz,'descend') ;

out = nan(length(ca),1) ;
for idx = 1:length(uu)
    ind2 = srtSz(idx) ;
    out(ca==ind2) = idx ; 
end
