clear
close all
clc
% ref: Set JPDA Filter for Multitarget Tracking
% ref The probabilistic data association filter 2009
% this is PDAF this is have some problem, I will fixed it, but I do not
% have time
steps  = 30; % steps
T = 1;
init_position=[150 30 10 80;
                 50 40 150 30];
z_dim = 2;
Pd = 1; % detection prob
Pg = 0.99;%gate size in percentage
gamma= chi2inv(Pg,z_dim);  % used for eq 34 for validation region
sigma_w = [10 10];


omegat = 0.04;

F = [1 (sin(T*omegat)) 0 ((1 - cos(omegat * T ))/omegat);
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
lambdf = 10;

N = 2; % two targets
x_dim = 4; % state dim
% generate the traje
traj = zeros(N, x_dim, steps);
traj(:,:,1) = init_position;

for i = 1 : N
    for t = 2 : steps
        traj(i,:,t) = F * traj(i,:,t-1)' + G * sqrt(Q) * randn(2,1);
    end
end

% gen measurements  no clutter now I will add in the later

meas = zeros(N,z_dim,steps);

for i = 1 : N
   for t = 1 : steps
     meas(i,:,t ) = H * traj(i,:,t)' +sqrtm(R) * randn(z_dim,1);
   end
end

% draw track
% figure
% hold on
% for i = 1 : N
%      
%     plot(traj(i,1,:),traj(i,2,:));
% end
% xlabel('x(m)'),ylabel('y(m)');
% legend('Track 1','Track 2');

% run
% init kalman filter for targets
x_update = zeros(x_dim,N);
P_update(:,:,1) = eye(x_dim,x_dim);
P_update(:,:,2) = eye(x_dim,x_dim);


for t = 1 : steps
    % i-th track
    for i = 1 : N
        % kalman filter predict
        x_predict(:,i)  = F * x_update(:,i); % eq(30)
        P_predict(:,:,i) = F * P_update(:,:,i) * F' + G * Q * G'; % eq(32)
        Z_predict(:,i) = H * x_predict(:,i);  % eq(31)
        S(:,:,i) = H * P_predict(:,:,i)*H' + R; % eq(33)
        % measurement validation eq(34)
        innov = bsxfun(@minus,meas(:,:,t), Z_predict(:,:,i));
        validated = [];
        for j = 1 : size(meas,1)
            if innov(:,j)'/S(:,:,i)*innov(:,j) < gamma
                validated = [validated j];
            end
        end
        N_gated = length(validated);
        gated_innov = innov(:,validated);
% compute the beta eq(37)
       lik = Pd * mvnpdf(gated_innov,[0 0],S(:,:,i))\lambdf;
       beta = lik./(1 + Pd*Pg + sum(lik));
       beta0 = (1 - Pd*Pg)/(1 + Pd*Pg + sum(lik));
       W = P_predict(:,:,i) * H' * inv(S(:,:,i));
       total_innov = gated_innov * beta; % eq 40
       est_mean = x_predict(:,:,i) + W * total_innov; % eq 39
       Pc = P_predict(:,:,i)  - W * S * W';
       % eq 44
       for j = 1 : N_gated
            betavv(:,:,j) = beta(j) * gated_innov(:,i)*gated_innov(:,i)';
       end
       Ptilde = W * (sum(betavv - gated_innov(:,i)*gated_innov(:,i)')) * W';
       P_update(:,:,i) = beta0*P_predict(:,:,i) + (1 -beta0)*Pc + Ptilde; %eq 42
       x_update(:,:,i) = est_mean;





    end


end
