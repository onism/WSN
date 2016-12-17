# Sparse Kernel Density Estimates

ref: http://web.eecs.umich.edu/~cscott/past_courses/eecs545f07/projects/BellalaDevadasGopalakrishnanSricharan.pdf

https://arxiv.org/pdf/1503.00323v1.pdf

The standard Kernel Density Estimate(KDE) assigns equal weights for all the kernels. The number of kernels in the standard KDE is therefore equal to the size of the training data.

When the training data available is larget, the standard KDE becomes intractable for subsequent use. 

We seek to develop KDE's which are sparse in the weight coefficients. 

## Penalized Sparse KDE using ISE

The integrated Squared Error(ISE) between the true density and the estimated density is defined as
$$
\int (f(x) - \sum_{i=1}^n\alpha_i k_{\sigma}(x-x_i)^2)dx
$$
For gaussian kernels, the ISE reduces to 
$$
\alpha^TQ\alpha-c^T\alpha
$$
where $\alpha$ is the vector of weights, $Q_{ij} = k_{\sqrt{2\sigma}}(x_i,x_j)$,$c_i = (2/m)\sum_{j=1}^m(y_j,x_i)$, $x_i$'s are independent realization of $f$ used as training data and $y_i$'s are independent realizations of $f$ used as test data.

In order to increase the sparsity further, the authors impose additional penalties on the weight coefficients. The $l_1$ penalty is a popular choice for inducing sparsity. 

### Weighted $l_1$ penalty

The spa