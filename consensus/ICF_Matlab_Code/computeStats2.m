%% Code Author: Ahmed Tashrif Kamal - tashrifahmed@gmail.com
% http://www.ee.ucr.edu/~akamal
% no permission necessary for non-commercial use
% Date: 4/27/2013

%%
function [ME_icf,ME_gkcf,ME_kcf,ME_ckf,SDE_icf,SDE_gkcf,SDE_kcf,SDE_ckf,e_icf,e_gkcf,e_kcf,e_ckf]...
    = computeStats(xa,result)

icf = result.icf;
gkcf = result.gkcf;
kcf = result.kcf;
ckf = result.ckf ;
kfci = result.kfci;
kfkla = result.kfkla;
T = size(icf(1,1).x,2);
[Nc,Nt] = size(icf);
N = Nc*Nt*T;

%% individual errors
e_icf = zeros(Nc,T);
e_gkcf = zeros(Nc,T);
e_kcf = zeros(Nc,T);
e_kci = zeros(Nc,T);
e_kkla = zeros(Nc,T);
e_ckf = zeros(1,T);


for t=1:T
    e_ckf(1,t) = norm(xa(1:2,t)-ckf.x(1:2,t));
    for  i=1:Nc
        e_icf(i,t) = norm(xa(1:2,t)-icf(i).x(1:2,t));
        e_gkcf(i,t) = norm(xa(1:2,t)-gkcf(i).x(1:2,t));
        e_kcf(i,t) = norm(xa(1:2,t)-kcf(i).x(1:2,t));
        e_kci(i,t) = norm(xa(1:2,t)-kfci(i).x(1:2,t));
        e_kkla(i,t) = norm(xa(1:2,t)-kfkla(i).x(1:2,t));
    end
end


%% mean error
ME_icf = sum(e_icf(:))/N;
ME_gkcf = sum(e_gkcf(:))/N;
ME_kcf = sum(e_kcf(:))/N;
ME_kci = sum(e_kci(:))/N;
ME_kkla = sum(e_kkla(:))/N;
ME_ckf = sum(e_ckf(:))/T;

%% sqrerror
esqr_icf = e_icf.*e_icf;
esqr_gkcf = e_gkcf.*e_gkcf;
esqr_kcf = e_kcf.*e_kcf;
esqr_kci = e_kci.*e_kci;
esqr_kkla = e_kkla.*e_kkla;
esqr_ckf = e_ckf.*e_ckf;

%% standard deviation of error
SDE_icf = sqrt( sum(esqr_icf(:)) /N - ME_icf*ME_icf);
SDE_gkcf = sqrt( sum(esqr_gkcf(:)) /N - ME_gkcf*ME_gkcf);
SDE_kcf = sqrt( sum(esqr_kcf(:)) /N - ME_kcf*ME_kcf);
SDE_kci = sqrt( sum(esqr_kci(:)) /N - ME_kci*ME_kci);
SDE_kkla = sqrt( sum(esqr_kkla(:)) /N - ME_kkla*ME_kkla);
SDE_ckf = sqrt( sum(esqr_ckf(:)) /T - ME_ckf*ME_ckf);

[ME_kfwkfa,SDE_kfwkla] = compute_error(xa,result.kfwkla,Nc,T,N)

disp(['ICF: MeanError: ' num2str(ME_icf) ', Standard Deviation: ' num2str(SDE_icf) ]);
disp(['GKCF: MeanError: ' num2str(ME_gkcf) ', Standard Deviation: ' num2str(SDE_gkcf) ]);
disp(['KCF: MeanError: ' num2str(ME_kcf) ', Standard Deviation: ' num2str(SDE_kcf) ]);
disp(['CKF: MeanError: ' num2str(ME_ckf) ', Standard Deviation: ' num2str(SDE_ckf) ]);
disp(['KFCI: MeanError: ' num2str(ME_kci) ', Standard Deviation: ' num2str(SDE_kci) ]);
disp(['KFKLA: MeanError: ' num2str(ME_kkla) ', Standard Deviation: ' num2str(SDE_kkla) ]);
disp(['KFwKLA: MeanError: ' num2str(ME_kfwkfa) ', Standard Deviation: ' num2str(SDE_kfwkla) ]);
% save('MTIC_Results','ME_icf','ME_gkcf','ME_kcf','ME_ckf','SDE_icf','SDE_gkcf',...
%     'SDE_kcf','SDE_ckf','e_icf','e_gkcf','e_kcf','e_ckf');

end