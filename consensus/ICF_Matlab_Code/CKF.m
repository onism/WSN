%% Code Author: Ahmed Tashrif Kamal - tashrifahmed@gmail.com
% http://www.ee.ucr.edu/~akamal
% no permission necessary for non-commercial use
% Date: 4/27/2013

%% 
classdef CKF < handle
    properties
        x;
        x_;
        J;
        J_;
    end
    
    methods
        
        %% constructor
        function a = CKF(Nc,p,T,eta,xa,P)
            if (nargin > 0)
                a = CKF;
                
                %MAP estimate of all priors
                x_sum = zeros(p,1);
                a.J_ = zeros(p,p);
                for i=1:Nc
                    Jtemp = eye(p,p)/P{i};
                    a.J_ = a.J_ + Jtemp;
                    x_sum = x_sum + Jtemp * (xa(:,1) + eta{i});
                end
                a.x_ = a.J_\x_sum;
                
                
                a.x = zeros(p,T);
                a.J = zeros(p,p);
            end
        end %end constructor
        
        
        
        %% Estimate
        function estimate(a,Nc,p,t,Phi,Q,z,zCount,H,Rinv)
            %process measurement
            u = zeros(p,Nc);
            U = zeros(p,p,Nc);
            for i=1:Nc
                if zCount(i)>0
                    u(:,i) = H' * Rinv * z{i};
                    U(:,:,i) = H' * Rinv * H;
                else
                    u(:,i) = zeros(p,1);
                    U(:,:,i) = zeros(p,p);                   
                end
            end
            
            %Kalman Filter in equivalent weighted averaging form
            %Can be easily derived from the information form
            x_sum = a.J_* a.x_;
            a.J = a.J_;
            for i=1:Nc
                a.J =  a.J + U(:,:,i);
                x_sum  = x_sum + u(:,i);
            end
            a.x(:,t) = a.J \ x_sum;

            %predict
            a.x_ = Phi * a.x(:,t);
            a.J_ = eye(p,p)/ ( Phi / a.J * Phi' + Q );
            
        end
    end %methods
    
end