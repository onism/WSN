%% Code Author: Ahmed Tashrif Kamal - tashrifahmed@gmail.com
% http://www.ee.ucr.edu/~akamal
% no permission necessary for non-commercial use
% Date: 4/27/2013

%%

Just run main.m

you can change the parameters in LoadParameters.m

in main.m, you can set
generateFreshData = true
if you want to generate new random data to run the algorithms

in main.m, you can set
generateFreshData = false
if you want to use the data that was used in the last run


References:


Information-Weighted Consensus Filter (ICF):
Information Weighted Consensus, A. T. Kamal, J. A. Farrell, A. K. Roy-Chowdhury, Controls and Decision Conference,2012.

GKCF:
A Generalized Kalman Consensus Filter for Wide Area Video Networks, A. T. Kamal, C. Ding, B. Song, J. A. Farrell, A. K. Roy-Chowdhury, Controls and Decision Conference, 2011.

KCF:
R. Olfati-Saber. Kalman-consensus ?lter: Optimality, stability, and performance. In IEEE Conf. on Decision and Control, 2009


%%% I use this matlab code, but I will add some other algorithm to compare

%% 2016/12/11 add the CI fusion with kalman filter, it perform well than the KCF but worse than weight kalman filter and GKCF
%% 2016/12/12 add the KLA and wKLA fusion with the kalman filter, kla perform well but the wkla perform worse, I will fixed it later