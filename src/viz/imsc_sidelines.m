function h = imsc_sidelines(dat,ca,cmap,labwidth,addgrid,sortit)

if nargin < 3
    error('need 3 inputs')
end

if nargin < 4
    labwidth = 10 ; 
end

if nargin < 5
    addgrid = 0 ;
end

if nargin < 6
    sortit = 1 ;
end

%%

if sortit == 1
    [~,INDSORT] = sort(ca) ;
    h = imagesc(dat(INDSORT,INDSORT)) ;
    casort = ca(INDSORT) ; 
else
    h = imagesc(dat) ;
    casort = ca ; 
end

ulabs = unique(ca) ; 
ulabs = ulabs(ulabs>0) ; 
nc = length(ulabs) ; 

hold on
for idx = 1:nc
    ind = find(casort == ulabs(idx));
    if ~isempty(ind)
        mn = min(ind) - 0.5;
        mx = max(ind) + 0.5;
        x = [-labwidth*1.25  -labwidth*1.25 ];
        y = [mn mx ];
        plot(x,y,'Color',cmap(idx,:),'linewidth',labwidth,'Clipping','off'); 
        x = [ nc-labwidth*1.7 nc-labwidth*1.7 ] ;
        plot(y,x,'Color',cmap(idx,:),'linewidth',labwidth,'Clipping','off');
    end
end
hold off

yticks([])

%% add grid?

if addgrid

hold on
for idx = 1:nc
    ind = find(casort == ulabs(idx));
    if ~isempty(ind)
        mn = min(ind) - 0.5;
        mx = max(ind) + 0.5;

        xline(mn,'LineWidth',1,'Color',[1 1 1 0.5])
        yline(mn,'LineWidth',1,'Color',[1 1 1 0.5])

        xline(mx,'LineWidth',1,'Color',[1 1 1 0.5])
        yline(mx,'LineWidth',1,'Color',[1 1 1 0.5])

    end
end
hold off    

end