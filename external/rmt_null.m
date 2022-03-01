function M = rmt_null(inTS)
% https://www.mathworks.com/matlabcentral/fileexchange/49011-random-matrix-theory-rmt-filtering-of-financial-time-series-for-community-detection

% minimally adapted for normal timeseries
%
% INPUTS:
%           inTS: samples x nodes time series
% OUTPUTS
%           M: mod matrix

%% FinRMT
% FinRMT uses Random Matrix Theory (RMT) to create a filtered correlation 
% matrix from a set of financial time series price data, for example the
% daily closing prices of the stocks in the S&P
%% Syntax
% M=FinRMT(priceTS)
%
%% Description
% This function eigendecomposes a correlation matrix of time series
% and splits it into three components, Crandom, Cgroup and Cmarket,
% according to techniques from literature (See, "Systematic Identification
% of Group Identification in Stock Markets, Kim & Jeong, (2008).") and
% returns a filtered correlation matrix containging only the Cgroup
% components.
% The function is intended to be used in conjunction with a community
% detection algorithm (such as the Louvain method) to allow for community 
% detecion on time series based networks.

N = size(inTS,2);      % N is the number of time series
T = size(inTS,1);      % T is the lenght of each series 
    
%Create the initial correlation matrix and ensure it's symmetric
%It should be symmetric but sometimes matlab introduces small roundoff
%errors that would prevent an IsSymmetric call from returning true.
%This folding of the matrix will suffice to solve that.
    
C = corrcoef(inTS);    % Create a correlation matrix and ensure
C = .5 * (C+C');        % it's symmetric

% Decompose the correlation matrix into its eigenvalues and eigenvectors,
% store the indices of which columns the sorted eigenvalues come from
% and arrange the columns in this order
[V,D] = eig(C);
[eigvals, ind]=sort(diag(D),'ascend'); 
V = V(:,ind);
D=diag(sort(diag(D),'ascend')); 
% Find the index of the predicted lambda_max, ensuring to check boundary
% conditions
Q=T/N;
sigma = 1 - max(eigvals)/N;
RMTmaxEig = sigma*(1 + (1.0/Q) + 2*sqrt(1/Q));
RMTmaxIndex = find(eigvals > RMTmaxEig);
if isempty(RMTmaxIndex)
    RMTmaxIndex = N;
else
    RMTmaxIndex = RMTmaxIndex(1);
end
% Find the index of the predicted lambda_min, ensuring the check boundary
% conditions
RMTminEig = sigma*(1 + (1.0/Q) - 2*sqrt(1/Q));
RMTminIndex = find(eigvals < RMTminEig);
if isempty(RMTminIndex)
    RMTminIndex = 1;
else
    RMTminIndex = RMTminIndex(end);
end
% Determine the average Eigenvalue to rebalance the matrix after removing
% Any of the noise and/or market mode components
avgEigenValue = mean(eigvals(1:RMTmaxIndex));
% Build a new diagonal matrix consisting of the group eigenvalues
Dg = zeros(N,N);
% Replace the random component with average values.
Dg(1 : (N+1) : (RMTmaxIndex-1)*(N+1)) = avgEigenValue;
% Add the group component. The N+1 here is just used to increment to the 
% next diagonal element in the matrix
Dg(1+(N+1)*(RMTmaxIndex-1) : (N+1) : end-(N+1)) = D(1+(N+1)*(RMTmaxIndex-1) : (N+1) : end-(N+1));
% Build the component correlation matrix from the new diagonal eigenvalue
% matrix and eigenvector matrix. The eigenvectors corresponding to zero
% valued eigenvalue entries in Dg will not contribute to M
M = V * Dg * V.';
% Replace the diagonals with 1s
M = M - diag(diag(M)) + eye(N);

end

% Copyright (c) 2012, Mel
% All rights reserved.
% 
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
% 
% * Redistributions of source code must retain the above copyright notice, this
%   list of conditions and the following disclaimer.
% 
% * Redistributions in binary form must reproduce the above copyright notice,
%   this list of conditions and the following disclaimer in the documentation
%   and/or other materials provided with the distribution
% * Neither the name of University of Leiden nor the names of its
%   contributors may be used to endorse or promote products derived from this
%   software without specific prior written permission.
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
% DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
% FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
% DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
% SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
% CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
% OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
% OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.