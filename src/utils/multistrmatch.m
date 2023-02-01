function [boolval,matchingval] = multistrmatch(singstr,multistr)
% string regexp, looking just for matches

multistr = cellstr(multistr) ;
n = length(multistr) ;
matchingval = nan(n,1) ; 
for idx = 1:n
    tt = regexp(singstr,multistr(idx)) ;
    matchingval(idx) = ~isempty(tt{1}) ; 
end
boolval = any(matchingval) ;
