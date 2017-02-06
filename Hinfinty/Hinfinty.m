clear
close all
clc
% this file is to implementated the Hinfinity filter
% author: junjie wang
% email: junjiehit@163.com
% I am interested in the nonlinear filter such as kalman, particle filter, RFS filter(PHD/CPHD/GLMB/LMB/CB).
clear
clc 
close all
T = 1;
F = [1 T 0 0;0 1 0 0;0 0 1 T;0 0 0 1];
G = [T^2/2 0;T 0;0 T^2/2;0 T];
Q = diag([7^2 7^2]);
x(:,1) = [40 0 50 0];
steps = 50;
for t = 2 : steps
    x(:,t) = F * x(:,t-1) + G * sqrtm(Q) * randn(2,1);
end
figure
hold on
plot(x(1,:),x(3,:));
sx = 0;
sy = 0;
R = diag([40^2 (pi/180)^2]);
for t = 1 : steps
    y(:,t) = observation(x(:,t));
%    y(1,t) = sqrt((x(1,t) - sx)^2 + (x(3,t) - sy)^2);
%    y(2,t) = atan2(x(1,t) - sx,x(3,t) - sy);  
   y(:,t) = y(:,t) + sqrtm(R) * randn(2,1);
end
truthX = x;
x = eye(4,1);
P = eye(4,4);
eR = 128*R;
% EKF
for t = 1 : steps
   x_ = F * x ;
   P_ = F * P * F' + G * Q * G';
   hx = observation(x_);
   H = getH(x_);
   yk= y(:,t) - hx ;
   S = H * P_ * H' + eR;
   K = P_ * H' / S;
   ekfx(:,t) = x_ + K * yk;
   P = (eye(4) - K * H)*P_;
   x = ekfx(:,t);
end
plot(ekfx(1,:),ekfx(3,:),'ro-')


% Hinfinty
x = eye(4,1);
P = eye(4,4);
 
gamma = 200000000;
for t = 1 : steps
   x_ = F * x ;
   P_ = F * P * F' + G * Q * G';
   hx = observation(x_);
   H = getH(x_);
   yk= y(:,t) - hx ;
   Rek = blkdiag(eR ,-gamma*eye(4)) + [H;eye(4)] * P_ * [H' eye(4)] ;
   P = P_ - P_ * [H' eye(4)] /Rek * [H' eye(4)]'*P_;
   S = H * P_ * H' + eR;
   K = P_ * H' / S;
   Hinfinty(:,t) = x_ + K * yk;
%     Pinv = inv(P_) - gamma * (G * Q * G') + H' * inv(eR) * H;
%     P = inv(P);
   x = Hinfinty(:,t);
end
plot(Hinfinty(1,:),Hinfinty(3,:),'ko-');
 
