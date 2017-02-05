function [svi, alpha,c] = svdd_train(X,K,ker,C,gamma)
%SVDD Support Vector Data Description
%
%  Usage: [svi, alpha,c] = svdd_train(X,K,ker,C,gamma)
%
%  Note: Targets not required for training purposes.
%  Parameters: X      - Training inputs
%              ker    - kernel function - use 'rbf'
%              K      - Precomputed kernel gram matrix
%              gamma  - rbf kernel's param. gamma - 1/(2*sigma^2)
%              C      - upper bound - cost parameter
%              svi    - indices of support vectors
%              alpha  - set of all Lagrange Multipliers
%              c      - constant which is a part of the disc. function -
%              check formulation.
%
%  Author: Aravind Sankar (!)


  if (nargin <2 || nargin>5) % check correct number of arguments
    help svdd_train
  else

    fprintf('Support Vector Data Desctiption\n')
    fprintf('_____________________________\n')
    n = size(X,1);
    if (nargin<3) C=Inf; end
    if (nargin<2) ker='linear'; end
    
    % tolerance for Support Vector Detection
    
    
    % Construct the Kernel matrix for gaussian kernel now
       
    H = K;
    

    % Add small amount of zero order regularisation to 
    % avoid problems when Hessian is badly conditioned. 
    
    H = H+1e-10*eye(size(H));
    
    % Set up the parameters for the Optimisation problem

    vlb = zeros(n,1);      % Set the bounds: alphas >= 0
    vub = C*ones(n,1);     %                 alphas <= C
    
    x0 = zeros(n,1);
    
    
    A = ones(n,1)';      % Set the constraint Ax = b
    b = 1;
    
    % Solve the Optimisation Problem
    
    fprintf('Optimising ...\n');
    st = cputime;
    
    
   
    
    [alpha, fval, exitflag, output] = quadprog(H,[],[],[],A,b,vlb,vub,x0,'Display','none','TolX',1e-14,'TolFun',1e-14,'TolCon',1e-14);
    
    
    %output
    fprintf('Execution time: %4.1f seconds\n',cputime - st);

    % Compute the number of Support Vectors
    %epsilon = svtol(C);
    epsilon = 0.01*C;
    
    svi = find( alpha > epsilon);
    nsv = length(svi);
    fprintf('Support Vectors : %d (%3.1f%%)\n',nsv,100*nsv/n);

    svii = find( alpha > epsilon & alpha < (C - epsilon));
    
    % Compute radius R and c for use later in prediction.
    
   
     
    
    
    %c =0;
    R2 =1 + alpha'*K*alpha;

    avg_val = 0;
    
    for k = 1:length(svii)
        val = 0.0;
        for i = 1:length(svi)
            index = svi(i);
            val = val+ 2*alpha(index)* K(index,svii(k));
        end
        avg_val = avg_val +val;
    end
    avg_val = avg_val/length(svii);
    
    
    R2 = R2 - avg_val;
    
    c = 1-R2 + alpha'*K*alpha;
    R2
  end
 
    
