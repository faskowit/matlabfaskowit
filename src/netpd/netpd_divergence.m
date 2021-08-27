function [net_div] = netpd_divergence(BG_0,BH_0)

% copy
BG = BG_0 .* 1 ;
BH = BH_0 .* 1 ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% https://github.com/bagrow/portraits/blob/master/B_Distance.m#L11
% pad with zeros to make same size

[bg_n, bg_m] = size(BG_0);
[bh_n, bh_m] = size(BH_0);
sz_n = max( [bg_n bh_n] );

% pad rows
if bg_n < bh_n
    BG = [BG; [BG(1,2)*ones(sz_n-bg_n,1) zeros(sz_n-bg_n,bg_m-1)] ];
else
    BH = [BH; [BH(1,2)*ones(sz_n-bh_n,1) zeros(sz_n-bh_n,bh_m-1)] ];
end
% pad columns
if bg_m < bh_m
    BG = [ BG zeros(sz_n, bh_m-bg_m) ];
else
    BH = [ BH zeros(sz_n, bg_m-bh_m) ];
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% https://github.com/bagrow/network-portrait-divergence/blob/master/portrait_divergence.py#L187

[L,K] = size(BG) ;
V = repmat(0:(K-1),[L 1]) ;

XG = BG.*V / sum(BG.*V,'all');
XH = BH.*V / sum(BH.*V,'all');

P = XG(:);
Q = XH(:);

M = 0.5*(P+Q);
KLDpm = sum(P .* log2(P ./ M),'omitnan') ;
KLDqm = sum(Q .* log2(Q ./ M),'omitnan') ;
net_div = 0.5*(KLDpm + KLDqm) ;

