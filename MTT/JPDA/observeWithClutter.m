function [ zt,zIdt,zCountt ] = observeWithClutter( lambda,Nt,xa,H,R,T )
 
zt = cell(T,1);
zIdt = cell(T,1);
zCountt = cell(T,1);
meanc = [0;0];

for t = 1 : T 
   z = [];
   zId = [];
   zCount = 0;
   for j = 1 : Nt 
       ztemp = H * xa{j}(:,t) + mvnrnd(meanc,R)';
       z = [z, ztemp];
       zId = [zId,j];
       zCount = zCount + 1;
   end
   % add clutter
   numClutter = poissrnd(lambda);
   for c = 1 : numClutter
       z = [z, 500*rand([2,1])];
       zId = [zId,0];
       zCount = zCount + 1;
   end
   
   zt{t} = z;
   zIdt{t} = zId;
   zCountt{t} = zCount;
end

end

