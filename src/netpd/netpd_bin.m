function [B] = netpd_bin(mat)

n = size(mat,1) ;

distmat = distance_bin(mat);
distmat(isinf(distmat)) = NaN ;
diam = max(distmat,[],'all');

B = zeros(diam+1,n+1) ;
for idx = 0:diam
   m = distmat==idx ;
   mm = sum(m);
   B(idx+1,:) = arrayfun(@(x)sum(mm(:) == x,'omitnan'), 0:n) ;
end

% and then trim 0's to the right
B(:,(find(sum(B),1,'last')+1):end) = [] ;
