function surrogate = gen_phaserand_partial(data,n_shuff,rand_wei)
% data: time x channel
% n_shuff: # of frequences to apply randomization to
% rand_wei: weighting method to use when selecting frequencies

[nSamples, nVars] = size(data);
n_components = floor((nSamples-1)/2); % Number of components that *aren't* DC or Nyquist
    
if nargin < 2
    n_shuff = floor(nVars*.1) ;
end

if nargin < 3
    rand_wei = 'power' ;
end

if n_shuff > n_components
    error('asking for too many frequences to shuffle')
elseif n_shuff == n_components
    warning('going to shuffle all frequencies')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mean_term = mean(data);
std_term = std(data,1); % Use N-1 standard deviation to match original code

% get amplitude spectrum
amp_spec = fft(data, nSamples,1);      % no need to take abs as we can just add random phases

% Generate phase noise
% first element of spectrum is DC component, subsequent elements mirror
% each other about the Nyquist frequency, if present

rand_components = rand(n_components,1).* (2 * pi) ; % the noise to add to components
sel_rand = zeros(n_components,1) ;

% select freqs to add noise to
amp_pow = abs(amp_spec.^2)/nSamples ;
amp_pow = mean(amp_pow(1:n_components,:),2) ;

% switch on the order for picking the channels
switch rand_wei
    case 'power'
        amp_pow_trnsfrm = amp_pow ; 
    case 'invpower'
        amp_pow_trnsfrm = -log(normalize(amp_pow,'range',[1/n_components,1])) ;
        % amp_pow_trnsfrm(1) = eps ; 
    case 'uniform'
        amp_pow_trnsfrm = ones(n_components,1) .* 1/n_components ;
    otherwise
        error('rand_order not set correctly')
end

% % normalize values to 1, to convert to probabilities
% % pick which frequences to randomize
% (this previous way was with replacement)
% probedge = [ 0 ; cumsum(normalize(amp_pow_trnsfrm,'norm',1))] ; 
% probedge(end) = 1 ;
% inds_shuff = discretize(rand(1,n_shuff),probedge) ;

% pick inds without replacement
inds_shuff = datasample(...
    1:n_components,n_shuff,'Replace',false,'Weights',amp_pow_trnsfrm) ;
sel_rand(inds_shuff) = 1 ; 

% make the noise
addnoise = bsxfun(@times,ones(1,nVars),rand_components.*sel_rand); % Same phase shift for each channel

if rem(nSamples,2) % If odd number of samples, then Nyquist frequency is NOT present
    newPhase = [zeros(1,nVars); 1i .* addnoise; -1i .* flipud(addnoise)]; % second half uses conjugate phases, mirrored in order
else % Otherwise, include zero phase shift for the Nyquist frequency
    newPhase = [zeros(1,nVars); 1i .* addnoise; zeros(1,nVars); -1i .* flipud(addnoise)]; % second half uses conjugate phases, mirrored in order
end

% Make new phase scrabled spectrum
rand_spec = exp(newPhase).*amp_spec;

% Create new time_course
surrogate = ifft(rand_spec, nSamples);

% demean
surrogate = bsxfun(@minus, surrogate, mean(surrogate));

% Normalise time_series
surrogate = bsxfun(@times, surrogate, std_term./std(surrogate,1)); 

% Reset the mean
surrogate = bsxfun(@plus, surrogate, mean_term);

end %generate_phase_surrogates

