function [outmat] = od_replace(inmat,odval) 

if nargin < 2
    odval = 0 ;
end

outmat = inmat .* 1 ;
outmat(1:size(inmat,1)+1:end) = odval ; 
