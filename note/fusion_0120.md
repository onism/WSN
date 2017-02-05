# Multi-source information fusion model in rule-based Gaussian-shaped fuzzy control inference system incorporating Gaussian density function

In this paper, a special information structure formalized in terms of three indices(the central presentation, population or scale, and density function) is proposed. Single and mixed Gaussian models are used for single souce information and their fusion results, and a parameter estimation method is also introduced. 

Information fusion is  the merging of information from disparate sources with differing conceptual, contextual, and typographical representations.  Fusion methods include product fusion(such as Bayes posterior probability model), linear fusion(SVM classifers), and non-linear fusion(super-kernel integration).

In this paper, we formalize multi-source information as a  multivariable group and describe each information structure as a special kind of triple $I = <P,d,\rho>$ , where $P$ denotes a typical point of positive examples relative to the information structure $I$. $d$ is a distance measurement that represents the population of information, and $\rho$ is a PDF.





# Multi-model Component-Based Tracking Using Robust Information Fusion

VBDF(Variable-Bandwidth Density-based Fusion) computes the location of the most significant mode of the displacements density function while taking into account their uncertainty. The choice of the VDBF estimator is motived by its good performance in the presence of outliers in the input data when compared to prevuously proposed methos such as CI or BLUE estimate assuming single source, statistically independent data.  **The VBDF** estimator is defined as the location of the most significant mode of the density function. The mode computation is based on the variable bandwidth mean shift technique in a multiscale optimization framework.

Let $x_i$ be the avilable d-dimensional estimates, each having an assoicated uncertainty given by the covariance matrix $C_i$. The most significant mode of the their density function is determined iteratively in a multiscal fashion. A bandwidth matrix $H_i = C_i + \alpha^2I$ is associated with each point $x_i$. The variable bandwidth mean shift vector at location $x$ is given by
$$
m(x) = H_h(x) \sum_{i=1}^n w_i H_i^{-1}x_i -x
$$
where $H_h$ represents the harmonic mean of the bandwidth matrices weighted by the data-dependent weights $w_i(x)$
$$
H_h(x) = (\sum w_i(x)H_i^{-1})^{-1}
$$
The data dependent weights computed at the current location $x$ have the expression 
$$
w_i(x) = \frac{\frac{1}{|H_i|^{\frac{1}{2}}} exp(-0.5D^2(x,x_i,H_i))}{\sum \frac{1}{|H_i|^{\frac{1}{2}}} exp(-0.5D^2(x,x_i,H_i))}
$$
It can be shown that the density corresponding to the pint $x+m(x)$ is always higher or equal to the one corresponding to $x$. The VBDF estimator finds the most important mode by iteratively appling the adaptive mean shift procedure at sevral scales.  The mode tracking accross scales results in 
$$
x_j = C(x_j) \sum_{i=1}^n w_i(x_j)C_{ij}^{-1}x_{ij}\\
C(x_j) = (\sum w_i(x_j)C_{ij}^{-1})^{-1}
$$

> Nonparametic Infomation Fusion for Motion Estimation

# Covariance Intersection in Nonlinear Estimation based on Pseudo Gaussian Densities

For nonlinear system dynamics and sensor models perturbed by arbitrary noise, it is not only a problem to characterize and parameterize dependencies between estimates, but also to find a proper notion of consistency. This paper address these issues by transforming the state estimates to a different state space, where the corresponding densities are Gaussian and only linear dependencies between estimates, correlations, can arise.

**CI has proven to be a poweful tool in decentralized fusion architectures provided that only linear system and sensor models are considered. Although EMDs provide promising results, it remains questionalbe whether EMDs can tackle the arbitrariness of possible dependencies.**

One way consists in decomposing the estimates into dependent and independent parts. Then CI only needs to be applied to the dpendent parts, which is called splict CI. Alternatively, symmetric or asymmetric bounds can be employed:

> A Tight Bound for the Joint Covariance of Two Random Vectors with Unknown but Constrained
> Cross–Correlation
>
> Robust, Low-Bandwidth, Multi-Vehicle Mapping

The general idea behind is to regard the true estimated density as a (pseudo) Gaussian density in a different stat space.  This concept is strongly related to Carleman bilinearinzarions.



If a nonlinear sensor model 
$$
z_k = h(x_k) + v_k
$$
can be rewritten as a linear update equation
$$
z_k^{*} = H^{*}x_k^{*} + v_k^{*}
$$
in the transformed state space $S^*$.







