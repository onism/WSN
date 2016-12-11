%% Code Author: Ahmed Tashrif Kamal - tashrifahmed@gmail.com
% http://www.ee.ucr.edu/~akamal
% no permission necessary for non-commercial use
% Date: 4/27/2013

%% 
clc;
clear all;
%clear classes;

disp('start');
generateFreshData = true;

if generateFreshData
    run LoadParameters
    run trackGenerator
    run sensorGenerator
    run PriorErrorGenerator
    run observationGenerator
else
    load savedParameters.mat
    load groundTruthTracks.mat
    load FOV.mat
    load priorError.mat
    load savedObservations.mat
end

%initialize plot
drawSensorNetwork(FOV,E);
h_fig_track=figure(2);
clf

%initialize filters
icf = ICF(Nc,p,T,eta,xa,P); %Information-Weighted Consensus Filter
gkcf = GKCF(Nc,p,T,eta,xa,P); %Generalized Kalman Consensus Filter
kcf = KCF(Nc,p,T,eta,xa,P); %Kalman Consensus Filter
ckf = CKF(Nc,p,T,eta,xa,P); %Centralized Kalman Filter

for t=1:T %timestep
    
    %% get measurements
    z = zt{t};
    zCount = zCountt{t};

    %% ICF
    icf.prepData(Nc,z,zCount,H,Rinv,p);
    icf.consensus(Nc,p,K,eps,E);
    icf.estimate(Nc,p,t,Phi,Q);
    
    %% GKCF
    gkcf.commOnce(Nc,p,E,z,zCount,H,Rinv);
    gkcf.consensus(Nc,p,K,eps,E);
    gkcf.estimate(Nc,p,t,Phi,Q);
    
    %KCF
    kcf.commOnce(Nc,p,E,z,zCount,H,Rinv);
    kcf.estimate(Nc,p,t,eps,E);
    kcf.consensus(Nc,p,K,E,t);
    kcf.predict(Nc,t,Phi,Q);
    
    %%
    ckf.estimate(Nc,p,t,Phi,Q,z,zCount,H,Rinv);
    
    %% Plot Tracking
    figure(h_fig_track);
    plotTracks(xa,icf,gkcf,kcf,ckf,z,zCount,Nc,t,T);
    %plotFOV(FOV);
    pause(.001);
end %t

[ME_icf,ME_gkcf,ME_kcf,ME_ckf,SDE_icf,SDE_gkcf,SDE_kcf,SDE_ckf,e_icf,e_gkcf,e_kcf,e_ckf]...
    = computeStats(xa,icf,gkcf,kcf,ckf);

% save plot
box on;
 
