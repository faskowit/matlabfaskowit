function [outstr] = load_dir_contents(dirstring,viewit,logdat)

if nargin<2
    viewit = 0 ; 
end

if nargin<3 
    logdat = 0 ;
end

% get the dir
dd = dir(dirstring) ;

outstr = struct();

for idx = 1:length(dd)
    outstr(idx).d = load([ dd(idx).folder '/' dd(idx).name]) ;
    outstr(idx).n = dd(idx).name ;
end

try
    if viewit
        n = length(outstr) ;
        ii=1 ;
        while true
            if logdat
                imagesc(log(outstr(ii).d))
            else
                imagesc(outstr(ii).d)
            end
            title(outstr(ii).n,'Interpreter','none') ; waitforbuttonpress ; ii = ii + 1 ;
            if ii>n ; ii=1 ; end
        end
    end
catch
    disp('image closed')
end
