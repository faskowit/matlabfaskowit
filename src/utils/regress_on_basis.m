function outCoefs = regress_on_basis(inDat, inBasis, inclCons)
% inDat = observations x dimension
% inBasis = dimension x numBasis 
%
% outCoefs = numBasis x observations

if nargin < 3
    inclCons = false ; 
end

[nObvs,dims1] = size(inDat);
[dims2,~] = size(inBasis);

if dims1 ~= dims2
    error('dims do not matchup')
end

if inclCons
    inBasis = horzcat(inBasis,ones(size(inBasis,1),1)) ; 
end

%coeffs = regress(inDat(1,:)',inBasis) ; 
outCoefs = cell2mat(arrayfun(@(i_) regress(inDat(i_,:)',inBasis) , 1:nObvs, ...
    'UniformOutput' , false)) ;
