function [ out_ca ] = align_ca_cent(in_ca) 
% align ca to centroid
% in_ca: each column is a ca

vi = partition_distance(in_ca) ;

[~,min_ind] = min(sum(vi)) ;

out_ca = nan(size(in_ca)) ;
for idx = 1:size(in_ca,2)
    out_ca(:,idx) = CBIG_HungarianClusterMatch(in_ca(:,min_ind),in_ca(:,idx),0) ;
end
