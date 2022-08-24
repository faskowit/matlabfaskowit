function o = triunroll(x_,k)
if nargin<2
    k=1 ;
end
o = x_(logical(triu(ones(size(x_,1)),k))) ;