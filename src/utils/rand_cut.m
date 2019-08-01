function [newVec] = rand_cut(inVec) 

    if ~iscolumn(inVec)
       inVec = inVec' ; 
    end

    lenVec = length(inVec) ;
    rndint = randi(lenVec,1) ;
    strtsz = lenVec - rndint + 1 ;
    newVec = zeros(lenVec,1) ;
    
    newVec(1:strtsz) = inVec(rndint:lenVec) ;
    newVec((strtsz+1):lenVec) = inVec(1:(rndint-1)) ;   

end