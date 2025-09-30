function out = dummyvaroppo(dumvar) ; 
% opposite of dummyvar

if ~all(sum(dumvar,2)==1)
    error('error--is it a correct dummyvar?')
end

[~,out] = max(dumvar,[],2) ; 
