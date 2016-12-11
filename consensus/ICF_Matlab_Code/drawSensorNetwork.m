%% Code Author: Ahmed Tashrif Kamal - tashrifahmed@gmail.com
% http://www.ee.ucr.edu/~akamal
% no permission necessary for non-commercial use
% Date: 4/27/2013

%% 
function drawSensorNetwork(FOV,E)
h1 = figure(1);
clf
plotFOV(FOV);
axis([0 500 0 500]);
axis square
title('Sensor FoVs and Network Connectivity')
hold on
Nc = size(FOV,2);
sensorCenters = [(FOV(1,:)+FOV(3,:))/2;(FOV(2,:)+FOV(4,:))/2];
% plot camera names
for i=1:Nc
   text(sensorCenters(1,i),sensorCenters(2,i),['C_{' num2str(i) '}']); 
end

%plot network connectivity
for i=1:Nc
    for i_=i+1:Nc
        if E(i,i_)
            plot( [sensorCenters(1,i),sensorCenters(1,i_)], [sensorCenters(2,i),sensorCenters(2,i_)] ,'b--'  )
        end
    end
end


box on;
% saveas(h1,'FOV.pdf');


