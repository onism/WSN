%% Code Author: Ahmed Tashrif Kamal - tashrifahmed@gmail.com
% http://www.ee.ucr.edu/~akamal
% no permission necessary for non-commercial use
% Date: 4/27/2013

%% 
classdef GKCF < handle
    properties
        x_;
        J_;
        x_tilde;
        
        x;
        J;
        
        xtemp;
        Jtemp;
        
        y;
        S;
        
        u;
        U;
    end
    
    methods
        
        %% constructor
        function a = GKCF(Nc,p,T,eta,xa,P)
            if (nargin > 0)
                a(Nc,1) = GKCF;
                
                for i=1:Nc
                    a(i).x_= xa(:,1) + eta{i};
                    a(i).J_ = eye(p,p)/P{i};
                    a(i).x_tilde = zeros(p,1);
                    
                    a(i).x = zeros(p,T);
                    a(i).J = zeros(p,p);

                    a(i).xtemp = zeros(p,1);
                    a(i).Jtemp = zeros(p,p);
                    
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
        
        %% consensus
        function consensus(a,Nc,p,K,eps,E)
            for i=1:Nc
                a(i).x_tilde = a(i).J_* a(i).x_;
            end
            
            
            for k=1:K
                for i=1:Nc
                    a(i).xtemp = zeros(p,1);
                    a(i).Jtemp = zeros(p,p);
                    Delta = sum(E(i,:));
                    for i_=1:Nc
                        if E(i,i_)
                            a(i).xtemp = a(i).xtemp + a(i_).x_tilde;
                            a(i).Jtemp = a(i).Jtemp + a(i_).J_;
                        end
                    end
                    a(i).xtemp =   (1-Delta*eps)*a(i).x_tilde  + eps*a(i).xtemp;
                    a(i).Jtemp =   (1-Delta*eps)*a(i).J_  + eps*a(i).Jtemp;
                    
                end
                
                for i=1:Nc
                    a(i).x_tilde = a(i).xtemp;
                    a(i).J_ = a(i).Jtemp;
                end
            end
            
            for i=1:Nc
                a(i).x_ = a(i).J_ \ a(i).x_tilde;
            end
            
        end
        
        
        
        %% Estimate
        function estimate(a,Nc,p,t,Phi,Q)
            for i=1:Nc
                a(i).J = a(i).J_ + a(i).S;
                a(i).x(:,t) = a(i).x_ + a(i).J_\(a(i).y - a(i).S * a(i).x_);
                
                a(i).x_ = Phi * a(i).x(:,t);
                a(i).J_ = eye(p,p)/ ( Phi / a(i).J * Phi' + Q );
            end
        end
        
        
        
        
        
    end %methods
    
end