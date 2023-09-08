function [nei] = get_nei_mat(G)
% get neighbours in the form that the dilate function likes

nei_cell = arrayfun(@(i_)neighbors(G,i_),1:size(G.Nodes,1),'UniformOutput',false) ; 
nei_sz = cellfun(@numel,nei_cell) ; 
nei = ones(length(nei_cell),max(nei_sz)).*-1 ; 
for idx = 1:size(nei,1)
    nei(idx,1:nei_sz(idx)) = nei_cell{idx} ; 
end
