function [] = disp_prog(ind,total,prnt)
 
if nargin < 3
    prnt = 10 ;
end

%% wrap manually 

% cms = get(0,'CommandWindowSize'); 
% width = cms(1);
width = 33 ; 

if ~mod(ind,width)
    fprintf('\n')
end

%% print progress

pp = floor(total*prnt/100) ;
if ~mod(ind,pp)
    fprintf('%d%%',floor(ind/total*100))
else
    fprintf('.')
end

%% end with newline

if ind == total
    fprintf('\n')
end
