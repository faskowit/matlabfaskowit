function outMat = randm_fmat_str_und(inMat,maxSw,slopeL)

% in arguments 

if nargin < 2
   maxSw = 1e6 ; 
end

if nargin < 3
    slopeL = 1000 ;
end

% check for symmetry
if ~issymmetric(inMat)
   exit('input matrix is symmetric for this function') ; 
end

%% runit

str_dist = @(mat) sum(mat,1) ;

n = size(inMat,1) ; 
inStrDist = str_dist(inMat) ;

randInd = randperm(n) ;
randMat = inMat(randInd,randInd) ;
randStrDist = str_dist(randMat) ;

sqrterr_vals = zeros(maxSw,1) ;

sqrterr_1 = sum( (inStrDist - randStrDist) .^2) ;
sqrterr_vals(1) = sqrterr_1 ;
sqrterr_thr = sqrterr_1 / 10000 ;

idx = 1 ;
jdx = 1 ;
while idx < maxSw
    jdx = jdx + 1 ;
    
    % if ~mod(jdx,1000) ; disp(idx) ; end
    
    indA = randi(n,[1 2]) ; 
    indB = randi(n,[1 2]) ;
    % exchange only in upper triangle
    if diff(indA) < 0 ; indA = fliplr(indA) ; 
        elseif diff(indA) == 0 ; continue ; end
    if diff(indB) < 0 ; indB = fliplr(indB) ;
        elseif diff(indB) == 0 ; continue ; end
      
    newRand = triu(randMat,1) ; 
    
    valA = randMat(indA(1),indA(2)) ;
    newRand(indA(1),indA(2)) = randMat(indB(1),indB(2)) ;
    newRand(indB(1),indB(2)) = valA ;
    
    newRand = newRand + newRand' ;
    
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
