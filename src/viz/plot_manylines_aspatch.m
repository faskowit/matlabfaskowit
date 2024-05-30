function [ h , pbin_spans , cmap ] = plot_manylines_aspatch(inlines,patchcolor,pbins,varargin)
% inlines should be matrix, where each column is data you want to plot

if nargin < 2
    patchcolor = [ 0 0.447 0.741 ] ; 
end

if nargin < 3
    pbins = 0:25 ; 
end

pbinstiles = flipud([ (pbins)' 100-(pbins)' ]) ;
pbin_spans = pbinstiles(:,2) - pbinstiles(:,1) ; 

x = 1:size(inlines,1) ;

% make the low density more visibile by making it ~10%
lowbump = floor(size(pbinstiles,1)*0.1) ; 

cmap = [1 1 1 ; patchcolor ]; % white to color
cmap = interp1(linspace(0,1,size(cmap,1)),cmap, ...
    linspace(0,1,size(pbinstiles,1)+1+lowbump)); % +1 so that the end isn't white
cmap = flipud(cmap) ; 
cmap = cmap(1:size(pbinstiles,1),:) ; 

for idx = fliplr(1:length(pbinstiles))
    % disp(idx)
    y = prctile(inlines',pbinstiles(idx,:)) ; 

    hold on
%     fill([x fliplr(x)], [y(1,:) fliplr(y(2,:))], [0 0.447 0.741] , 'facealpha', 0.1, 'edgealpha', 0 )
    fill([x fliplr(x)], [y(1,:) fliplr(y(2,:))], cmap(idx,:), 'edgealpha', 0 , varargin{:})

end

hold off

h = gca ;
