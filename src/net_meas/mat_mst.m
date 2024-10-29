function [mst] = mat_mst(dat)
mst = full(adjacency(minspantree(graph(dat)))) ; 
