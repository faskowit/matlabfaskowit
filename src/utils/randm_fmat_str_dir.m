function outMat = randm_fmat_str_dir(inMat,maxSw,slopeL)

%% in arguments 

if nargin < 2
   maxSw = 1e6 ; 
end

if nargin < 3
    slopeL = 1000 ;
end

%%

str_dist = @(mat) sum(mat,1)' + sum(mat,2) ;

n = size(inMat,1) ; 

inStrDist = str_dist(inMat) ;

randInd = randperm(n) ;
randMat = inMat(randInd,randInd) ;
randStrDist = str_dist(randMat) ;

sqrterr_vals = zeros(maxSw,1) ;

sqrterr_1 = sum( (inStrDist - randStrDist) .^2) ;
sqrterr_vals(1) = sqrterr_1 ;
sqrterr_thr = sqrterr_1 / 10000 ;

%for idx = 1:nSwitches
idx = 1 ;
while idx < maxSw

    if ~mod(idx,1000) ; disp(idx) ; end
    
    indA = randi(n,[1 2]) ;  
    indB = randi(n,[1 2]) ;
    
    newRand = randMat ; 
    
    valA = randMat(indA(1),indA(2)) ;
    newRand(indA(1),indA(2)) = randMat(indB(1),indB(2)) ;
    newRand(indB(1),indB(2)) = valA ;
    
    newRandStrDist = str_dist(newRand) ;
    sqrterr_2 = sum( (inStrDist - newRandStrDist) .^2) ;

    if sqrterr_2 < sqrterr_1
        idx = idx + 1 ;
        sqrterr_vals(idx) = sqrterr_2 ;
        
        randMat = newRand ; 
        sqrterr_1 = sqrterr_2 ;
    end
    
    % test the slope
    if idx > slopeL 
        m = mean(diff(sqrterr_vals((idx-(slopeL-1)):idx))) ;
        if abs(m) < sqrterr_thr 
            idx = maxSw ;
        end
    end
end

outMat = randMat ;

end
