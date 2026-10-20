function [ictlens,lensVec,indsVec,lensInds] = get_contact_times(binseq)
% given binary sequence, get the length of the consecutive 1's sequences

if ~isvector(binseq)
    error('input needs to be vector')
end

if ~all(ismember(binseq,[0 1]))
    error('needs to be binary sequence')
end

if isrow(binseq)
    binseq = binseq(:) ; 
end

if isempty(binseq) || sum(binseq) == 0
    ictlens = nan ;
    lensVec = zeros(size(binseq)) ;
    indsVec = zeros(size(binseq)) ;
    lensInds = nan ;
    return
end

n = length(binseq) ;
f1 = find(diff(binseq)==1) ; % step "up"
f2 = find(diff(binseq)==-1) ; % step "down"

% find out what the sequnce begins as
if binseq(1) % if its already up
    % have to add a 0 for already up
    f1 = [ 0 ; f1 ] ;
end

% find the shorter one...
if binseq(end) % ended on up
    % pretend like there is a step down at the end
    f2 = [ f2 ; n ] ;
end

ictlens = f2 - f1 ; 
lensInds = [f1+1 f2] ; 

    lensVec = zeros(n,1) ; 
    for idx = 1:length(ictlens)
        lensVec((f1(idx)+1):f2(idx)) = ictlens(idx) ; 
    end

    indsVec = zeros(n,1) ; 
    for idx = 1:length(ictlens)
        indsVec((f1(idx)+1):f2(idx)) = idx ; 
    end
