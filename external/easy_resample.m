function[x] = easy_resample(x, s, r, tol)
%EASY_RESAMPLE  upsample or downsample a 1-d signal
% https://www.mathworks.com/matlabcentral/fileexchange/43320-easy-resample
%
% Provides an easy to use wrapper for interp and resample.
%
% USAGE:
% xr = easy_resample(x, s, r, [tol])
%
%INPUTS:
%
%        x: the signal (a 1-D vector)
%        s: sampling rate of the original signal (arbitrary units)
%        r: desired sampling rate of the resampled signal (arbitrary units)
%      tol: optional argument that controls precision of rounding (to
%           nearest tol units)
%
%OUTPUTS:
%
%       xr: the resampled signal
%
%EXAMPLE USAGE:
%       x = 1:10;
%       y = sin(x);
%       hold on;
%       plot(x, y, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
%       plot(easy_resample(x, 1, 10), easy_resample(y, 1, 10), 'k.-', 'LineWidth', 2);
%       plot(easy_resample(x, 1, 10), sin(easy_resample(x, 1, 10)), 'b--', 'LineWidth', 2);
%       hold off;
%       legend({'Original' 'Easy Resample' 'Ground Truth'});
%
%
%SEE ALSO: INTERP, RESAMPLE
%CHANGELOG
% 9-1-13   JRM   Wrote it.
assert(isscalar(s) && s > 0, 'sampling rate must be a positive scalar')
assert(isscalar(r) && r > 0, 'resampling rate must be a positive scalar')
assert(~exist('tol','var') || (isscalar(tol) && tol > 0 && tol < 1), 'tolerance must be a positive scalar between 0 and 1')
if ~exist('tol','var'), tol = 0.1; end
p = s/r;
if p < 1
    x = interp(x,1/p);
elseif p > 1       
    x = resample(x,1/tol,round(p*1/tol));
end