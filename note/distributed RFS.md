# Distirbuted RFS Filter

## distributed cphd using pairwise gossiping

 Each sensor runs a single-sensor CPHD filter to compute the PHD function and cardinality distribution using only its own measurements and the fuses the local  results by gossiping with neighboring sensors. **Existing schemes that fuse local results using KLA are adversely affected if some sensors do not detect a target.** 

> S.DattaGupta,S.Nannuru,M.Coates,andM.Rabbat,“A distributed general multi-sensor cardinalized probability hypoth-esis density (CPHD) filter for sensor networks,” in Proc. SPIESignal Process. Sensor/Inform. Fusion and Target RecognitionXXIII, 2015.
>
> G. Battistelli, L. Chisci, A. Farina, and B.-N. Vo, “AverageKullback-Leibler divergence for random finite sets,” in Int.Conf. Inf. Fusion, 2015.
>
> M. B. Guldogan, “Consensus Bernoulli filter for distributeddetection and tracking using multi-static Doppler shifts,” IEEESignal Process. Lett., vol. 21, no. 6, pp. 672–676, 2014.

After two neighboring nodes communicate, the consensus CPHD filter computes the weighted KLA of their PHD function, $D^a(x),D^b(x)$, which is given by the weighted geodetic mean:
$$
D^{a,b}(x)-\frac{[D^a(x)]^w[D^b(x)]^{1-w}}{\int [D^a(x)]^w[D^b(x)]^{1-w} dx}
$$
where $w \in [0,1]$ is a user-defined weight parameter. For pair-wise averaging between two sensors with the same probability of detection and clutter rate, one would take $w=0.5$.  If sensor a does not detect a target and sensor b does, then we have $D^a(x) \sim 0$ and $D^b(x) > 0$. After fusing the two PHD function, $D^{a,b}(x)\sim 0$ and then the target is lost event though the target was detected by at least one sensor.



Assume sensors $a$ and $b$ are gossiping with the sensors' PHD function being
$$
D^s(x) = \sum_{i=1}^{L_s}w_i^s\mathcal{N}(x;m_i^s,P_i^s),s\in \left\{a,b\right\}
$$
where $L_s$ is the number of mixture components in sensors PHD function. The weight $w_i^s$ are normalized so that $\sum_{i=1}^{L_s}w_i^s=1$.

When sensors $a$ and $b$ gossip, the two individual GMMs are first concatenated
$$
D^{a,b}(x)= \sum_{i=1}^{L_a}w_i^a\mathcal{N}(x;m_i^a,P_i^a)+ \sum_{i=1}^{L_b}w_i^b\mathcal{N}(x;m_i^b,P_i^b),
$$
Then apply a margin/pruning algorithm to the concatenated GMM.

## KLA

To combine limited information from individual nodes, a suitable information fusion procedure is required to reconstruct, from the information of the various local nodes.



Given PDFs $\left\{p^i(\cdot) \right\}$ and relative weights $w^{i}$, their weighted KLA $\bar{p}(\cdot)$ is defined as
$$
\bar{p}(\cdot) = arg \inf\limits_{p(\cdot)} \sum w^i D_{KL}(p||P^i)
$$
If all PDFs are Gaussian, $\bar{p}$ turns out to be Gaussian.$\bar{p}(\cdot)=\mathcal{N}(;\bar{m},\bar{P})$. In particular, define the information matrix
$$
\Omega=P^{-1}
$$
and information vector
$$
q=P^{-1}m
$$
associated to the Gaussian mean $m$ and covariance $P$, one has
$$
\bar{\Omega} = \sum w^i\Omega^i\\
\bar{q} = \sum w^iq^i
$$
which corresponds to the CI fusion rule.

## consensus algorithm

Let node $i$ be provided with an estimate $\hat{\theta}^i$ of given quantity of interest $\theta$. The objective is to develop an algorithm that computes in a distributed way, in each node, the average
$$
\bar{\theta}= \frac{1}{|N|}\sum \hat{\theta}^i
$$
Let $\hat{\theta}^i_0 = \hat{\theta}^i$ then a simple consensus algorithm takes the following iterative form
$$
\hat{\theta}^i_{l+1} = \sum w^{i,j}\hat{\theta}^j_l
$$
where the consensus weights must satisfy the conditions
$$
\sum w^{i,j} = 1\\
w^{i,j} >= 0
$$
Important covergency properties, depending on the consensus weights. A possible choice ensuring convergence to the collective average is given by the Metropolis weights
$$
w^{i,j} = \frac{1}{1 + max\left\{ |N^i|,|N^j|\right\}},i\in N,j\in N^i,i \neq j\\
w^{i,j} = 1 - \sum_{j \in N^i,i \neq j} w^{i,j}
$$

### consensus on posteriors(CP)

## Multi-object information fusion 

### Multi-object KLA

In Bayesian statistics, the KLD can be seen as the information gain  achieved when moving from a prior $g(x)$ to a posterior $f(x)$.  The average PDF is the one that minimizes the sum of the information gains form the initial multi-object densitites. 

**Multi-object KLA** the weighted KLA turns out to be given by
$$
f_{KLA}(X) = \frac{\prod\limits_{i \in N} [f^i(X)]^{w^i} }{\int \prod\limits_{i \in N} [f^i(X)]^{w^i} dX }
$$
The identity with $w^{i} = \frac{1}{N}$ can be rewritten as 
$$
f_{KLA}(x) = \bigoplus\limits_{i\in N}(\frac{1}{N} \odot f^{i}(X))
$$
Then the global KLA, which would require all the local multi-object densitites to be available, can be computed in a distributed and scalabale way by iterating regional averages through the consensus algorithm.
$$
f_{l+1}^i(x) = \bigoplus\limits_{i\in N}(\frac{1}{N} \odot f_l^{i}(X))
$$
As the number of consensus step increases, each local multi-object density "tends" to the global KLA.

### CPHD fusion

For the sake of simplicity, let us consider only two agents, $a$ and $b$, with GM location densities
$$
s^i(x)=\sum_{j=1}^{N_G^i}\alpha_j^i\mathcal{N}(x,x_j^i,P_j^i),i=a,b
$$
A first natural question is whether the fused location PDF
$$
\bar{s}(x) = \frac{[s^a(x)]^w[s^b(x)]^{1-w}}{\int [s^a(x)]^w [s^b(x)]^{1-w}dx}
$$
is also a GM.

1. The power of a Gaussian component is a Gaussian component, more precisely
   $$
   [\alpha\mathcal{N}(x,x,P)]^w=\alpha^w\beta(w,P)N(x,x,\frac{P}{w})
   $$
   ​

where
$$
\beta(w,P)=\frac{[det(2\pi Pw^{-1})]^{\frac{1}{2}}}{[det(2\pi P)]^{w/2}}
$$


The product of Gaussian components is a Gaussian component, more precisely
$$
\alpha_1\mathcal{N}(x,x_1,P_1)\alpha_2 \mathcal{N}(x,x_2,P_2) = \alpha_{12} \mathcal{N}(x,x_{12},P_{12})\\
P_{12}=(P_1^{-1}+P_2^{-1})^{-1}\\
x_{12}=P_{12}(P_1^{-1}x_1+P_2^{-1}x_2)\\
\alpha_{12}=\alpha_1 \alpha_2 \mathcal{N}(x_1-x_2,0,P_1+P_2)
$$
The fusion can be approximated as follows
$$
\bar{s}(x) = \frac{\sum_{i=1}^{N_G^a}\sum_{j=1}^{N_G^b}\alpha_{ij}^{ab}\mathcal{N}(x,x_{ij}^{ab},P_{ij}^{ab})}{\sum_{i=1}^{N_G^a}\sum_{j=1}^{N_G^b}\alpha_{ij}^{ab}}
$$
where
$$
P_{ij}^{ab} = [w(P_i^a)^{-1} + (1-w)(P_j^b)^{-1}]^{-1}\\
x_{ij}^{ab}=P_{ij}^{ab} [w(P_i^a)^{-1}x_i^a + (1-w)(P_j^b)^{-1}x_j^b]\\
\alpha_{ij}^{ab}= (\alpha_i^a)^w (\alpha_j^b)^{1-w} \beta(w,P_i^a) \beta(1-w,P_j^b)\mathcal{N}(x_i^a-x_j^b;0,\frac{P_i^a}{w}+\frac{P_j^b}{1-w})
$$






















