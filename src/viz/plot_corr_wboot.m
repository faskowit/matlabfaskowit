function [h] = plot_corr_wboot(X,y,bootIter)  

X = X(:) ; 
y = y(:) ; 

assert(length(X)==length(y),'vectors must be same length')

% corr
r = corr(X,y) ; 

%% now the bootstrapping

% get the slopes
boot = bootstrp(bootIter, @corr, y, X);

% get the confidence intervals
bootCI = zeros(size(boot,1),length(X)) ;
for idx = 1:bootIter
    bootCI(idx,:) = corr(boot(idx,:),X);  
end
p95 = prctile(bootCI,[2.5,97.5]);    

%% add to the scatter (from above)

hold on;
fill([xVec fliplr(xVec)],[p95(1,:) fliplr(p95(2,:))],[ 0.75 0.75 0.75 ],'facealpha',.7,'edgealpha',0);

lsline(r)



