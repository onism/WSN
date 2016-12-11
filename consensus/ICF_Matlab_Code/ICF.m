%% Code Author: Ahmed Tashrif Kamal - tashrifahmed@gmail.com
% http://www.ee.ucr.edu/~akamal
% no permission necessary for non-commercial use
% Date: 4/27/2013

%% 
classdef ICF < handle
    properties
        x;
        x_;
        J;
        J_;
        V;
        Vtemp;
        v;
        vtemp;
    end
    
    methods
        
        %% constructor
        function a = ICF(Nc,p,T,eta,xa,P)
            if (nargin > 0)
                a(Nc,1) = ICF;
                
                for i=1:Nc
                    a(i).x_= xa(:,1) + eta{i};
                    a(i).J_ = eye(p,p)/P{i};
                    
                    a(i).x = zeros(p,T);
                    a(i).J = zeros(p,p);
                    a(i).v = zeros(p,1);
                    a(i).V = zeros(p,p);
                    a(i).vtemp = zeros(p,1);
                    a(i).Vtemp = zeros(p,p);
                end
            end
        end %end constructor
        
        
        
        %% prepData
        function prepData(a,Nc,z,zCount,H,Rinv,p)
            for i=1:Nc
                if zCount(i)>0
                    u = H' * Rinv * z{i};
                    U = H' * Rinv * H;
                else
                    u = zeros(p,1);
                    U = zeros(p,p);                   
                end
                
                a(i).v = 1/Nc * a(i).J_ * a(i).x_ +u;
                a(i).V = 1/Nc * a(i).J_ + U;
            end
        end
        
        
        %% consensus
        function consensus(a,Nc,p,K,eps,E)
            for k=1:K
                for i=1:Nc
                    a(i).vtemp = zeros(p,1);
                    a(i).Vtemp = zeros(p,p);
                    Delta = sum(E(i,:));
                    for i_=1:Nc
                        if E(i,i_)
                            a(i).vtemp = a(i).vtemp + a(i_).v;
                            a(i).Vtemp = a(i).Vtemp + a(i_).V;
                        end
                    end
                    a(i).vtemp =   (1-Delta*eps)*a(i).v  + eps*a(i).vtemp;
                    a(i).Vtemp =   (1-Delta*eps)*a(i).V  + eps*a(i).Vtemp;
                    
                end
                
                for i=1:Nc
                    
                    a(i).v = a(i).vtemp;
                    a(i).V = a(i).Vtemp;
                    
                end
            end
        end        

        
        
        %% Estimate
        function estimate(a,Nc,p,t,Phi,Q)
            for i=1:Nc
                a(i).x(:,t) = a(i).V \ a(i).v;
                a(i).J = Nc * a(i).V;
                a(i).x_ = Phi * a(i).x(:,t);
                a(i).J_ = eye(p,p)/ ( Phi / a(i).J * Phi' + Q );
            end
        end
        

        
        
        
    end %methods
    
end