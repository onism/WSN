%% Code Author: Ahmed Tashrif Kamal - tashrifahmed@gmail.com
% http://www.ee.ucr.edu/~akamal
% no permission necessary for non-commercial use
% Date: 4/27/2013

%% 
classdef KCF < handle
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
        function a = KCF(Nc,p,T,eta,xa,P)
            if (nargin > 0)
                a(Nc,1) = KCF;
                
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
        
        
        %% commOnce
        function commOnce(a,Nc,p,E,z,zCount,H,Rinv)
            for i=1:Nc
                if zCount(i)>0
                    a(i).u = H' * Rinv * z{i};
                    a(i).U = H' * Rinv * H;
                else
                    a(i).u = zeros(p,1);
                    a(i).U = zeros(p,p);
                end
            end
            
            for i=1:Nc
                a(i).S = a(i).U;
                a(i).y = a(i).u;
                for i_ = 1:Nc
                    if E(i,i_) == 1
                        a(i).S = a(i).S + a(i_).U;
                        a(i).y = a(i).y + a(i_).u;
                    end
                end
                
            end
        end
        
        
        %% Estimate
        function estimate(a,Nc,p,t,eps,E)
            for i=1:Nc
                a(i).M = eye(p,p)/(eye(p,p)/a(i).P_ + a(i).S );
                a(i).sum_dx = zeros(p,1);
                a(i).gamma2 = eps * a(i).P_ / ( 1 + sqrt(trace(a(i).P_'*a(i).P_)) );
                
                for i_ = 1:Nc
                    if E(i,i_) == 1
                        a(i).sum_dx = a(i).sum_dx + a(i_).x_ - a(i).x_;
                    end
                end
                a(i).x(:,t) = a(i).x_ +   a(i).M * ( a(i).y - a(i).S * a(i).x_ ) + a(i).gamma2 * a(i).sum_dx;
            end
        end
        
        
        %% consensus
        function consensus(a,Nc,p,K,E,t)
            for k=2:K
                for i = 1:Nc
                    a(i).sum_dx = zeros(p,1);
                    for i_ = 1:Nc
                        if E(i,i_) == 1
                            a(i).sum_dx = a(i).sum_dx + a(i_).x(:,t) - a(i).x(:,t);
                        end
                    end
                end
                
                for i=1:Nc
                    a(i).x(:,t)  = a(i).x(:,t)  + a(i).gamma2 * a(i).sum_dx;
                end
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