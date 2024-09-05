function imsc_addsquare(ca1,ca2,mirrorit,linecolor,linewidth)

if nargin < 2
    error('need two args')
end

if nargin < 3
    mirrorit = 1 ;
end

if nargin < 4
    linecolor = 'r' ; 
end

if nargin < 5
    linewidth = 2.5 ; 
end

ind1 = find(ca1) ; 
ind2 = find(ca2) ; 

mn1 = min(ind1) - 0.5 ; 
mx1 = max(ind1) + 0.5 ; 
mn2 = min(ind2) - 0.5 ; 
mx2 = max(ind2) + 0.5 ; 

% top 
X = [mn2 mx2] ; 
Y = [mn1 mn1] ; 

% right 
x = [mx2 mx2 ] ;
y = [mn1 mx1 ] ; 
X = [X x] ;
Y = [Y y] ; 

% bottom
% right 
x = [mx2 mn2 ] ;
y = [mx1 mx1 ] ; 
X = [X x] ;
Y = [Y y] ; 

% left
x = [mn2 mn2 ] ;
y = [mx1 mn1 ] ; 
X = [X x] ;
Y = [Y y] ; 

hbool = ishold() ; 

% draw it
if ~hbool ; hold on ; end 
h = line(X,Y,'Color',linecolor,'LineWidth',linewidth) ; uistack(h,'top')
if mirrorit
    h = line(Y,X,'Color',linecolor,'LineWidth',linewidth) ;  ; uistack(h,'top')
end
if ~hbool ; hold off ; end 
