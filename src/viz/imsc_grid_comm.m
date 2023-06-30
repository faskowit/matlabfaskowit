function [h, INDSORT, Nameticks] = imsc_grid_comm(dat,ca,lineWidth,color,offD,names)
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

% grid comms
[X,Y,INDSORT] = grid_communities(ca) ;
h = imagesc(dat(INDSORT,INDSORT)) ;

%% off diagonal lines

if sum(offD) > 0

    hold on
    breaks = X(3:6:end) ;

    % plot off diagonal
    for idx = 1:(length(breaks)-1)

        odlineWidth = 0.5;
        %offDiagColor = [1 0 0 0.25] ; 
        if length(offD) > 1
            offDiagColor = offD ;
        else
            offDiagColor = [1 1 1 0.55] ; 
        end

        % vertical   
        plot([breaks(idx),breaks(idx)],[breaks(idx+1),breaks(end)],...
            'Color',offDiagColor,'LineWidth',odlineWidth);
        if idx > 1
            plot([breaks(idx),breaks(idx)],[-0.5,breaks(idx-1)],...
                'Color',offDiagColor,'LineWidth',odlineWidth);
        end
        % horizontal
        plot([breaks(idx+1),breaks(end)],[breaks(idx),breaks(idx)],...
            'Color',offDiagColor,'LineWidth',odlineWidth);
        if idx > 1
            plot([-.5,breaks(idx-1)],[breaks(idx),breaks(idx)],...
                'Color',offDiagColor,'LineWidth',odlineWidth);
        end
    end  
    hold off
end

%% on-diagonal lines

if lineWidth > 0
    hold on;  
    pp = plot(X,Y,'Color',color,'linewidth',lineWidth) ;
    uistack(pp,'top');
    hold off;
end

%% name 

Y1 =  Y(1:6:end) ; Y2 =  Y(2:6:end) ;
Nameticks = (Y2+Y1) ./ 2 ;

if ~isempty(names)
    
    if length(unique(ca))~=length(names)
        error('names must have entry for each community')
    end
    
    ax = gca ;
    ax.YTick = Nameticks ; 
    ax.YTickLabel = names ;
    set(ax, 'TickLabelInterpreter', 'none')

end
