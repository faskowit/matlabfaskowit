function [outstruct] = read_json(fname)

fid = fopen(fname); 
raw = fread(fid,inf); 
str = char(raw'); 
fclose(fid); 
outstruct = jsondecode(str);
