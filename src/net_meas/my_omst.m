function [omst,maxi] = my_omst(mat,costfun)
% interatively applying minimum spanning trees, and picking threshold that
% maximizes the value of transitivity - fraction edges used. this is not
% the original version of omst is descibed here: https://www.frontiersin.org/journals/neuroinformatics/articles/10.3389/fninf.2017.00028/full 

if nargin < 2
    costfun = 'trans' ; 
end

switch costfun
    case 'trans'
        costfunc = @transitivity_bu ;
    case 'eff'
        costfunc = @efficiency_bin ; 
    otherwise
   
end

% in-line mst func using matlab's built in func
mat_mst = @(x_)full(adjacency(minspantree(graph(x_)))) ; 

nnodes = size(mat,1) ; 
mm = mat.*1 ; 
costcurve = zeros(10,1) ; 
mmask = logical(triu(ones(nnodes),1)) ;

idx = 1 ; 
while true % loop until all edges considered... definitely inefficient...

    tmpmst = mat_mst(mm) ; % do the mst
    mm(logical(tmpmst(:))) = inf ; % mark 

    costcurve(idx) = costfunc(isinf(mm)) - ...
        (sum(isinf(mm).*mat,'all') ./ sum(mat,'all')) ; 

    if all(isinf(mm(mmask))) || idx > nnodes 
        break
    end

    idx = idx + 1;

end

%% get max val of the curve

[~,maxi] = max(costcurve) ; 

% apply mst the number of times to reach the max val
mm = mat.*1 ; % reset variable
for idx = 1:maxi
    tmpmst = mat_mst(mm) ; % do the mst
    mm(logical(tmpmst(:))) = inf ; % mark 
end
omst = isinf(mm) ; 

