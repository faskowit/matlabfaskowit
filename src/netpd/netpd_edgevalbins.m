function [edge_bins] = netpd_edgevalbins(D1,D2) 
% get reasonable edge_bins for two distance matricies

v1 = D1(~eye(size(D1))) ;
v2 = D2(~eye(size(D2))) ;

combo = unique([v1 ; v2]) ;

[~,edge_bins] = histcounts(combo,'BinMethod','sturges') ;
