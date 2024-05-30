function out = comp_mats_jaccard(cij1,cij2)

if size(cij1) ~= size(cij2)
    error('size of mats must be the same')
end

n = size(cij1,1) ; 

out = zeros(n,1) ; 

for idx = 1:n
    out(idx) = jaccard(cij1(idx,:),cij2(idx,:)) ; 
end

