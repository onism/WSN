%% Code Author: Ahmed Tashrif Kamal - tashrifahmed@gmail.com
% http://www.ee.ucr.edu/~akamal
% no permission necessary for non-commercial use
% Date: 4/27/2013

%% 
disp('Generating Sensors...');
initPts = gridxMin:10:gridxMax-sensorRange;
numPts = length(initPts);
if Nc<9
    error('Nc should be atleast 9 to ensure full area coverage.');
end
fixedSensors = [gridxMin,gridyMin; gridxMax-sensorRange,gridyMin; gridxMin,gridyMax-sensorRange ;...
    gridxMax-sensorRange,gridyMax-sensorRange ; 150,0  ;  300,150 ;  150,300;  0,150; 150,150]';



%% Generate FOV
sensorBottomLeftLocs = [fixedSensors,initPts(randi(numPts,[2,Nc-9]))];
FOV = [sensorBottomLeftLocs;sensorBottomLeftLocs+sensorRange];

% 
% save('FOV.mat','FOV');