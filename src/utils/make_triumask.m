function triumas = make_triumask(num_nodes,dval)

if nargin < 2
    dval = 1 ; 
end

triumas = logical(triu(ones(num_nodes),dval)) ;