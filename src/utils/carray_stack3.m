function out = carray_stack3(inCellArray)
% outputs NxNx3rdDim matrix

out = cell2mat(permute(inCellArray,[1,3,2])) ; 