function K = computeKgm(X,ker,gamma)
% Compute kernel gram matrix given X, kernel function and param. gamma
% Usage: K = computeKgm(X,ker,gamma)
% Parameters: X     - Input dataset.
%             ker   - Use 'rbf'
%             gamma - rbf kernel's param. gamma - 1/(2*sigma^2)
  if nargin < 1
      'Sorry to say'
  else
      switch lower(ker)
           case 'linear'
               K = zeros(size(X,1),size(X,1));
           case 'rbf'
%                 A = sum(X .* X, 2);
%                 B = -2 * (X * X');
%                 K = bsxfun(@plus, A, B);
%                 K = bsxfun(@plus, K, A');
%                 K = exp(-K*gamma);
                
                K = exp(-gamma*pdist2(X,X).^2);
              
          otherwise
               K = zeros(size(X,1),size(X,1));
      end
  end
end
      