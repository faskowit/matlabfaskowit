function [dat_disc, edges] = prct_discretize(dat,nbins)
% disscretize into percentile bins.. all bins should have same number of
% data points

edges = [-inf quantile(dat,nbins-1)  inf ] ;
dat_disc = discretize(dat,edges) ;
