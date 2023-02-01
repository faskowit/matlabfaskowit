clc 
clearvars

%% load up the annots, from the parc plotter
% since this has 

aa = load('./data/fsaverage/mat/fsaverage_annots.mat') ;

ctkong = aa.allAnnots('kong_200') ;
ctschaef = aa.allAnnots('schaefer200-yeo17') ;

%% get the names

kong17 = unique(regexprep(regexprep(ctkong.combo_names,'17networks_.._',''),'_.*','')) ;
kong8 = unique(regexprep(kong17,'[ABC]$','')) ;


sch16 = unique(regexprep(regexprep(ctschaef.combo_names,'17Networks_.._',''),'_.*','')) ;
sch7 = cell(7,1) ;
tt = unique(regexprep(sch16,'[ABC]$','')) ;
% sch8 = unique(regexprep(regexprep(sch8,'Cent$',''),'Peri$','')) ; 
sch7(1:6) = tt(1:6) ;
sch7{7} = { 'VisCent' 'VisPeri' } ; 
sch7{2} = {sch7{2} 'TempPar'} ;

sch7simp = cell(sch7) ; 
sch7simp{2} = 'Default' ;
sch7simp{7} = 'Vis' ;

% make the schaefer 17 network
sch17 = regexprep(ctschaef.combo_names,'17Networks_.._','') ; 
sch17 = strrep(sch17,'Limbic_','Limbic') ;
sch17 = unique(regexprep(sch17,'_.*','')) ;
% put the underscore back in
sch17 = strrep(sch17,'Limbic','Limbic_') ;

%% testing

% ca_sch7 = nan(length(ctschaef.combo_names),1) ;
% for idx = 1:length(sch7)
%     ii = cellfun(@(x_) multistrmatch(x_,sch7{idx}),ctschaef.combo_names) ; 
%     ca_sch7(ii) = idx ; 
% end
% 
% ca_sch16 = nan(length(ctschaef.combo_names),1) ;
% for idx = 1:length(sch16)
%     ii = cellfun(@(x_) multistrmatch(x_,sch16{idx}),ctschaef.combo_names) ; 
%     ca_sch16(ii) = idx ; 
% end

%% run it!!  

levels = [ 100 200 300 400 500 600 800 1000 ] ;

sch_2_canon = containers.Map ;
kong_2_canon = containers.Map ;

for idx = 1:length(levels)
    ll = num2str(levels(idx)) ;

    disp(ll) ;  

    ctschaef = aa.allAnnots([ 'schaefer' ll '-yeo17']) ;
    ctkong = aa.allAnnots([ 'kong_' ll ] ) ;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    kk1 = [ 's' ll '_7net' ] ;
    kk2 = [ 'schaefer' ll '_7net' ] ;
    kk3 = [ 'sch' ll '_7net' ] ;

    ca = nan(length(ctschaef.combo_names),1) ;
    for jdx = 1:length(sch7)
        ii = cellfun(@(x_) multistrmatch(x_,sch7{jdx}),ctschaef.combo_names) ; 
        ca(ii) = jdx ;
    end

    sch_2_canon(kk1) = ca ;
    sch_2_canon(kk2) = ca ;
    sch_2_canon(kk3) = ca ;

    %%%%%% and 16 net %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    kk1 = [ 's' ll '_16net' ] ;
    kk2 = [ 'schaefer' ll '_16net' ] ;
    kk3 = [ 'sch' ll '_16net' ] ;

    ca = nan(length(ctschaef.combo_names),1) ;
    for jdx = 1:length(sch16)
        ii = cellfun(@(x_) multistrmatch(x_,sch16{jdx}),ctschaef.combo_names) ; 
        ca(ii) = jdx ;
    end

    sch_2_canon(kk1) = ca ;
    sch_2_canon(kk2) = ca ;
    sch_2_canon(kk3) = ca ;

    %%%%%% and 17 net %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    kk1 = [ 's' ll '_17net' ] ;
    kk2 = [ 'schaefer' ll '_17net' ] ;
    kk3 = [ 'sch' ll '_17net' ] ;

    ca = nan(length(ctschaef.combo_names),1) ;
    for jdx = 1:length(sch17)
        ii = cellfun(@(x_) multistrmatch(x_,sch17{jdx}),ctschaef.combo_names) ; 
        ca(ii) = jdx ;
    end

    sch_2_canon(kk1) = ca ;
    sch_2_canon(kk2) = ca ;
    sch_2_canon(kk3) = ca ;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % kong 8

    kk1 = [ 'k' ll '_8net' ] ;
    kk2 = [ 'kong' ll '_8net' ] ;

    ca = nan(length(ctkong.combo_names),1) ;
    for jdx = 1:length(kong8)
        ii = cellfun(@(x_) multistrmatch(x_,kong8{jdx}),ctkong.combo_names) ; 
        ca(ii) = jdx ;
    end

    kong_2_canon(kk1) = ca ;
    kong_2_canon(kk2) = ca ;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % kong 17

    kk1 = [ 'k' ll '_17net' ] ;
    kk2 = [ 'kong' ll '_17net' ] ;

    ca = nan(length(ctkong.combo_names),1) ;
    for jdx = 1:length(kong17)
        ii = cellfun(@(x_) multistrmatch(x_,kong17{jdx}),ctkong.combo_names) ; 
        ca(ii) = jdx ;
    end

    kong_2_canon(kk1) = ca ;
    kong_2_canon(kk2) = ca ;
end

%% add the label names

schaef_str = struct() ;
kong_str = struct() ;

schaef_str.map2ca = sch_2_canon ;
kong_str.map2ca = kong_2_canon ;

schaef_str.sch7 = sch7simp ;
schaef_str.sch16 = sch16 ;
schaef_str.sch17 = sch17 ;

kong_str.kong8 = kong8 ;
kong_str.kong17 = kong17 ;

%%

fname = '/Users/faskowitzji/joshstuff/matlabfaskowit/data/nodes_2_canon.mat'  ;
save(fname,'schaef_str','kong_str') ;


