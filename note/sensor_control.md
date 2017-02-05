# Multi-Bernoulli Sensor Control for Multi-Target Tracking

The most commonly chosen criterion, utilised in the sensor control literature, to judege the quality of the updated distribution, is the divergence of the updated multi-object density from the predict one.

## Sensor Control

This paper focuses  on solving the sensor control problem in the context of choosing the best control command among a finite number of admissible commands. **The quality of a sensor control command is evaluated in terms of reward function or a cost function**.  POMDP(partially observable Markov decision process) is a restricted  form of Markov decision process(MDP) in which there is no direct access to the states and information about the states are only received from observation.  The POMDP model used in this paper to formulate sensor control solution, comparises the following elements at any time k:

1. a finite set $S_k$ of single-object states
2. a finite set of  sensor control commands (actions)
3. a stochastic model for single-target transimition
4. a finite set of observations $Z$
5. a stochastic measurement model $g_k(z|x)$
6. a function $\mathcal{V}(S_{k-1},u,S_k)$ that returns a reward or cost for transition from the multi-object state $S_{k-1}$ to $S_k$ via applying an action command $u$.

The goal of sensro control is to find the control command $u$ which minimises or maxmises the statistical expection of the cost or reward function

### Multi-Bernoulli Sensor Control

Assume that at time $k-1$ , the multi-object distribution is approximated by a multi-Bernoulli RFS with parameters $\left\{r_{k-1}^i,p_{k-1}^i \right\}$. This distribution is predicted then update(using sensory measurements) to a new multi-Bernoulli RFS denoted by $\left\{r_k^i, p_k^i \right\}$. 

For every possible sensor control command, a range of sensor measurements would be likely, with their distribution being a function of the control command. We consider the variance of the cardinality estimate as a meaningful measure of the uncertainty embedded in the estimated posterior. The average of the varance is the cost that needs to be minimised to gain the most suitable control command. 



# A simple sensor management criterion for radar beam control based on the CB-MeMBer filter

The main criteria that have been proposed up to now for performing resource management in the RFS context have been implemented. The first scheme selects the sensing action that maximizes the  expected number of targets(PENT: posterior expected number of targets). The second scheme is an extension of the first one such that the tactical importance of each target is taken into account and it is called posterior expected number of targets of interest(PENTI).

> A. K. Gostar, R. Hoseinnezhad, and A. Bab-Hadiashar, “Multi-Bernoulli
> sensor control for multi-target tracking,” in Intelligent Sensors, Sensor
> Networks and Information Processing, 2013 IEEE Eighth International
> Conference on, April 2013, pp. 312–317.
>  A. K. Gostar, R. Hoseinnezhad, A. Bab-Hadiashar, and B.-T. Vo,
> “Control of sensor with unknown clutter and detection profile using
> Multi-Bernoulli filter,” in Information Fusion (FUSION), 2013 16th
> International Conference on, July 2013, pp. 1021–1028.
> A. K. Gostar, R. Hoseinnezhad, and A. Bab-Hadiashar, “Robust MultiBernoulli
> sensor selection for multi-target tracking in sensor networks,”
> Signal Processing Letters, IEEE, vol. 20, no. 12, pp. 1167–1170, Dec
> 2013.
>  ——, “Sensor control for multi-object tracking using labeled MultiBernoulli
> filter,” in Information Fusion (FUSION), 2014 17th International
> Conference on, July 2014, pp. 1–8.
> H. G. Hoang, “Control of a mobile sensor for multi-target tracking
> using multi-target/object Multi-Bernoulli filter,” in Control, Automation
> and Information Sciences (ICCAIS), 2012 International Conference on,
> Nov 2012, pp. 7–12.
>  H. G. Hoang and B.-T. Vo, “Sensor management for multi-target
> tracking via Multi-Bernoulli filtering,” Automatica, vol. 50 (4), pp.
> 1135–1142, 2014

Both these criterion select sensing actions based only on the uncertainty in the cardinality of the estimated pdf but ignore the uncertainty in the kinmatic states(e.g.: position/velocity).

We explore two new rule-based schemes that have even lower computational complexity than PENT and two cardinality-variance based criteria. 

## Information-driven sensor management

## PENT-based sensor management

PENT selects the sensing action that maximizes the number of objects to be seen by the sensor. This scheme was also extended such that it can take into account the tactial significance of a target, resulting in the PENTI scheme.

It is assumed that an ideal set of measurements can be collected, no measurement noise and no false alarms but the probability of detection can be less than one.

When a CB-MeMber filter is used, the radar-beam direction based on PENT, is given by
$$
\mu_k = arg \max\limits_{u}\left[\int(\sum_{i=1}^{N(k)} r_{k|k}^i(Z)) g(Z|X_k,\mu) \delta Z \right]
$$
$r_{k|k}^i(Z)$ is the updated probability of existence of component using the measurement $Z$.

## Cardinality-variance-based sensor management

$$
\mu_k = arg \max\limits_{u}\left[\int(\sum_{i=1}^{N(k)} r_{k|k}^i(Z) (1- r_{k|k}^i(Z)) ) g(Z|X_k,\mu) \delta Z \right]
$$

## Simple rule-based sensor mamagement schemes

By observing the sensor selections of the aforementioned schemes, the authors have noticed that the entropy scheme observes frequently the track with the highest probability of existence. On the other hand, PENT and the scheme that minimizes the expected cardinality variance observe frequently the track with the lowest probability of existence. 

# OSPA-Based Sensor Control

There are two approaches is defineing what the best measurement is. In information-driven methods, the information content of predicted and/or updated distributions is utilized to build the criterion for goodness. In second approach, called task-driven, sensor control methods are designed whit a direct focus on the expected performance of the multi-object filter as measure of goodness. Example of such cost function include estimated target cardinality variance and posterior expected error of cardinality and states(PEECS).

> H. G. Hoang and B. T. Vo, “Sensor management for
> multi-target tracking via multi-bernoulli filtering,” Automatica,
> vol. 50, no. 4, pp. 1135–1142, 2014.
>  A. Gostar, R. Hoseinnezhad, and A. Bab-Hadiashar, “Multibernoulli
> sensor control for multi-target tracking,” in Intelligent
> Sensors, Sensor Networks and Information Processing, 2013
> IEEE Eighth International Conference on, 2013, pp. 312–317.
> ——, “Robust multi-bernoulli sensor selection for multi-target
> tracking in sensor networks,” Signal Processing Letters, IEEE,
> vol. 20, no. 12, pp. 1167–1170, 2013.
> ——, “Multi-bernoulli sensor-control via minimization of expected
> estimation errors,” IEEE Transactions on Aerospace &
> Electronic Systems, vol. To Be Published, 2015.

Devising a proper cost function is at the core of formulating task-driven sensor control trchniques in POMDP framework. 

PEECS(posterior expected error of cardinality and states)-minimization can lead to a high-quality updated density even with limited observability. The proposed cost function is intended to account for both localization and cardinality errors.



A linear combination of the normalized errors of the number of targets and their estimated states is considered as a measure of uncertainty associated with estimate of the multi target state and as the cost function
$$
\mathcal{V}(\mu,X_k) = \eta \varepsilon^2_{|x|}(u) + (1 - \eta)\varepsilon^2_{x}(u)
$$
where $\varepsilon^2_{|x|}(u)$ denotes the normalized error of estimated cardinality of the multi target state and $\varepsilon^2_{x}(u)$ denotes the normalized error of the multitarget state estimate.

# Sensor Control for Multi-target Tracking using Cauchy-Schwarz Divergence

An alternative information divergence measure is the Cauchy-Schwarz(CS) divergence.  The key innovation of this paper is an analytic expression for the CS divergence between GLMB densitites.

# Sensor management with regional statistics for the PHD filter

This paper inverstigates a sensor management scheme that aims at minimising the regional variance in the number of objects present in regions of interest whilst performing multi-target filtering.

> A. O. Hero III, “Sensor Management: Past, Present, and Future,” IEEE
> Sensor Journals, vol. 11, no. 12, pp. 3064–3075, Dec. 2011.

The regional statistics provide first and second order information on the target activity in any region of the surveillance space,i.e., the expected  number of targets lying within the said region and associated uncertainty. 

# Dynamic Sensor Management for Multisensor Multitarget Tracking

We study the problem of sensor scheduling for multi sensor multi target tracking — to determine which sensor to activate over time to trader off tracking error with sensor usage costs.  Our method combines sequential multisensor JPDA and particle filter for belief-state estimation, and uses simulation based Q-value approximation method for "lookahead". 

ref: Li Y, Krakow L W, Chong E K P, et al. Dynamic sensor management for multisensor multitarget tracking[C]//2006 40th Annual Conference on Information Sciences and Systems. IEEE, 2006: 1397-1402.

The problem of sensor scheduling is to select the number and combination of sensors to activate over time to trade off tracking performance and sensor usage.

The Q-value approximation method calculates, at the current belief state, the Q-value of each candidate action, to choose the action with the minimum Q-value. 

The Q-value of action $u$ at belief state $b^k$ as
$$
Q_{H-k}(b^k,u) = g(b^k,u) + E(J_{H-k-1}^{*}|b^k,u)
$$
where $J_{H-k-1}^{*}$ is the optimal value over $H-k-1$ time steps starting at the next belief state $b^{k+1}$. 

The basic idea of rollout is to replace $J_{H-1}^{*}$  by  $J_{H-1}^{\pi_b}(b^{'})$ , the objective function value corresponding to a base policy $\pi_b$. 





# Multisensor Multitarget Tracking Based on a Matrix Reformulation of the GM-PHD Filter 

# A PHD-Filter-Based Multitarget Tracking Algorithm for Sensor Networks

# A New Heuristic for Multisensor PHD Filter 

# A distributed general multi-sensor cardinalized probability hypothesis density (CPHD) filter for sensor networks