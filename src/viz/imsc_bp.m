function [h] = imsc_bp(X,tt,varargin)

if ~exist('tt','var')
   tt = [] ; 
end

h = imagesc(X,varargin{:}) ;
if ~isempty(tt)
    title(tt)
end
waitforbuttonpress
