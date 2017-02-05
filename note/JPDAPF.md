JPDA and maximum a posteriori penalty function (MAP-PF). Both of these algorithms decouple the joint multi-target tracking problem into separate single-target tracking problems, but deal with generation of measurements and association of measurements to targets in different ways.

In MAP-PF, the measurement generation and information update steps are coupled by a quadratic penalty function and the data association step of JPDA is eliminated.  The penalty function $\phi(\theta,h(x),\Sigma)$ is a non-positive function that is equal to zeros when $\theta = h(x)$ and becomes smaller as the distance between $\theta$ and $h(x)$ and increase. For example, a quadratic penalty functions is
$$
\phi(\theta,h(x),\Sigma) = -\frac{1}{2}(\theta - h(x))^T \Sigma^{-1}(\theta - h(x)) 
$$

# Joint Integrated Probabilistic Data Association - JIPDA

T 表示