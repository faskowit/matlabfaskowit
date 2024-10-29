function [omst] = my_omst(mat)
% interatively applying minimum spanning trees, and picking threshold that
% maximizes the value of transitivity - fraction edges used

mat_mst = @(x_)full(adjacency(minspantree(graph(x_)))) ; 

nnodes = size(mat,1) ; 
mm = mat.*1 ; 
costcurve = zeros(10,1) ; 
mmask = logical(triu(ones(nnodes),1)) ;

idx = 1 ; 
while true

    tmpmst = mat_mst(mm) ; % do the mst
    mm(logical(tmpmst(:))) = inf ; % mark 

    costcurve(idx) = transitivity_bu(isinf(mm)) - (sum(isinf(mm).*mat,'all') ./ sum(mat,'all')) ; 

    if all(isinf(mm(mmask)))
        break
    end

    idx = idx + 1;

end

%% get max val

[~,maxi] = max(costcurve) ; 

mm = mat.*1 ; 
for idx = 1:maxi
    tmpmst = mat_mst(mm) ; % do the mst
    mm(logical(tmpmst(:))) = inf ; % mark 
end
omst = isinf(mm) ; 

disp('t4t')