function [outsig,outsigtrm] = pad_conv(a,b,padamount,padtype)
% a should be samples x channels

n = size(a,1) ;

if nargin < 3
    padamount = round(n*.2) ; 
end

if nargin < 4
    padtype = 'replicate' ;  
end

if size(a,2) == 1 
    [outsig,outsigtrm] = padc(a,b,padamount,padtype) ; 
else
    [aa,bb] = arrayfun(@(i_) padc(a(:,i_),b,padamount,padtype) , ...
        1:size(a,2), 'UniformOutput',false) ;
    outsig = cell2mat(aa) ;
    outsigtrm = cell2mat(bb) ; 
end


end

function [outsig,outsigtrm] = padc(a,b,padamount,padtype)

a = a(:) ;
b = b(:) ;
 
apad =  padarray(a,padamount,padtype) ;

s = conv(apad,b) ;

outsig = s((padamount+1):(end-padamount)) ;
outsigtrm = outsig(1:length(a)) ; 

end