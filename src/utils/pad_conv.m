function [outsig] = pad_conv(a,b,padamount,padtype)

n = length(a) ;

if nargin < 3
    padamount = round(n*.2) ; 
end

if nargin < 4
    padtype = 'replicate' ;  
end

a = a(:) ;
b = b(:) ;
 
apad =  padarray(a,padamount,padtype) ;

s = conv(apad,b) ;

outsig = s((padamount+1):(end-padamount)) ;

