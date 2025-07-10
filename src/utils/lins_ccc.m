function [ccc,cc] = lins_ccc(mat)
% my Lins CCC

sigma_dat = std(mat,[],'omitmissing') ; 
mean_dat = mean(mat,'omitmissing') ; 

sigma_mult = sigma_dat'*sigma_dat ; 

% lins caculation
top = sigma_mult*2 ;
bottom = (mean_dat'-mean_dat).^2 + ( (sigma_dat.^2)' +  (sigma_dat.^2) ) ; 

% corration multipied by bias factor
cc = corr(mat,'Rows','complete') ; 
ccc = cc .*(top./bottom) ; 

% check it
% ccc2 = zeros(size(mat,2)) ; 
% for idx = 1:size(mat,2) 
%     for jdx = 1:size(mat,2)
%         ccc2(idx,jdx) = IPN_ccc([ mat(:,idx) mat(:,jdx) ]) ; 
%     end
% end
% 