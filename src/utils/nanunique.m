function out = nanunique(dat)
out = unique(dat(~isnan(dat))) ; 