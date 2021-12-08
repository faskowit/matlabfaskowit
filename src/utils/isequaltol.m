function [b] = isequaltol(x1,x2,tol)

if nargin < 3
    tol = 1e-8
    warning(['setting tol to :' num2str(tol) ])
end

% https://www.mathworks.com/matlabcentral/answers/722783-how-to-add-tolerance-for-isequal
b = all(abs(real(x1(:)-x2(:)))<tol) & all(abs(imag(x1(:)-x2(:)))<tol);