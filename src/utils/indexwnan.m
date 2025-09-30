function out = indexwnan(in,indices)
if ~isvector(in)
    error('in data needs to be vector')
end

out = nan(length(indices),1) ; 
placeinds = ~isnan(indices) ; 

out(placeinds) = in(indices(placeinds)) ; 

if isrow(in)
    out = out' ; 
end
