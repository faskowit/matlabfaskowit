function [ surr_dat ] = surr_logpolyfit(dat,resampmeth) 
% method copied from: 
% https://github.com/brain-modelling-group/geomsurr/blob/master/geomsurr.m

if nargin < 2
    resampmeth = 'shuff' ; 
end

L = length(dat) ; 

% log it
ldat = log(dat(:)') ; 

% fit 3rd order for mean
pfit1 = polyfit(1:L,ldat,3) ; 
pfit1_resid = ldat - polyval(pfit1,1:L,3) ; 

% fit 2nd order for var
pfit2 = polyfit(1:L,abs(pfit1_resid),2) ; 
pfit2_resid = pfit1_resid - polyval(pfit2,1:L,2) ; 

switch resampmeth
    case 'shuff'
        shufinds = randperm(length(pfit1_resid)) ;
    case 'linearwei'
        shufinds = datasample(1:L,L,'Replace',false,'Weights',fliplr(1:L)) ; 
    case 'log10wei'
        shufinds = datasample(1:L,L,'Replace',false,'Weights',logspace(log10(1/L),log10(1),L)) ; 
    otherwise
        % take care of block case here
        if regexp(resampmeth,'block')==1
            % get blocks
            bb = cellfun(@(x_) str2double(x_),regexp(resampmeth,'\d*','Match')) ;
            if isempty(bb)
                warning('setting blocks to 20')
                bb=20;
            end
            shufinds = blockrand(1:L,bb) ; 
        else
            error('shuff method not implemented')
        end
end

%shufinds = randsample(1:L,L,true,fliplr(1:L)) ; 
shufcoefs = pfit2_resid(shufinds) ; 

sur1 = shufcoefs.*polyval(pfit2,1:length(ldat),2) ; 
sur2 = sur1+polyval(pfit1,1:length(ldat),3) ; 

% un-log it
surr_dat = exp(rankreorder(ldat,sur2)) ; 

end

function out=rankreorder(x,scaffold)
% reorder vector x to have same rank order as vector scaffold
y(:,1)=scaffold;
y(:,2)=1:length(x);
y=sortrows(y,1);
y(:,1)=sort(x);
y=sortrows(y,2);
out=y(:,1);
end

function out=blockrand(x,bins)
if nargin<2
    bins=20;
end
rp = @(x_) x_(randperm(length(x_))) ; 
binvals = [ min(x) quantile(x,bins-1) max(x)+eps ] ;
bindat = discretize(x,binvals) ;  
out = cell2mat(...
    arrayfun(@(x_) rp(x(bindat==x_)), 1:bins, 'UniformOutput', false)...
    )  ;

end
