%% Code Author:junjie wang wangjunjie2013@gmail.com
% this file is kalman filter with KLA
% no permission necessary for non-commercial use
% Date: 11/12/2016

%%
classdef KFKLA < handle
    properties
        x_;
        P_;

        x;
        M;

        sum_dx;
        gamma2;

        y;
        S;

        u;
        U;
    end

    methods

        %% constructor
        function a = KFKLA(Nc,p,T,eta,xa,P)
            if (nargin > 0)
                a(Nc,1) = KFKLA;

                for i=1:Nc
                    a(i).x_= xa(:,1) + eta{i};
                    a(i).P_ = P{i};

                    a(i).x = zeros(p,T);
                    a(i).M = zeros(p,p);

                    a(i).sum_dx = zeros(p,1);
                    a(i).gamma2 = zeros(p,p);

                    a(i).y = zeros(p,1);
                    a(i).S = zeros(p,p);

                    a(i).u = zeros(p,1);
                    a(i).U = zeros(p,p);
                end
            end
        end %end constructor



        %% Estimate kalman update
        function estimate(a,Nc,p,t,eps,E,H,R,z,zCount)
            for j = 1 : Nc
                if zCount(j)>0
                    sk = H * a(j).P_ * H' + R;
                    K = a(j).P_ * H' * inv(sk);
                    I = eye(size(K,1),size(H,2));
                    a(j).M = (I - K * H)*a(j).P_;
                    a(j).x(:,t) = a(j).x_ + K * (z{j} - H * a(j).x_);
                else
                    a(j).x(:,t) = a(j).x_;
                    a(j).M = a(j).P_;
                end
           end
        end



        %% consensus  CI fusion
        function consensus(a,Nc,p,K,E,t)
            q = [];
            Omega = [];
            for i = 1 : Nc

                Omega{i} = inv(a(i).M);
                q{i} = inv(a(i).M) * a(i).x(:,t);
            end
            consq = [];
            consOmega = [];
            consq = cons_mat(E,q);
            consOmega = cons_mat(E,Omega);


            for i = 1 : Nc
                a(i).M = inv(consOmega);
                a(i).x(:,t) = inv(consOmega)*consq;
            end

        end

        %% Predict
        function predict(a,Nc,t,Phi,Q)
            for i=1:Nc
                a(i).P_ = Phi*a(i).M*Phi'+Q;
                a(i).x_ = Phi*a(i).x(:,t);
            end
        end


    end %methods

end