# Sensor Selection based on the Fisher Information of the Kalman Filter for Target Tracking in WSNs

Since measurements from sensors are usually incomplete or inaccurate, target tracking in wireless sensor networks requires collaboration among multiple sensors to achieve the required collaboration among multiple sensors to achieve the required tracking performance. 

1. selects sensors to further track the target based on the minimization of the expected filterred mean squared position error. 
2. The most informative sensor is selected as the new leader by the previous one to track the target (entropy, Mahalanobis distance,expected posterior distribution)
3. Based on the Fisher information matrix

## Problem Formulation

We assume that there are $N_k$ sensors that have been selected to detect at time $t_k$, Let $Z_k=\left\{z_k^1,…,z_k^{N_k} \right\}$  denote the measurements. The problem is that the leader estimates the target state $x_k$ and selects the most informative sensor cluster for the next time.



## CRLB for the estimated target position from the kalman filter

Under the Gaussian noise assumption, the estimated error covariance $P_{k|k}$ of the kalman filter $x_{k|k}$ can achieve the posterior CRLB, and $P_{k|k}$ can be rewritten in the inverse form of the Fisher Information Matrix(FIM) as following
$$
J_{f,k} = J_{p,k} + J_{z,k}
$$
where $J_{f,k} = P_{k|k}^{-1},J_{p,k} = P_{k|k-1}^{-1}, J_{z,k} = C^TR_{k}^{-1}C$ represent the posterior, prior and measurement Fisher information matrices, respectively.

An information measure based on the Fisher information matrix $J_{f,k+1}$ is given as follows:
$$
C_{k+1}(\bar{J}_{k+1}) = \frac{trace(\bar{J}_{f,k+1})}{det(\bar{J}_{k+1})}
$$
