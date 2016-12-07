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





