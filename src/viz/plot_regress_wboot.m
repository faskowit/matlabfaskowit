function [h] = plot_regress_wboot(x,y,bootIter)  

%% the full traditional regression

% the original regression. add a column of 1's for the intercept
X = [x ones(length(x),1)] ;

% full regression
[fullRegress,~,~,~,stats] = regress(y,X) ; 

disp(['R^2 is: ' num2str(stats(1))])
disp(['p-val is: ' num2str(stats(3))])

disp(['slope: ' num2str(fullRegress(1))])
disp(['y-intercept: ' num2str(fullRegress(2))])

% and draw that regression line
xVec = min(x):((max(x)-min(x))/200):max(x); % important var for drawing
yhat = polyval(fullRegress,xVec); % the yvals of line

hold on
plot(xVec,yhat,'Color',[0.5 0.5 0.5],'linewidth',2.5);

%% now the bootstrapping

% get the slope and intercept 
boot = bootstrp(bootIter, @regress, y, X);

% get the confidence intervals
bootCI = zeros(size(boot,1),length(xVec)) ;
for idx = 1:bootIter
    bootCI(idx,:) = polyval(boot(idx,:),xVec);  
end
p95 = prctile(bootCI,[2.5,97.5]);    

%% add to the scatter (from above)

hold on;
fill([xVec fliplr(xVec)],[p95(1,:) fliplr(p95(2,:))],[ 0.75 0.75 0.75 ],'facealpha',.7,'edgealpha',0);

% and the line
yhat = polyval(fullRegress,xVec); 
plot(xVec,yhat,'Color',[0.5 0.5 0.5],'linewidth',2.5);

