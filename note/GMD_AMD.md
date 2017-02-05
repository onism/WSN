# Efficient Multi-Sensor Data Fusion for Space Surveillance

An extension to the CI algorithm for non-Gaussian distributions is given by the geometric mean density(GMD) fusion rule. 

fusion of the pdfs from nodes $i$ and $j$ is given by
$$
p(x|Z_i  \cup Z_j)  \approx p_i(x|Z_i)p_j(x|Z_j)
$$
This is only the case, however, if there is no common data shared,i.e. if $Z_i \cap Z_j = \emptyset$. Where there is common data shared between the two nodes, and provided that the common information $p(x|Z_i \cap Z_j)$ is known, it is possible to obtain an optimal Bayesian fusion as:
$$
p(x|Z_i  \cup Z_j)  \approx  \frac{p_i(x|Z_i)p_j(x|Z_j)}{p(x|Z_i \cap Z_j)}
$$
An alternative to the optimal Baysian fusion that automatically prevents the double counting of information and additionally does not require knowledge of the common information is the GMD, which for fusing two pdfs, is given as
$$
p(x|Z_i  \cup Z_j)  \approx  p^w_i(x|Z_i)p^{1-w}_j(x|Z_j)
$$

> On conservative fusion of information with unknown non-gaussian dependence

If the input pdfs do not overlap, the GMD fusion rule cannot be used. For the case where multiple distributions are to be fused instead of only two, the GMD becomes
$$
p(x|\cup Z_i) \approx \prod_{i=1}^m p_i^{w_i}(x|Z_i)
$$
In order to simplify the notation, the explicit dependence upon the data is omitted and the output of the GMD fusion is denoted by $\tilde{p}(x)$ such that
$$
\tilde{p}(x) = \frac{1}{\eta} \prod_{i=1}^m p_i^{w_i}(x)
$$
where $\eta$ is a normalization constant.

In order to determine the weighting parameters that are used in the GMD fusion rule, the optimization problem.  Two types of cost functions are considered: direct cost functions that seek to minimize some measure of the fused density, and indirect cost functions that seek to minimize the imbalance between the fused density and the input constituent densitites.

When using the determinant of the covariance matrix, the direct cost function is given by
$$
J = det(\tilde{p})
$$




Product of Gaussians for Speech Recognition

The product of two Gaussian likelihoods is itself Gaussian distributed when appropriately normalized. For the product of $S$ multivariate Gaussian distributions, this may be written as
$$
p(o|M) = \frac{1}{Z}\prod_{s=1}^S \mathcal{N}(o,\mu^s,\Sigma^s) = \mathcal{N}(o;\mu,\Sigma)
$$
where $Z$ is the normalisation term. The mean and the covriance matrix of the resulting distribution are
$$
\mu = \Sigma (\sum_{i=1}^s (\Sigma^s)^{-1}\mu^s)\\
\Sigma = (\sum_{i=1}^s \Sigma^s)^{-1}\\
Z = \frac{(2\pi)^{d/2}|\Sigma|^{0.5}}{\prod (2\pi)^{d/2}|\Sigma^s|^{0.5}}exp(0.5*(\mu^T\Sigma^{-1}\mu - \sum_{s=1}^S (\mu^{sT}\Sigma^{s-1}\mu^s)))
$$
Since the product of two or more Gaussian is itself Gaussian distributed, the product of mixture of Gaussian may be expressed as a mixture model in the product space.

 

# COLLABORATIVE MULTI-SENSOR TRACKING AND DATA FUSION

Demars K J, Mccabe J S, Darling J E. Collaborative Multi-Sensor Tracking and Data Fusion[C]// Spaceflight Mechanics Meeting. 2015.

One approach is to use an arithmetic mean density(AMD) of the form.
$$
p(x|Z_i \cup Z_j) = wp_i(x|Z-i) + (1-w)p_j(x|Z_j)
$$




# Multi-Sensor Data Fusion in Non-Gaussian Orbit Determination

Raising $p_1(x)$ to the power $w$, rasing $p_2(x)$  to the power $1-w$, and multiplying the reuslt together gives the fused pdf as 





On Conservative Fusion of Information with
Unknown Non-Gaussian Dependence



# Distributed estimation fusion with unavailable cross-correlation



# State fusion with unknown correlation: Ellipsoidal intersection

This article focuses on the problem of fusing two prior Gaussian estimates into a single estimate, when the correlation is unknown. 

The CI suffers a decay of the accuracy,i.e., in terms of comparing the covariance of the fused estimate to the  corresonding covariances of the prior estimates. To that extent, this article proposes a state fusion method, labeled as ellipsoidal intersection(EI).

## Problem formulation

Let us consider two random vectors $x_i,x_j$ ,representing the two prior estimates of a state vector. Both estimates are characterized by a Gaussian distribution. The goal is to merget the prior estimates into the single fused estimate $x_f$.

The issues of current fusion methods are a consequence of parameterzing $x_f$, before dealing with correlations.

**Corollary** Let $x_1$ and $x_2$ represent two unbiased estimates of $x$ that are independent, Then the Gaussian distributed random vector $x_3 = \Omega(x_1,x_2)$. with
$$
P_3 = (P_1^{-1} + P_2^{-1})^{-1}, \quad x_3 = P_3(P_1^{-1}x_1 + P_2^{-1}x_1)
$$
is the unbiased fused estimate with minimal tr$(P_3)$
By introducing $x_{ij},x_{ii},x_{jj}$  as Gaussian distributed random vectors
~~~
Ai = inv(CA);
Bi = inv(CB);

[TA,DA] = eig(CA);
BT = sqrt(DA)\inv(TA)*CB*TA/sqrt(DA);
[SBT,DBT] = eig(BT);
DBT = max(DBT,eye(length(CA)));
Gamma = TA*sqrt(DA)*(SBT*DBT/SBT)*sqrt(DA)/TA;

% New covariance
C = inv(Ai+Bi-inv(Gamma));
% New mean
R = eps*eye(length(C)); % regularization
gamma = inv(Ai+Bi-2*inv(Gamma)+2*R)*((Bi-inv(Gamma)+R)*xA + (Ai-inv(Gamma)+R)*xB);
c = C*(CA\xA+CB\xB-Gamma\gamma);
~~~
$$
x_f = \Phi(\Phi(x_{ij},x_{ii}),x_{jj})\\
P_f = (P_i^{-1}+P_j^{-1} - \Gamma^{-1})^{-1}\\
\hat{x}_f = P_f(P_i^{-1}\hat_{x}_i + P_j^{-1}\hat{x}_j - \Gamma^{-1}\gamma)
$$
The unknown variables $\Gamma,\gamma$ correspond to the unkown correlation.

