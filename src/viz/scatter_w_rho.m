function [h,t] = scatter_w_rho(x,y,varargin)

h = scatter(x,y,varargin{:}) ; 
c = corr(x(:),y(:),"type","Spearman",'Rows','complete') ;
t = text(0.01,0.05,[ '\rho : ' num2str(round(c,2)) ],'Units','normalized') ; 
