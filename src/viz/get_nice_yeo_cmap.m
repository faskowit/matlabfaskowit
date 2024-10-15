function cmap = get_nice_yeo_cmap(cmaptype) 
% assuming the alphabetical order for yeo17 networks

switch cmaptype

    case 'yeolab'
        neword = [ 12 13 11 16 17 15 5 6 10 9 7 8 3 4 14 1 2 ];
        cc = [ 
        
            0.4688    0.0703    0.5234
            0.9961         0         0
            0.2734    0.5078    0.7031
            0.1641    0.7969    0.6406
            0.2891    0.6055    0.2344
                 0    0.4609    0.0547
            0.7656    0.2266    0.9766
            0.9961    0.5938    0.8320
            0.8594    0.9688    0.6406
            0.4766    0.5273    0.1953
            0.4648    0.5469    0.6875
            0.8984    0.5781    0.1328
            0.5273    0.1953    0.2891
            0.0469    0.1875    0.9961
                 0         0    0.5078
            0.9961    0.9961         0
            0.8008    0.2422    0.3047
         ] ;  
        cmap = cc(neword,:) ; 
    case 'betzellab16'
        % betzel lab 16
        cmap = [ 224 228 89 ; % contA
            212 220 57 ; % contB
            186 197 59 ; % contC
            220 119 89 ; % dmnA 
            207 96 51 ; % B 
            175 80 48 ; % C
            157 205 70 ; % danA 
            114 199 108 ; % dan b
            191 205 188 ; % limbic
            103 184 175 ; % salvanA
            44 145 129 ; % B
            116 203 197 ; % SMNa 
            57 193 179 ; % b
            189 165 181 ; % tempPar
            90 127 172 ; % visC
            43 85 135 ; % visP
        ] ./ 255 ;  
    case 'betzellab17'
        % betzel lab 16
        cmap = [ 224 228 89 ; % contA
            212 220 57 ; % contB
            186 197 59 ; % contC
            220 119 89 ; % dmnA 
            207 96 51 ; % B 
            175 80 48 ; % C
            157 205 70 ; % danA 
            114 199 108 ; % dan b
            191 205 188 ; % limbic
            190 204 187 ; % limbic
            103 184 175 ; % salvanA
            44 145 129 ; % B
            116 203 197 ; % SMNa 
            57 193 179 ; % b
            189 165 181 ; % tempPar
            90 127 172 ; % visC
            43 85 135 ; % visP
        ] ./ 255 ; 
    case 'grad1'
        g1sort = [ 13 17 14 8 16 11 7 15  12 10  1 3 6 9 2  4 5 ] ; 

        cc = [255,114,29;
        255,141,22;
        255,167,15;
        255,193,7;
        255,219,0;
        233,221,17;
        209,222,34;
        186,223,52;
        163,224,69;
        122,223,109;
        82,223,149;
        41,222,189;
        0,221,230;
        0,208,236;
        0,194,243;
        0,181,249;
        0,168,255] ./ 255  ;
        cmap = cc(g1sort,:) ;
    otherwise
        error('not an option')
end

%% show some work

% grad_cifti = squeeze(niftiread('data/external/hpc_grad_sch200-yeo17.pscalar.nii')) ; 
% 
% % get mean values
% [~,g1sort] = sort(arrayfun(@(i_) mean(grad_cifti(1,parc.ca(1:200)==i_)), 1:17)) ; 
% 
% cc = turbo(23) ; 
% cc = cc(3:19,:)
% 
% cc = [255,114,29;
% 255,141,22;
% 255,167,15;
% 255,193,7;
% 255,219,0;
% 233,221,17;
% 209,222,34;
% 186,223,52;
% 163,224,69;
% 122,223,109;
% 82,223,149;
% 41,222,189;
% 0,221,230;
% 0,208,236;
% 0,194,243;
% 0,181,249;
% 0,168,255] ./ 255 ; 
% 
% pp =  parc_plot(surfss,annotm,'schaefer200-yeo17', parc.ca(1:200) ,...
%     'valRange',[1 17],...
%     'cmap',cc(g1sort,:), ...
%     'viewcMap',0,'newFig',1,'viewStr','all')