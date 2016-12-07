%% CI_fusion:  CI fusion
function [m,P ] = CI_fusion(m1,P1,m2,P2,m3,P3,w)
    inv_P = w(1) * inv(P1) + w(2) * inv(P2) + w(3) * inv(P3);
    P = inv(inv_P);
    m = P * (w(1) * inv(P1) * m1 + w(2) * inv(P2) *m2 + w(3) * inv(P3) * m3 );

