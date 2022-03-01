function [ remapped ] = remaplabs(origdat,origlab,newlabs)

% ensure column
origdat = origdat(:) ; 

if nargin < 2
    % this will reorder in ascending order
    origlab = unique(origdat) ;
end

uniqlen = length(origlab) ;

if nargin < 3
   newlabs = 1:uniqlen ;
end

if length(origlab) ~= newlabs
    warning("orig labels and new labels are different lengths")
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

remapped = nan(length(origdat),1) ;

for idx = 1:uniqlen
    origval = origlab(idx) ;
    newval = newlabs(idx) ;
    remapped(origdat==origval) = newval ; 
end
