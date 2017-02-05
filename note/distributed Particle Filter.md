# Distributed Particle Filter

Depending on the type of information communicated between sensors in average consensus, a distributed particle filter algorithm can be categorized as **particle-based, likelihood-based, or posterior based**. **Particle-based** algorithms communicate the local likelihood or the local weight of each particle.  To gurantee an accurate Monto Carlo approximation, the number of particles needed in each local filter is usually quite large, which results in considerably high communication overhead.  Also in order to fuse particle information, each local filter must have an idential set of randomly-generated particles. 

**Likelihood-based algorithms**  communicate local likelihood functions parametrically approximated via factorization and linear regression. Since there is no universal approach to the desired factrization, the likelihood approximation approach does not generalize well beyond the expondential family. (I do not understand)

**Posterior-based algorithm** communicate local posteriors parametrically approximated in a compact form.

First,  unlike likelihood functions, posteriors are essentially density functions and thus easy to represent parametrically.  Such a compact parametric representation incurs significantly lower communication overhead than a nonparametric representation. Last but not least, posterior-based algorithms give each sensor privacy, since no sensor in the network needs to know how many other obtains its local posterior.

The challenge of posterior-based algorithms mainly lies in the fusion of parametrically represented local postriors. 

The global likelihood function $f(y|x)$ can be factorized into a product  of local likelihood functions
$$
f(y|x)=\prod_{k=1}^K f(y_k|x)
$$
As its logarithmic form
$$
log f(y|x) = \sum_{k=1}^K log f(y_k|x)
$$
Due to conditional independence, a likelihood function can be equivalently written as
$$
f(y_{n,k}|x_n)=f(y_{n,k}|x_n,y_{1:n-1})
$$
which according to Bayes' theorem, can be rewritten as
$$
f(y_{n,k}|x_n) = \frac{f(x_n|y_{n,k},y_{1:n-1})f(y_{n,k}|y_{1:n-1})}{f(x_n|y_{1:n-1})}
$$


 substitute into the log form, and then we get
$$
log \frac{f(x_n|y_{n},y_{1:n-1})f(y_{n}|y_{1:n-1})}{f(x_n|y_{1:n-1})}=\sum_{k=1}^K log \frac{f(x_n|y_{n,k},y_{1:n-1})f(y_{n,k}|y_{1:n-1})}{f(x_n|y_{1:n-1})}
$$
which simplifies to
$$
logf(x_n|y_{1:n}) + (K-1)log f(x_n|y_{1:n-1})=\sum_{k=1}^Klogf(x_n|y_{n,k},y_{1:n-1})+const
$$
The centralized fusion can be implemented in a distributed fashion through an average consensus algorithm. Denote $f(x_n|y_{n,k},y_{1:n-1})$ as $\eta_k^0(x_n)$, and the summation on the right-hand side of above can be computed iteratively based on a two-step distributed fusion rule:

step1: $log\eta_k^{i+1}(x_n) = \sum \varepsilon log \eta_j^i(x_n)$

step2: Normalizat $\eta_k^{i+1}$

 

A possible solution to communicate minimization is to compress the data to be transimitted.  A GMM is a convex combination of Gaussian components as follows:
$$
\eta_k^i(x_n)\sim \sum_{c=1}^C\alpha_c\mathcal{N}(x_n,\mu_c,\Sigma_c)
$$
A GMM model can be used to approximate an arbitray probability distribution, and is often learning via the EM algorithm. 

## Fusion of GM

