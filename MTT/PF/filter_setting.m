% this file is in order to set the filter
target_position=[1500 500 1500  400];
Steps = 50;
deltaT = 1;
Pd = 0.9;
Pg = 0.99;
g_sigma=9.21;

F = [1 deltaT 0 0;
     0 1 0 0;
     0 0 1 deltaT;
     0 0 0 1];
Q=[4 0;
   0 4];

G=[deltaT^2/2 0;
       deltaT 0;
       0 deltaT^2/2;
       0 deltaT];

H = [1 0 0 0;
     0 0 1 0];
target_delta=100;
R=[target_delta^2  0;
    0  target_delta^2];
P=[target_delta^2 target_delta^2 0 0;
   target_delta^2 2*target_delta^2 0 0;
   0 0 target_delta^2 target_delta^2;
   0 0 target_delta^2 2*target_delta^2];
