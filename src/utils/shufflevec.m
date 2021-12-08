function [o] = shufflevec(vec)

o = vec(randperm(length(vec))) ;