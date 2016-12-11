%% Code Author: Ahmed Tashrif Kamal - tashrifahmed@gmail.com
% http://www.ee.ucr.edu/~akamal
% no permission necessary for non-commercial use
% Date: 4/27/2013

%% 

gridxMin = 0; %defining simulation boundaries, don't change these
gridxMax = 500;
gridyMin = 0;
gridyMax = 500;
mag_min = 10; %initial speed range of target (you can change)
mag_max = 30;
angle_min = 0; %initial direction range of target (you can change)
angle_max = 2*pi;

Nc = 9; %number of sensors/cameras (you can change)
p = 4; %state vector length (don't change)
m = 2; %measurement vector length (don't change)
T = 100; %total number of time steps (you can change)

%observation model parameters
R = 100*eye(m,m); %measurement covariance (you can change)
H = [1,0,0,0;  0,1,0,0]; %observation matrix (to change this, you need to manually change the FOV definitions)
Rinv = inv(R);
sensorRange = 200; %length of side of the FOV (don't change)
meanc = [0;0]; %mean of measurement in error generation (maybe you do not need to change this)


% network connectivity
degree = 2; %degree of each edge of network graph (you can change)
E = getConnectivity(Nc,degree); %network graph adjacency matrix


%consensus parameters
K = 20; %total number of consensus iterations per measurement step (you can change)
eps = .65/(max(sum(E))); %rate parameter of consensus (you can change wisely)


%state dynamics model parameters
Phi = [1,0,1,0;  0,1,0,1;   0,0,1,0;  0,0,0,1 ]; %state propagation matrix (do not change)
Q = diag([10, 10, 1 , 1]); %process noise (you can change)

% save ('savedParameters','gridxMin','gridxMax','gridyMin','gridyMax','mag_min','mag_max','angle_min','angle_max',...
%     'Nc','p','m','T','R','H','Rinv','sensorRange','meanc','degree','E','K','eps','Phi','Q');