% I was ref the code from Overview of Bayesian sequential Monte Carlo methods for group and
% extended object tracking
%

%%%%% generate the simulation
%%% FIXED:ME As I focus on the filter, so I will use the mat file and not to create the environment, but I will do it later.
clear all
close all
load meas_mobile

N = 500; % particles number
N_thresh = N/3;        % Threshold for performing the resampling step;
nx = 4;                  % dimention of the state vector
nz = 3;                  % dimension of the measurement vector

nb_tar=length(nodes);
n=nx*nb_tar;
simu_t= length(nodes(1).x);
Mn=length(sensors);
epsilonx=50;%parameter for mahalanobis distance
epsilonv=40;%parameter for mahalanobis distance
epsilon2=500;

MC_runs =1; %number of Monte Carlo runs
%
xParticle_pf =    zeros(n,N);  xParticlePrec = xParticle_pf;
X_curr = zeros(nx,1);X_est=zeros(nb_tar,nx);

