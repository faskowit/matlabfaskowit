function [coreness] = coreness_stat(W,ca,gamm)
% ripped out of BCT func

% setup
n = size(W,1);                              % number of nodes
W = double(W);                              % convert from logical
W(1:n+1:end) = 0;                           % clear diagonal

if ~exist('gamm','var')
    gamm = 1;
end

% Methodological note: cf. community detection, the core-detection
% null model is not corrected for degree (to enable detection of hubs).
s = sum(W(:));
p = mean(W(:));
b = W - gamm*p;
B = (b+b.')/(2*s);                          % directed core-ness matrix

coreness = sum(sum(B(ca,ca))) - sum(sum(B(~ca,~ca)));  % return core-ness statistic
