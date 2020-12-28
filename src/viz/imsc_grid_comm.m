function [h, INDSORT] = imsc_grid_comm(dat,ca,lineWidth,color,offD,names)
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

if ~exist('offD','var') || isempty(offD)
   offD = 0 ; 
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
    Y1 =  Y(1:6:end) ; Y2 =  Y(2:6:end) ;
    Y3 = (Y2+Y1) ./ 2 ;
    ax.YTick = Y3 ; 
    ax.YTickLabel = names ;
end

%% off diagonal lines

if offD

    hold on
    breaks = X(3:6:end) ;

    % plot off diagonal
    for idx = 1:(length(breaks)-1)

        lineWidth = 0.5;
        %offDiagColor = [1 0 0 0.25] ; 
        offDiagColor = [1 1 1 0.55] ; 

        % vertical   
        plot([breaks(idx),breaks(idx)],[breaks(idx+1),breaks(end)],...
            'Color',offDiagColor,'LineWidth',lineWidth);
        if idx > 1
            plot([breaks(idx),breaks(idx)],[-0.5,breaks(idx-1)],...
                'Color',offDiagColor,'LineWidth',lineWidth);
        end
        % horizontal
        plot([breaks(idx+1),breaks(end)],[breaks(idx),breaks(idx)],...
            'Color',offDiagColor,'LineWidth',lineWidth);
        if idx > 1
            plot([-.5,breaks(idx-1)],[breaks(idx),breaks(idx)],...
                'Color',offDiagColor,'LineWidth',lineWidth);
        end
    end  
    hold off
end
