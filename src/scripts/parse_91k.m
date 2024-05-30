% script to sort out the gifti data in interpretable way 

addpath('/Users/faskowitzji/joshstuff/git_pull/cifti-matlab')

%% read in 91k greyordinates 

greyOrd = ciftiopen('/Users/faskowitzji/joshstuff/git_pull/HCPpipelines/global/templates/91282_Greyordinates/91282_Greyordinates.dscalar.nii') ;

%% get metadata shaped up

parcInfo = greyOrd.diminfo{1}.models ; 

% and make this into a better map
greyOrdDict = dictionary() ; 

for idx = 1:length(parcInfo) 

    name = parcInfo{idx}.struct ; 
    srt =  parcInfo{idx}.start ; 
    sz =  parcInfo{idx}.count ; 
    inds = srt:(srt+(sz-1)) ; 

    greyOrdDict{string(name)} = inds ; 

end

%% now save the dict

save('~/joshstuff/data/greyordinate_matlab_dict.mat',"greyOrdDict")



