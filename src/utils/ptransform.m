function out = ptransform(dat,vals) 
% percentile transform of the rows of dat

if nargin < 2
    vals = 1:100 ; 
end

fun = @(x_) discretize(x_,[ min(x_) prctile(x_,vals) ]) ; 

out = cell2mat(...
        arrayfun(@(i_) fun(dat(i_,:)) , 1:size(dat,1) , ...
        'UniformOutput' , false)'...
    ) ; 


