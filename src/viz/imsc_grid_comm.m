function [h, INDSORT] = imsc_grid_comm(dat,ca,lineWidth,color,names)
% 
% dat = your data
% ca = community affliation of your vector

if ~iscolumn(ca) 
   ca = ca' ; 
end

if ~exist('lineWidth','var') || isempty(lineWidth)
   lineWidth = 2 ; 
end

if ~exist('color','var') || isempty(color)
   color = [1 0 0] ; 
end

if ~exist('names','var') || isempty(names)
   names = [] ; 
end


[X,Y,INDSORT] = grid_communities(ca) ;
h = imagesc(dat(INDSORT,INDSORT)) ;
hold on;  
plot(X,Y,'Color',color,'linewidth',lineWidth) ;
hold off;


if ~isempty(names)
    
    if length(unique(ca))~=length(names)
        error('names must have entry for each community')
    end
    
    ax = gca ;

    Y1 =  Y(1:6:end) ;
    Y2 =  Y(2:6:end) ;
    Y3 = (Y2+Y1) ./ 2 ;

    ax.YTick = Y3 ; 
    ax.YTickLabel = names ;

end
