function mat = niftisqueeze(inputPath)

if ~isfile(inputPath)
   error('input file is not file')  
end

mat = squeeze(niftiread(inputPath)) ;