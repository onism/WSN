# Sensor Data Information Using MI algorithm

Arithmetic Averaging(AA)

Weighted Arithmetic Averaging(WA)

Ordered Weighted Averaging(OWA)

Error-based Weighted Arithmetic Averaging(EWA)

# Analysis of Sum-Weight-like algorithms for averaging in Wireless Sensor Networks

Most paper consider single variable sensors and communications with feedback(e.g. peer-to-peer communications). However, in order to use efficiently the broadcast nature of the wireless channel, communications without feedback are advocated. To ensure the convergence in this feedback-free case, the recently-introduced Sum-Weight-like algorithms which rely on two variables at each sensor are a promising solution.

The goal of averaging algorithms is to make the vector of estimates $x(t)$ converge to $x_{ave}$. Two classes of algorithms exist:

(1). Random Gossip algorithms: In standard gossip algorithms, sensors update their estimate according to the equation $x(t+1)=x(t)^TK(t)$ where the $K(t)$ are doubly-stochastic matrices. These algorithms only rely on the exchanges of one variable per sensor, they will be called single-variate algorithms.

(2): Sum-Weight algorithms: A method is to use two variables: one representing the sum of the received values and another representing the relative weight of the sensor. For the sensor $i$ at time $t$ , they be respectively written $s_i(t)$ and $w_i(t)$. Wrting $s(t) = [s_1,…s_N(t)]^T$ and $w(t) = [w_1(t),…,w_N(t)]^T$, both variables will be modified by the same update matrix. Finally , the estimate of sensor $i$ at time $t$ will be the quotient of the two variables, $x_i(t) = s_i(t)/w_i(t)$.  