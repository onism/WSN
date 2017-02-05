# Information Consensus for Distributed Multi-Target Tracking

ref: Kamal A T, Farrell J A, Roy-Chowdhury A K. Information Consensus for Distributed Multi-target Tracking[C]// IEEE Conference on Computer Vision and Pattern Recognition. IEEE Computer Society, 2013:2403-2410.

被引用量：18

CVPR 计算机视觉和模式识别领域的顶级会议

The sensors that do not have information about a target are termed as naive with respect to that target. A distributed multi-target tracking problem can be divided into three sub-problems,namely, **distributed information fusion, data association and dynamic state estimation.**  

In a distributed multi-target tracking scheme, each node may need to maintain a state estimate of each target even though it is not directly observing the target, since the nodes will need to collaborate with each other. 

MHT usually achieves higher accuracy at the cost of high computational load. JPDAF achieves reasonable results at much lower compuation cost. 

## Multi-target data association

The JPDAF is a single sensor algorithm, thus the sensor index $i$ is unnecessary and will be dropped. At time $t$, the measurement innovation $z^{jn}$ and the innovation covatiance $S^J$ of measurement $z^n$ for target $T^j$ is computed as
$$
z^{jn} = z^n - H^j\hat{x}^{j-}\\
S^j = H^j P^{j-}H^{jT}+R^{j}
$$
The probability that $T^j$









# GENERAL SOLUTION AND APPROXIMATE IMPLEMENTATION OF THE MULTISENSOR MULTITARGET CPHD FILTER 

# On the divergence of information filter for multi sensors fusion

# Distributed (nonlinear) target tracking in clutter

# Integrated particle filter for target tracking in clutter

# Multisensor CPHD filter

# Multiple Maneuvering Target Tracking by Improved Particle Filter Based on Multiscan JPDA

In  the standard single scan JPDA framework, a track is updated with a weighted sum of the measurements which could have reasonably originted from the target in track. The only information the standard JPDA algorithm uses is the measurements on the present scan and the state vectors. If more scans of measurements are used, additional information is available resulting in better computed probabilities. 