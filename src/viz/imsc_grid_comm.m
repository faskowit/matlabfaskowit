function [h, INDSORT] = imsc_grid_comm(dat,ca,lineWidth,color)
% 
% dat = your data
% ca = community affliation of your vector

if ~iscolumn(ca) 
   ca = ca' ; 
end

if nargin < 3
   lineWidth = 2 ; 
end

if nargin < 4
   color = [1 0 0] ; 
end

[X,Y,INDSORT] = grid_communities(ca) ;
h = imagesc(dat(INDSORT,INDSORT)) ;
hold on;  
plot(X,Y,'Color',color,'linewidth',lineWidth) ;
hold off;