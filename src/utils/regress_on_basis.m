function outCoefs = regress_on_basis(inDat, inBasis)
% inDat = observations x dimension
% inBasis = dimension x numBasis 
%
% outCoefs = numBasis x observations

[nObvs,dims1] = size(inDat);
[dims2,~] = size(inBasis);

if dims1 ~= dims2
    error('dims do not matchup')
end

%coeffs = regress(inDat(1,:)',inBasis) ; 
outCoefs = cell2mat(arrayfun(@(i_) regress(inDat(i_,:)',inBasis) , 1:nObvs, ...
    'UniformOutput' , false)) ;
