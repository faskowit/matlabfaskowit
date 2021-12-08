function triumas = make_triumask(num_nodes)

triumas = logical(triu(ones(num_nodes),1)) ;