clear
close all
clc
steps  = 30; % steps
T = 1;
init_position=[150 30 10 80;
                 50 40 150 30];

Pd = 1; % detection prob
Pg = 0.99;
sigma_w = [10 10];


omegat = 0.04;

A = [1 (sin(T*omegat)) 0 ((1 - cos(omegat * T ))/omegat);
     0 cos(omegat) 0 -sin(omegat*T);
     0 -(1 - cos(omegat*T))/omegat 1 sin(omegat*T)/omegat;
     0 sin(omegat*T) 0 cos(omegat*T)];

%Gaussian noise evolution matrix
G=[T^2/2 0;
       T 0;
       0 T^2/2;
       0 T];

Q=[10 0;
   0 10];

H = [1 0 0 0;
     0 0 1 0];

R=[sigma_w(1)^2 0;
    0 sigma_w(1)^2];


N = 2; % two targets
x_dim = 4; % state dim
% generate the traje
traj = zeros(N, x_dim, steps);
traj(:,:,1) = init_position;

for i = 1 : N
    for t = 2 : steps
        traj(i,:,t) = A * traj(i,:,t-1) + G * sqrt(Q) * randn(2,1);
    end
end

% gen measurements  no clutter now I will add in the later
z_dim = 2;
meas = zeros(N,z_dim,steps);

for i = 1 : N
   for t = 1 : steps
     meas(i,:,t ) = H * traj(i,:,t) +sqrtm(R) * randn(z_dim,1);
   end
end

% run
% init kalman filter for targets
x_predict = zeros(x_dim,N);
P_predict = zeros(x_dim,x_dim,N);
for i = 1 : N

end

for t = 1 : steps

end
