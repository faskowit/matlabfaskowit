

% add some paths
p = strrep(pwd,'/startup','/') ;
addpath([ p '/'  ])

% some inline functions
triunroll = @(x_) x_(logical(triu(ones(size(x_,1))),1)) ;