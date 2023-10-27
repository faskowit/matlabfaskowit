function [outCoefs,outResNorm,outRes] = lsqnonneg_on_basis(inDat, inBasis, inclCons)
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

[aaa,rrr1,rrr2] = arrayfun(@(i_) lsqnonneg(double(inBasis),double(inDat(i_,:)')) , 1:nObvs, ...
    'UniformOutput' , false) ;

%coeffs = regress(inDat(1,:)',inBasis) ; 
outCoefs = cell2mat(aaa) ;
outResNorm = cell2mat(rrr1) ; 
outRes = cell2mat(rrr2) ;
