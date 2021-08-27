function [] = imsc_outl_entries(pos_grid,colr)

if nargin < 2
   colr = [ 0 0 0 ] ; 
end

[xx,yy] = find(pos_grid) ;
pos = [ xx yy ] ;

% for each coordinate
for idx = 1:height(pos)
    
    curr_pos = fliplr(pos(idx,:)) ;
    rect = [ curr_pos-0.5 1 1 ] ;
    
    rectangle('Position',rect,'EdgeColor',colr) 
    
end
