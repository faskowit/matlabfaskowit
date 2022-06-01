function bool = isordered(vec)

if ~isvector(vec)
    error('only vector input')
end

bool = all(diff(vec)>=0) ;