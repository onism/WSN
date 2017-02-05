#	Multi-target Tracking by Continuous Energy Minimization

Early work mostly focused on recursive methods, where the current state depends only on the previous one: initially Kalman filter, and later particle filter, which represents the posterior by a set of samples rather than an analytic expression, and can thus better cope with ambiguous, multi-modal distributions.

The aim of our method is to find an optimal solution for multi-target tracking over an entire video sequence. In other words, each target needs to be assigned a unique trajectory for the duration of the video, which matches the target's motion as closely as possible. 



## Energy

There are many possibilities to define an energy(or equivalently, likelihood) function which rewards more lausible configurations and penalizes unreasonable ones.

The energy function is made up of five terms: an observation term based on image data; three physically motivated priors for object dynamics,   collision avoidance and object persistence and a regularizer which tries to keep the number of trajectories low:
$$
E(X) = E_{obs} + \alpha E_{dyn} + \beta E_{exc} + \gamma E_{per} + \delta E_{reg}
$$




​		
​	
​	
​		
​			
​				
​					


​			
​		
​	
