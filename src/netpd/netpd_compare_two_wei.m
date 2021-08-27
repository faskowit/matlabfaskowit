function [div,B1,B2,ebins] = netpd_compare_two_wei(M1,M2,wei_trans)

if nargin < 3
    wei_trans = 'inv' ;
end

% get two distance mats
D1 = distance_wei_floyd(M1,wei_trans) ;
D2 = distance_wei_floyd(M2,wei_trans) ;

% get commoin edge bins for distances
ebins = netpd_edgevalbins(D1,D2) ;

% two portraits, with common bins
B1 = netpd_wei(D1,ebins,'alreadydistance') ;
B2 = netpd_wei(D2,ebins,'alreadydistance') ;

% the divergence
div = netpd_divergence(B1,B2) ;
