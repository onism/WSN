clear
close all
clc
load('particles.mat')
ker = 'rbf';
gamma = 1/(2*(80^2));
K = computeKgm(xpart',ker,gamma); 
[svi, alpha,c] = svdd_train(xpart',K,ker,0.1,gamma); 
