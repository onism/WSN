%% Code Author: Ahmed Tashrif Kamal - tashrifahmed@gmail.com
% http://www.ee.ucr.edu/~akamal
% no permission necessary for non-commercial use
% Date: 4/27/2013

%% 
disp('Generating Prior Errors...');

P = cell(Nc,1);
eta = cell(Nc,1);
for i=1:Nc
    %P{i} = diag( [100 100 10 10].* rand(1,4) );
    P{i} = diag([100,100,10,10]);
    eta{i} = mvnrnd(zeros(p,1),P{i})';
end
% save('PriorError.mat','eta','P');
