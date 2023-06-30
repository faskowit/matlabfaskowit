function [winInds,winIndsWbad,winIndsWrefl] = make_slidewin_inds(ntp,slidesz,windowsz)

% calculate how many tvMats we will calculate
winInds = (0:slidesz:ntp-1)' + (1:windowsz) ;
% adjust to center the window, lazy way?
winInds = winInds - floor(windowsz/2) ; 

% save a version that has invalid inds, incase user want it
winIndsWbad = winInds .* 1 ; 

% calculate rows that exceed the ntp, or are less than 0
winInds(winInds>ntp) = 0 ;
winInds(winInds<1) = 0 ;

if nargout > 2

    % make a version which reflects the bad inds
    winIndsWrefl = winIndsWbad .* 1 ; 

    winIndsWrefl(winIndsWbad<1) = abs(winIndsWrefl(winIndsWbad<1)) + 2 ;  
    winIndsWrefl(winIndsWbad>ntp) = winIndsWrefl(winIndsWbad>ntp) - ...
        (winIndsWrefl(winIndsWbad>ntp) - ntp)*2 ;  

end