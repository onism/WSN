%% KF_upd: Kalman filter update
function [x_pred, P_pred] = KF_upd(x_pred,P_pred, H, R, z)
    eta = z - H * x_pred;
    S = R  + H * P_pred * H';
    K = P_pred * H' / S;
    x_pred = x_pred + K * eta ;
    P_pred = P_pred - K * S * K';
