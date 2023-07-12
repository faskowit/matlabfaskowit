function [ surr_data , yrecon] = basis_signflip_surr(y,basisset,nperms,randwei,num2flip) 

dimtouse = size(basisset,2) ; 

if nargin < 4
    % weights when picking bases to flip
    randwei = 'uniform' ; 
end

if nargin < 5
    % how many bases to flip
    num2flip = floor(dimtouse/2) ;
end

if length(y) ~= size(basisset,1)
    error('dimensions of y and mm are off')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% fit the coefficients once
coefs = calc_eigendecomposition(y,basisset) ; 
yrecon = basisset*coefs ; 

switch randwei
    case 'uniform'
        weivec = ones(dimtouse,1) ; 
    case 'power'
        weivec = abs(coefs).^2 ./ sum(abs(coefs).^2) ; 
    otherwise
        error('rand_wei not implemented')
end

% preallocate
surr_data = nan(size(basisset,1),nperms) ; 

% loop
for idx = 1:nperms

    disp(idx)

    % signflip the
    flipvec = ones(dimtouse,1) ; 
    % flipvec(randi(dimtouse,floor(dimtouse/2),1)) = -1 ; 
  
    % pick inds without replacement
    inds_shuff = datasample(...
        1:dimtouse,num2flip,'Replace',false,'Weights',weivec) ;

    % flip some signs
    flipvec(inds_shuff) = -1 ; 

    % make the rand data
    surr_data(:,idx) = basisset*(coefs.*flipvec) ;

end

