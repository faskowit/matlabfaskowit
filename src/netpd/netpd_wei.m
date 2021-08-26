function [B,edge_bins] = netpd_wei(mat,edge_bins,wei_trans)

if nargin < 2
   edge_bins = [] ; 
end

if nargin <3
   wei_trans = [] ;
end

n = size(mat,1) ;

if strcmp(wei_trans,'alreadydistance')
    distmat = mat ;
else
    distmat = distance_wei_floyd(mat,wei_trans);
end
distmat(isinf(distmat)) = NaN ; % cleanup disconnected components

if isempty(edge_bins)
    % compute bins
    [~,edge_bins] = histcounts(distmat(~eye(n)),'BinMethod','sturges') ;
end
n_bins = length(edge_bins)-1 ;

distmat_disc = discretize(distmat,edge_bins) ;
distmat_disc(1:n+1:end) = 0 ; % fix diagonal

B = zeros(n_bins+1,n+1) ;
for idx = 0:n_bins
   m = distmat_disc==idx ;
   mm = sum(m);
   B(idx+1,:) = arrayfun(@(x)sum(mm(:) == x,'omitnan'), 0:n) ;
end

% and then trim 0's to the right
B(:,(find(sum(B),1,'last')+1):end) = [] ;
