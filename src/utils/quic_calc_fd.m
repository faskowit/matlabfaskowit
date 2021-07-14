function [fwd] = quic_calc_fd(mot,rot_inds)

if nargin < 2
   rot_inds = [ 0 0 0 1 1 1 ] ;  
end

radius = 50; 
ts = mot;
tmp = mot(:,rot_inds)*180/pi; %convert to degrees
tmp = (2*radius*pi/360)*tmp;
ts(:,4:6) = tmp;
dts = diff(ts);
fwd = sum(abs(dts),2);
fwd = [0;fwd];
