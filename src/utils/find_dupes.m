function [dupeinds,retainfirst] = find_dupes(in)

[~, uidx] = unique(in);
dupeinds = ismember( in, in( setdiff( 1:numel(in), uidx ) ) ) ; 
dupes = in(dupeinds) ; 

rr = ismember(1:length(in),arrayfun(@(i_) find(in==i_,1,'first'),  unique(dupes)' ))' ;
retainfirst = rr == dupeinds ; 