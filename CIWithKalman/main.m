clc
clear
close all
% this file is wrote by junjie wang, junjiehit@163.com
Steps = 100;
T = 1;
F = [1 T; 0 1];
% there are three sensors.
R1 = 1;
R2 = 0.54;
R3 = 2;
G = [0.5*T^2; T];
Qw = 2;
H1 = [1 0];
H2 = [0.4 0.8];
H3 = [0.6 1];

% generate the measurements and traj
xa(:,1) = [0;0];
y1(:,1) = H1 * xa(:,1) + sqrt(R1)*randn;
y2(:,1) = H2 * xa(:,1) + sqrt(R2)*randn;
y3(:,1) = H3 * xa(:,1) + sqrt(R3)*randn;

for t = 2 : Steps
    xa(:,t) = F * xa(:,t-1) + G * Qw * randn;
    y1(:,t) = H1 * xa(:,t) + sqrt(R1)*randn;
    y2(:,t) = H2 * xa(:,t) + sqrt(R2)*randn;
    y3(:,t) = H3 * xa(:,t) + sqrt(R3)*randn;
end

figure
hold on
plot(xa(1,:),xa(2,:))

% sensor 1
P_ = eye(2);
x_ = zeros(2,1);

x_pred = x_;
P_pred = P_;
Q = G * Qw * G';
for t = 1 : Steps
    [x_upd1(:,t), P_upd1(:,:,t)] = KF_upd(x_pred,P_pred, H1, R1, y1(:,t));
    [x_pred,P_pred] = KF_pred(x_upd1(:,t), P_upd1(:,:,t),F,Q);
end


x_pred = x_;
P_pred = P_;
Q = G * Qw * G';
for t = 1 : Steps
    [x_upd2(:,t), P_upd2(:,:,t)] = KF_upd(x_pred,P_pred, H2, R2, y2(:,t));
    [x_pred,P_pred] = KF_pred(x_upd2(:,t), P_upd2(:,:,t),F,Q);
end

x_pred = x_;
P_pred = P_;
Q = G * Qw * G';
for t = 1 : Steps
    [x_upd3(:,t), P_upd3(:,:,t)] = KF_upd(x_pred,P_pred, H3, R3, y3(:,t));
    [x_pred,P_pred] = KF_pred(x_upd3(:,t), P_upd3(:,:,t),F,Q);
end

% GCI fusion
for t = 1 : Steps
 w(1) = trace(P_upd1(:,:,t));
 w(2) = trace(P_upd2(:,:,t));
 w(3) = trace(P_upd3(:,:,t));
 w = w / sum(w);
 [m,P ] = CI_fusion(x_upd1(:,t),P_upd1(:,:,t),x_upd2(:,t),P_upd2(:,:,t),x_upd3(:,t),P_upd3(:,:,t),w);
 CI_M(:,t) = m;
 CI_P(:,:,t) = P;
end

hold on

plot(x_upd1(1,:),x_upd1(2,:))
plot(x_upd2(1,:),x_upd2(2,:))
plot(x_upd3(1,:),x_upd3(2,:))
plot(CI_M(1,:),CI_M(2,:))

mse1 = norm(xa - x_upd1);
mse2 = norm(xa - x_upd2);
mse3 = norm(xa - x_upd3);
mse4 = norm(xa - CI_M);
