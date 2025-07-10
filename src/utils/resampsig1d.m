function [out,t_resampled] = resampsig1d(signal,hz_signal,hz_resampled)
% https://stackoverflow.com/questions/47789868/resampling-of-time-signal-in-matlab

t_original = [0:1/hz_signal:(1/hz_signal*(length(signal)-1))];%current time signal
t_resampled = [0:1/hz_resampled:max(t_original)];%new time signal
out = interp1(t_original,signal,t_resampled);
out = out(:) ; 
