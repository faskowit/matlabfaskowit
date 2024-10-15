function sgc = my_sg_cent(W)
%inputs
%           W      weighted connection matrix
%
%outputs
%           co      subgraph centrality
%=================================================

B = sum(W,2);
ii = B~=0 ; 
C = diag(B(ii));
D = C^(-(1/2));
E = D * W(ii,ii) * D;
F = expm(E);
sgc = nan(size(W,1),1) ; 
sgc(ii) = diag(F) ;

end