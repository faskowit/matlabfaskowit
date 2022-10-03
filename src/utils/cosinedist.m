function [ angdist, angsim ] = cosinedist(a,b)
% a,b: input vectors
% output: cosine distance
%
% note, same as: acos(dot(a,b)/norm(a)/norm(b)) but we use the matlab pdist
% function here because the pdist function has protection for weird number
% overflow possibilities
%
% https://en.wikipedia.org/wiki/Cosine_similarity#Angular_distance_and_similarity

if length(a) ~= length(b)
   error("input vectors need to be same length") 
end

angdist = acos(1-pdist([a(:)' ; b(:)'],'cosine'))./pi ;
angsim = 1 - angdist ; 