function h = imsc_w_gridlines(A,varargin)

h = imagesc(A,varargin{:}) ; 

nx = size(A,2);
ny = size(A,1);
edge_x = repmat((0:nx)+0.5, ny+1,1);
edge_y = repmat((0:ny)+0.5, nx+1,1).';

hbool = ishold() ; 
if ~hbool ; hold on ; end 

plot(edge_x ,edge_y, ' k') % vertical lines
plot(edge_x.', edge_y.', 'k') % horizontal lines

if ~hbool ; hold off ; end 
