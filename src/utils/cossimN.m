function [val] = cossimN(Y)
% nDimensional cosine similarity
% https://stats.stackexchange.com/questions/239059/similarity-metrics-for-more-than-two-vectors
% Y = (obs x nDim)

% normalize input Y
ynorm = double(normalize(Y,1,'norm')) ;
val = (svds(ynorm,1)^2-1)/(size(ynorm,2)-1) ;
