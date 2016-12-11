%% Code Author: Ahmed Tashrif Kamal - tashrifahmed@gmail.com
% http://www.ee.ucr.edu/~akamal
% no permission necessary for non-commercial use
% Date: 4/27/2013

%% 
function [zt,zCountt]=observe(Nc,xa,H,R,FOV,T,m)
zt = cell(T,1);
zCountt = cell(T,1);
meanc = [0;0];

for t=1:T
    
    z = cell(Nc,1);
    zCount = zeros(Nc,1);

    for i = 1:Nc
        % generate observations
        ztemp = H*xa(:,t);
        if pointInRect(ztemp,FOV(:,i))
            z{i} = ztemp+mvnrnd(meanc,R)';
            zCount(i) = zCount(i) + 1;
        else
            z{i}=zeros(m,1);
        end
        
    end
    zt{t} = z;
    zCountt{t} = zCount;
end

end