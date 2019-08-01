function outvals = lab_reassign(invec,newvals)
% relabel the unique vals to the new inds, correspondance determined by
% order of the vecs

oldvals = unique(invec) ;
outvals = zeros(size(invec)) ;

for ind = oldvals'
    outvals(invec == newvals(ind)) = ind ;
end

