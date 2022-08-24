

% add some paths
p = strrep(pwd,'/startup','/') ;
addpath([ p '/external/'  ])
addpath([ p '/external/2019_03_03_BCT/'  ])
addpath([ p '/external/cmap/'  ])

addpath(genpath([ p '/src/' ]))

% % some inline functions 
% triunroll = @(x_) x_(logical(triu(ones(size(x_,1)),1))) ;