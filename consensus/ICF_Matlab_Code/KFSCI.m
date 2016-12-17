%% Code Author:junjie wang wangjunjie2013@gmail.com
% this file is kalman filter with covariance intersection fusion
% no permission necessary for non-commercial use
% Date: 11/12/2016

%%
classdef KFSCI < handle
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
        function a = KFSCI(Nc,p,T,eta,xa,P)
            if (nargin > 0)
                a(Nc,1) = KFSCI;

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

            for i = 1 : Nc
                count = 1;
                m_(:,count) = a(i).x(:,t);
                P_(:,:,count) = a(i).M;
                for j = 1 : Nc
                    if E(i,j) == 1
                        count = count + 1;
                        m_(:,count) = a(j).x(:,t);
                        P_(:,:,count) = a(j).M;

                    end
                end
                % CI fusion
                w = ones(1,size(m_,2))/size(m_,2);
                for j = 1 : size(m_,2)
                    if j == 1
                        Omega =  inv(P_(:,:,j));
                    else
                        Omega = Omega + inv(P_(:,:,j));
                    end
                end
                P_curr = inv(Omega);
                for j = 1 : size(m_,2)
                    if j == 1
                        m_curr =  inv(P_(:,:,j)) * m_(:,j);
                    else
                        m_curr = m_curr +   inv(P_(:,:,j)) * m_(:,j);
                    end
                end
                m_curr = P_curr * m_curr;
                nSamples = 100;
                mean_zero = zeros(size(m_curr,1),1);
                L = chol(P_curr)';
                X = repmat(mean_zero,1,nSamples) + L*randn(size(mean_zero,1),size(mean_zero,2)*nSamples);
                r = zeros(nSamples,1);
                Denom = zeros(nSamples,size(m_,2));
                denom = zeros(nSamples,1);
                for k = 1 : nSamples
                    for j = 1 :  size(m_,2)
                        Denom(k,j) = X(:,k)' * inv(P_(:,:,j)) * X(:,k);
                    end
                    denom(k) = max(Denom(k,:));
                end

                for k = 1 : nSamples
                    r(k) = X(:,k)' * inv(P_curr) * X(:,k)/denom(k);
                end
                u = 0.5;
                P_curr = P_curr * (u * min(r) + (1 - u) * max(r) );
                a(i).x(:,t) =m_curr;
                a(i).M = P_curr;

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