function [outCoefs,lamb,alllamb] = lasso_on_basis(inDat, inBasis,lamb,otherargs)
% inDat = observations x dimension
% inBasis = dimension x numBasis 
%
% outCoefs = numBasis x observations

if nargin < 3 || (~exist('lamb','var') || isempty(lamb))
    warning('no lamba set, will do cv')
    lamb = [] ;
else
    alllamb = NaN ;
end

if ~exist('otherargs','var') || isempty(otherargs)
    otherargs={};
end

[nObvs,dims1] = size(inDat);
[dims2,~] = size(inBasis);

if dims1 ~= dims2
    error('dims do not matchup')
end

if isempty(lamb)
    ll = logspace(log10(10e-4),log10(1),100) ;
    [~,outCoefs] = arrayfun(@(i_) lasso(inBasis,inDat(i_,:)','CV',10,'Lambda',ll,otherargs{:}) , 1:nObvs, ...
        'UniformOutput' , false) ;
    outCoefs = cell2mat(outCoefs);
    alllamb = ll([outCoefs.Index1SE]) ;
    lamb = mode(alllamb) ;
end

%coeffs = regress(inDat(1,:)',inBasis) ; 
outCoefs = cell2mat(arrayfun(@(i_) lasso(inBasis,inDat(i_,:)','Lambda',lamb,otherargs{:}) , 1:nObvs, ...
    'UniformOutput' , false)) ;

