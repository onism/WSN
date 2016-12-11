%% Code Author: Ahmed Tashrif Kamal - tashrifahmed@gmail.com
% http://www.ee.ucr.edu/~akamal
% no permission necessary for non-commercial use
% Date: 4/27/2013

%% 
disp('Generating Observations...');
[zt,zCountt] = observe(Nc,xa,H,R,FOV,T,m);
% save ('savedObservations','zt','zCountt');