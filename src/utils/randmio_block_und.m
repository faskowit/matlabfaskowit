function [R,eff]=randmio_block_und(W, CI, ITER)
%RANDMIO_BLOCK_UND     Random graph with preserved degree distribution
%                      within given block structure of network
%
%   R = randmio_block_und(W,CI,ITER);
%   [R eff]=randmio_block_und(W,CI,ITER);
%
%   This function randomizes an undirected network, while preserving the
%   degree distribution and block structure. The function does not preserve
%   the strength distribution in weighted networks. The function is built
%   on top of the randmio_und function. The block structure being preserved
%   means that:
%   dummyvar(CI)'*R*dummyvar(CI) == dummyvar(CI)'*W*dummyvar(CI) [*]
%   [*] note that the on-diagonal will be doubled here, but doesn't matter
%
%   Input:      W,      undirected (binary/weighted) connection matrix
%               CI,     community affiliation vector
%               ITER,   rewiring parameter
%                       (each edge is rewired approximately ITER times)
%
%   Output:     R,      randomized network
%               eff,    number of actual rewirings carried out
%
%   References: Maslov and Sneppen (2002) Science 296:910
%
%
%   randmio_und:
%   2007-2012
%   Mika Rubinov, UNSW
%   Jonathan Power, WUSTL
%   Olaf Sporns, IU
%  
%   randmio_block_und:
%   Josh Faskowitz, IU, 2021

% initialize output
R = W .* 1;

n=size(R,1);
[i,j]=find(tril(R));
K=length(i);
ITER=K*ITER;

% get communitity affiliations
ci_i = CI(i) ;
ci_j = CI(j) ;

% maximal number of rewiring attempts per 'iter'
maxAttempts= round(n*K/(n*(n-1)));
% actual number of successful rewirings
eff = 0;

for iter=1:ITER
    att=0;
    while (att<=maxAttempts)                                     %while not rewired
        while 1
            e1=ceil(K*rand); % select first edge
            a   = i(e1);     b   = j(e1); % edge nodes
            a_c = ci_i(e1);  b_c = ci_j(e1) ; % edge comms assignments
            % now select another edge with same comms pattern
            same_ci = find((ci_i==a_c & ci_j==b_c) | ...
                           (ci_i==b_c & ci_j==a_c)) ;
            n_othr_edges = length(same_ci) ;
            if n_othr_edges>2 % if there is more than one edge here
            ind_e2 = ceil(n_othr_edges*rand) ;
                e2 = same_ci(ind_e2) ;
                while (e2==e1)
                    ind_e2 = ceil(n_othr_edges*rand) ;
                    e2 = same_ci(ind_e2) ;
                end
            else
               continue % pick a new edge if only one edge exists
            end
           
            % get info about second edge
            c=i(e2); d=j(e2);
            c_c = ci_i(e2) ;
            d_c = ci_j(e2) ;
           
            if all(a~=[c d]) && all(b~=[c d])
                break           %all four vertices must be different
            end
        end
       
        if rand>0.5
            i(e2)=d; j(e2)=c; %flip edge c-d with 50% probability
            c=i(e2); d=j(e2); %to explore all potential rewirings
           
            ci_i(e2)=d_c;
            ci_j(e2)=c_c;
           
            c_c=ci_i(e2);
            d_c=ci_j(e2);
        end
       
        % if b and c comms are same...but they are not all part of the same
        % community (e.g. 4-4/4-4)
        if (b_c == c_c) && (b_c ~= a_c)
            % if the rewire will create a new within-community edge, retry
            continue
        end
       
        %rewiring condition
        if ~(R(a,d) || R(c,b))
            R(a,d)=R(a,b); R(a,b)=0;
            R(d,a)=R(b,a); R(b,a)=0;
            R(c,b)=R(c,d); R(c,d)=0;
            R(b,c)=R(d,c); R(d,c)=0;
           
            j(e1) = d;          %reassign edge indices
            j(e2) = b;
            ci_j(e1) = d_c ;
            ci_j(e2) = b_c ;
                         
            eff = eff+1;
            break;
        end %rewiring condition
        att=att+1;
    end %while not rewired
end %iterations

