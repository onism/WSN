The MTT problem has two major sub-problems which must be solved simultaneously. The first sub-problem is to determine which measurement was caused by each of the targets(data association). The second sub-problem is to estimate the state of the target using the set of associated measurements.

## Data Association

Data association is the process by which an algorithm assigns measurements to targets. 

1. Hard assignment
2. Soft assignment

Data Association can be applied as a single-target or multi-target approach. In single-target data association, it is assumed that the assignment of measurements is independent for different tracks. In contrast, multi-target data association algorithms jointly assign measurements to multiple tracks simultaneously.

### Nearest Neighbour

The NN algorithm is the simplest single-target hard assignment data assoication algorithm. 

### PDA Filter

The PDA Filter is a popular association algorithm due to its simplicity and speed.  PDA assumes that the target state density can be approximated by its first two moments, and produces an updated Gaussian pdf approximation.  The PDA has been extended to JPDA. To reduce the computational complexity there is nearest neighbor JPDA(NN-JPDA), also known as "cheap JPDA".

### PMHT

The PMHT is a method that performs soft assignment and is a multi-target assocaition technique.  The major advantage of using PMHT is that the computational complexiy is linear in the number of targets, measurements and time steps. 

### PMHT For MTT

The PMHT algorithm is a method for finding the best estimate of the target states, $X$, when the measurement source $K$ is unknown.

The PMHT is an iterative algorithm, which asymptotically approaches a local maximum of the EM auxiliary function by refining estmates for the states $X$ and parameters $\prod$ .  The iterations are repeated until the auxiliary function converges the algorithm's output is the final state estimate.  The auxiliary function $Q(\cdot)$ can be maximised using any appropriate estimator. It can be shown that the auxiliary function is equivalent to the log-likelihood of a known assignment problem with synthetic measurements determined by the expection step.

# PMHT Approach for Underwater Bearing-Only Multisensor–Multitarget Tracking in Clutter

The most common data  association approaches used for MTT are:

1. NN GNN
2. MHTs
3. JPDA
4. PMHT
5. PHD
6. MLPA

The PMHT approach has shown promise outperforming in dealing with nonlinear models. Unlike JPDA, whose computational cost grows exponentially with the number of targets, The PMHT's computational cost grows linearly with the number of targets detected. 

Data association and target estimation is the key for multi target tracking problem. For PMHT the former is solved with EM algorithm, while the latter relies on the Kalman filter. The PMHT allows multiple measurements to be assigned to the same target, where the measurement-to-target assignments are modeled by a discrete but unknown random varable $K(t)$, with an associatd probability mass function. The EM algorithm is used to handle a set of measurement-to-target associations without estimating the assignments $k(t)$.  These soft measurement-to-target assignments are used to create a "synthetic" measurement for each target. 

