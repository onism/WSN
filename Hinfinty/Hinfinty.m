clear
close all
clc
% this file is to implementated the Hinfinity filter
% author: junjie wang
% email: junjiehit@163.com
% I am interested in the nonlinear filter such as kalman, particle filter, RFS filter(PHD/CPHD/GLMB/LMB/CB).
dt = 0.1;
A = [1 dt; 0 1];
G = [dt^2/2;dt];
H = [0 1];
x = [0 0];
