function [relabs] = relabel_2_centroid(inComms) 

nComms = size(inComms,2) ; 

% get the central
[~,minposition] = min(sum(partition_distance(inComms))) ;
centroid = inComms(:,minposition) ;

% CBIG_HungarianClusterMatch(ref_labels, input_labels, disp_flag)
relabs = arrayfun(@(xx) CBIG_HungarianClusterMatch( ...
    centroid,inComms(:,xx),0) , ...
    1:nComms,'UniformOutput', false) ;