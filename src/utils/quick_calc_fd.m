function [fwd] = quick_calc_fd(mot,rot_inds)

if nargin < 2
   rot_inds = logical([ 0 0 0 1 1 1 ]) ;  
end

if sum(rot_inds==0) ~= 3
    error('need 3 columns: x, y, and z for translation')
end

if sum(rot_inds==1) ~= 3
    error('need 3 columns: x, y, and z for rotation')
end

% we assume that the 'mot' matrix is structured like:
% x axis: number of time points
% y axis: x translation, y trans., z trans, x rotation, y rot., z rot. (6
% columns total)

radius = 50; 
ts = mot;
tmp = mot(:,rot_inds).*(180/pi); %convert to degrees
tmp = (2*radius*pi/360)*tmp;
ts(:,rot_inds) = tmp;
dts = diff(ts); % temporal difference
fwd = sum(abs(dts),2);
fwd = [0;fwd]; % add a zero to the beginning.
