# Covariance Intersection(CI)

CI is an algorithm for combine two or more estimates of state variables in a Kalman filter when the correlation between them is unknown. (https://en.wikipedia.org/wiki/Covariance_intersection)

Items of information a and b are known and are to be fused into information item c, We known a and b have mean/covariance, but the correlation is not known. The CI update gives mean and covariance as follows:

$P^{-1} = w P_1^{-1} + (1 - w)P^{-1}_{2}$

$M = P * (w P^{-1}_1M_1 + (1-w)P^{-1}_2M_2)$

where $w$  is computed to minimize a selected norm, e.g.., logdet or trace. 



Consider here the fusion of two estimates using either the Kalman filter or the data fusion technique known as Covariance Intersection (CI), under the following circumstances

1. The two estimates are independent In this case the Kalman filter produces an optimal fused estimate while CI produces a consistent, though suboptimal, estimate
2. The two estimates are completely correlated In this case CI produces an optimal fused estimate while Kalman produces an inconsistent estimate.
3. The two estimates are partially correlated In this case CI produces a consistent, though suboptimal,estimate while the Kalman filter produces an inconsistent estimate



# Batch Covariance Intersection(BCI)



# Covariance Union(CU)

ref: Generalized Information Representation and Compression Using Covariance Union

Bochardt O, Calhoun R, Uhlmann J K, et al. Generalized information representation and compression using covariance union[C]//2006 9th International Conference on Information Fusion. IEEE, 2006: 1-7.

Reece S, Roberts S. Generalised covariance union: A unified approach to hypothesis merging in tracking[J]. IEEE Transactions on Aerospace and Electronic Systems, 2010, 46(1): 207-221.



Conservative merging of hypotheses given by probability densities

On Mixture Reduction for Multiple Target Tracking

# GCI

ref: Generalized Covariance Intersection based on Noise Decomposition

Although CI provides the smallest bound in a large class of algorithms, it is often considered as too conservative. Split CI has been proposed to shrink the bound when independent infornation is included in the fusion process. For all of theses generalizations, cross-covariances must be assumed unknown after the fusion of estimates on order to guarantee consistent results.

let $x_s$ denote a sensor estimate with true covariance $P$.  Due to common prior information and common process noise, correlations emerge that cannot be calculated without sensor models. It has been shown that consistent estimation can still be realized when covariance bounds with $\bar{P} > P$ are processed for all estimates. Therefore, two challenges:

1. covariance bounds must be obtained at the sensors without knowledge about the modes and processing at remote nodes.
2. the filter and fusion processing is to be optimized so that the covariance bounds are minimized

## Consistent bounds for linear estimators

**Lemma 1**  For the considered system with  measurement models, the error of a linear estimator $e^s = x^s - x$  is given as a linear combination of independent noise terms $e^s = \sum B_in_i$, where $B^s$ denote sensor-specific transformation matrices.





# Gaussian Mixture Reduction Using Reverse Kullback-Leibler Divergence

# BAYESIAN ESTIMATION OF UNKNOWN PARAMETERS OVER NETWORKS

