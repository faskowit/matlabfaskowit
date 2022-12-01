function [boolval,matchingval] = multistrcmp(singstr,multistr)
% sting compare... but the second string can be an array... will evaluate
% to true if any in the array come out matching

n = length(multistr) ;
matchingval = nan(n,1) ; 
for idx = 1:n
    matchingval(idx) = strcmp(singstr,multistr(idx)) ;
end
boolval = any(matchingval) ;
