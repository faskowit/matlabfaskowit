function E = my_efficiency_wei(W, local, transdist)
% slightly modified copy of efficiency function from BCT; added transdist
% and added distance floyd to speed things up drastically
% J.F 
%
%   Inputs:     W,
%                   weighted undirected or directed connection matrix
%
%               local,
%                   optional argument
%                   local=0  computes the global efficiency (default).
%                  	local=1  computes the original version of the local
%                               efficiency.
%               	local=2  computes the modified version of the local
%                               efficiency (recommended, see below). 

%Modification history
% 2011: Original (based on efficiency.m and distance_wei.m)
% 2013: Local efficiency generalized to directed networks
% 2017: Added the modified local efficiency and updated documentation.

if nargin < 3
    transdist = 'inv' ;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n = length(W);                                              % number of nodes
ot = 1 / 3;                                                 % one third

L = W .* 1; % make copy                                     % connection-length matrix
A = W > 0;                                                  % adjacency matrix

switch transdist
    case 'inv'
        L(A) = 1 ./ L(A);
    case 'log'
        L(A) = -log(L(A)./ (max(L(A))+eps)) ; % +eps makes no 0 distances
    otherwise
        error('not a valid transdist') 
end

A = double(A);

if exist('local','var') && local                            % local efficiency
    E = zeros(n, 1);
    cbrt_W = W.^ot;
    switch local
        case 1
            for u = 1:n
                V  = find(A(u, :) | A(:, u).');             % neighbors
                sw = cbrt_W(u, V) + cbrt_W(V, u).';       	% symmetrized weights vector
                di = distance_inv_wei(L(V, V));             % inverse distance matrix
                se = di.^ot + di.'.^ot;                     % symmetrized inverse distance matrix
                numer = (sum(sum((sw.' * sw) .* se)))/2;   	% numerator
                if numer~=0
                    sa = A(u, V) + A(V, u).';              	% symmetrized adjacency vector
                    denom = sum(sa).^2 - sum(sa.^2);        % denominator
                    E(u) = numer / denom;                   % local efficiency
                end
            end
        case 2
            cbrt_L = L.^ot;
            for u = 1:n
                V  = find(A(u, :) | A(:, u).');            	% neighbors
                sw = cbrt_W(u, V) + cbrt_W(V, u).';       	% symmetrized weights vector
                di = distance_inv_wei(cbrt_L(V, V));      	% inverse distance matrix
                se = di + di.';                             % symmetrized inverse distance matrix
                numer=(sum(sum((sw.' * sw) .* se)))/2;      % numerator
                if numer~=0
                    sa = A(u, V) + A(V, u).';             	% symmetrized adjacency vector
                    denom = sum(sa).^2 - sum(sa.^2);        % denominator
                    E(u) = numer / denom;                 	% local efficiency
                end
            end
    end
else
    di = distance_inv_wei(L);
    E = sum(di(:)) ./ (n^2 - n);                         	% global efficiency
end

function D=distance_inv_wei(L)
% inverted distance using faster floyd
    
D = distance_wei_floyd(L) ;
D=1./D;                                                     % invert distance
D(1:(size(L,1)+1):end)=0;

end

end % end of my efficiency
