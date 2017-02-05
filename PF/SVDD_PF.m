clear
close all
clc
ker = 'rbf';
x = 0.1; % initial state
Q = 1; % process noise covariance
R = 1; % measurement noise covariance
tf = 50; % simulation length

N = 100; % number of particles in the particle filter

xhat = x;
P = 2;
xhatPart = x;
warning('off')
% Initialize the particle filter.
for i = 1 : N
    xpart(i) = x + sqrt(P) * randn;
end

xArr = [x];
yArr = [x^2 / 20 + sqrt(R) * randn];
xhatArr = [x];
PArr = [P];
xhatPartArr = [xhatPart];

close all;

for k = 1 : tf
    % System simulation
    x = 0.5 * x + 25 * x / (1 + x^2) + 8 * cos(1.2*(k-1)) + sqrt(Q) * randn; 
    y = x^2 / 20 + sqrt(R) * randn; 
    % Particle filter
    
     for i = 1 : N
        xpartminus(i) = 0.5 * xpart(i) + 25 * xpart(i) / (1 + xpart(i)^2) + 8 * cos(1.2*(k-1)) + sqrt(Q) * randn;
     end
    % compute the sparse SVDD kernel density estimate
    gamma = 1/(2*(10^2));
    K = computeKgm(xpartminus',ker,gamma); 
    [svi, alpha,c] = svdd_train(xpartminus',K,ker,0.1,gamma); 
    % compute weigths for SVDD
    wk = zeros(N,1);
    for i = 1 : size(svi,1)
         ind = svi(i);
         ypart = xpartminus(ind)^2 / 20;
         vhat = y - ypart; 
         likelihood = (1 / sqrt(R) / sqrt(2*pi)) * exp(-vhat^2 / 2 / R);
         wk(ind) = likelihood * alpha(i);
    end
    [~,ind] = max(wk);
    xhatPart = xpartminus(ind);
    
    % Normalize the likelihood of each a priori estimate.
    wk = wk/sum(wk);
    % Resample.
    for i = 1 : N
        u = rand; % uniform random number between 0 and 1
        qtempsum = 0;
        for j = 1 : N
            qtempsum = qtempsum + wk(j);
            if qtempsum >= u
                xpart(i) = xpartminus(j);
                break;
            end
        end
    end
    % The particle filter estimate is the mean of the particles.
    
   
    % Save data in arrays for later plotting
    xArr = [xArr x];
    yArr = [yArr y];
    xhatPartArr = [xhatPartArr xhatPart];
end

t = 0 : tf;

figure;
hold on
plot(t, xArr);
ylabel('true state');
plot(t, xhatPartArr);
legend('true','Particle Filter')


