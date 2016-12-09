% ref the paper Stochastic Event-Triggered Particle Filtering for
%State Estimation
clear
close all
clc

% the dynamic system ref the paper Event-triggered fault detection and isolation
%for discrete-time linear systems

F =  [
0.14 0.82 -0.1 -0.21 -1.7 0.0011 -0.003
0.18 -20.0 2.6 4.1 48.0 0.00013 0.067
0.94 -110.0 14.0 21.0 240.0 0.00065 0.48
0.087 -10.0 1.4 2.9 23.0 0.000044 0.00044
0.008 -0.78 0.1 -0.073 3.2 0.0000078 0.0017
-120.0 34.0 -5.3 -14.0 -49.0 -0.57 -0.022
-0.97 110.0 -14.0 -22.0 -260.0 -0.00067 -0.74];

B_w = [
0.00035 0.0043
-0.00000013 -0.15
-0.000014 -0.76
-0.0000012 -0.071
0.000000067 -0.0068
0.055 0.0023
0 0.81];
B_r = B_w;

B_f = [0 0.0043
0 -0.15
0 -0.76
0 -0.071
0 -0.0068
0 0.0023
0 0.81];

H = [1 0 0 0 0 0 0;0 0 0 0 1 0 0];
D_w = zeros(2,2);
D_r = zeros(2,2);
D_f = [1 0; 0 0];