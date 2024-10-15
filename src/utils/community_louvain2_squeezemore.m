function [M,Q1] = community_louvain2_squeezemore(W,gamma,M,B,Qthresh,maxLoops)

n = size(W,1) ;

if ~exist('M','var') || isempty(M)
    M=1:n; % initial community affiliations 
% elseif numel(M)~=n
%     error('M must contain n elements.')
end

if ~exist('Qthresh','var') || isempty(Qthresh)
    Qthresh = 1e-4 ;
end

if ~exist('maxLoops','var') || isempty(maxLoops)
    maxLoops = 100 ; 
end%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%
Q0 = -1; Q1 = 0;            % initialize modularity values
loopCount = 0 ;

% loop it
while Q1-Q0>Qthresh           % while modularity increases
    % disp([ 'louvain rep ' num2str(loopCount)])

    Q0 = Q1;                    
    [M, Q1] = community_louvain2(W, gamma, M, B);

    % check if we running for too long
    loopCount = loopCount + 1 ;
    if loopCount > maxLoops 
        warning(strcat('wrapper did not converge in ',num2str(loopCount),' loops'))
        break
    end
end

