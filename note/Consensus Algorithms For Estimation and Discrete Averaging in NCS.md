# Consensus Algorithms For Estimation and Discrete Averaging in Networked Control Systems

## State of the art

**Definition: Consensus Problem**

Consider a multi-agent system defined by the network topology $G=(V,E)$ and the agents' dynamics $x_i$. A consensus problem consists in the design of a local interaction protocol such that
$$
\lim\limits_{t\rightarrow \infty}||x_i-x_j||=0
$$


### Consensus in discrete-time

Linear interaction protocol
$$
\mu_i(t)=\varepsilon\sum_{j\in N_i}(x_j(t) - x_i(t))
$$
Each agent dynamics thus become
$$
x_i(t+1) = x_i(t) + \varepsilon\sum_{j\in N_i}(x_j(t) - x_i(t))
$$

### Consensus based on Gossip

Let $G=(V,E)$ be an undirected graph. Let $e(t):\mathbb{R} \rightarrow(i,j) \in E$ be a time varing edge selection process, at given time instants, an edge is selected $e(t)=(i,j)$. Let $S_i(t)$ represent the state of the generic node $i$ at time t. Let $\mathcal{R}$ be a set of pairwise local interaction rules such that
$$
S_i(t_{k+1}) = \mathcal{R}(S_i(t_k),S_j(t_k)),\\
S_j(t_{k+1}) = \mathcal{R}(S_i(t_k),S_j(t_k)),
$$
An algorithm based on gossip, is a set of rules $\mathcal{R}$ to update state of the nodes of the network that are applied following the edge selection process $e(t)$.

At any given instant of time, following a random edge selection process $e(t)$, nodes $i$ and $j$ interact and update their state with their average. 
$$
x_i(t_{k+1})=\frac{x_i(t_k) + x_j(t_k)}{2}\\
x_j(t_{k+1})=\frac{x_i(t_k) + x_j(t_k)}{2}
$$

###	Quantized Consensus

The consensus algorithm extended to the case in which the network is quantized.

## Discrete consensus on heterogeneous networks

​	

​		
​	



​			
​		
​	
