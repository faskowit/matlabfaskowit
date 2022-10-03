

% add some paths
mydir = '~/joshstuff/matlabfaskowit' ;
addpath([ mydir '/external/'  ])
addpath([ mydir '/external/2019_03_03_BCT/'  ])
addpath([ mydir '/external/cmap/'  ])

addpath(genpath([ mydir '/src/' ]))

% % some inline functions 
% triunroll = @(x_) x_(logical(triu(ones(size(x_,1)),1))) ;

