function [outstr] = load_dir_contents(dirstring,viewit)

if nargin<2
   viewit = 0 ; 
end

% get the dir
dd = dir(dirstring) ;

outstr = struct();

for idx = 1:length(dd)
    outstr(idx).d = load([ dd(idx).folder '/' dd(idx).name]) ;
    outstr(idx).n = dd(idx).name ;
end

if viewit
    n = length(outstr) ;
    ii=1 ;
    while true
        imagesc(outstr(ii).d)
        title(outstr(ii).n) ; waitforbuttonpress ; ii = ii + 1 ;
        if ii>n ; ii=1 ; end
    end
end