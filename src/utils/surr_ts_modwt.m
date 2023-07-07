function [ surr_ts ] = surr_ts_modwt(ts,filttype)
% my version of wavelet surrogate time series generation
%   1) apply the maximal overlap wavelet decomp
%   2) circular shift the wavelet dims
%   3) reconstruct
% ts (timepointXnodes)

if nargin < 2
    filttype = 'db2' ; 
end

% do the dwt
W = modwt(ts,filttype) ; 
% get some dims
[dd,tt,nn] = size(W) ; % W (dimsXtsXnodes)
W2d = reshape(W,dd*tt,nn) ; % make 2d version for reshuffling

% make the circshift
ind_mat = reshape(1:(dd*tt),dd,tt) ; % repmat(1:nn,dd,1) ;
shufind_mat = ...
    cell2mat(arrayfun(@(x_) ...
    circshift(ind_mat(x_,:),randi(tt)),1:dd,'UniformOutput',false)') ; 

% remake W
W2d_shuff = ...
    cell2mat(arrayfun(@(x_) W2d(shufind_mat(:),x_) , ...
    1:nn  , 'UniformOutput' , false)) ; 
Wshuff = reshape(W2d_shuff,dd,tt,nn) ; 

% inverse discrete wavelet transform
surr_ts = imodwt(Wshuff,filttype) ; 
