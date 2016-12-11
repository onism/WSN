%% Code Author: Ahmed Tashrif Kamal - tashrifahmed@gmail.com
% http://www.ee.ucr.edu/~akamal
% no permission necessary for non-commercial use
% Date: 4/27/2013

%% 
function plotTracks(xa,icf,gkcf,kcf,ckf,z,zCount,Nc,t,T)
clf

hold on;


for i = 1:Nc
    if zCount(i)>0
        h_obs = plot(z{i}(1),z{i}(2),'x','Color',[0,0,1],'MarkerSize',8);
    end
end

i=1;

plot(xa(1,1:t),xa(2,1:t),'g','LineWidth',2);
plot(icf(i).x(1,1:t),icf(i).x(2,1:t),'r','LineWidth',1);
%plot(gkcf(i).x(1,1:t),gkcf(i).x(2,1:t),'b','LineWidth',1);
plot(kcf(i).x(1,1:t),kcf(i).x(2,1:t),'k','LineWidth',1);
%plot(ckf.x(1,1:t),ckf.x(2,1:t),'m','LineWidth',1);

axis([0 500 0 500]);
axis square
set(gca,'XTickLabel',[])
set(gca,'YTickLabel',[])
title('ICF Tracking Results')

if t==T
    %false data for legend entries
    h_gt = plot([-100 -50],[-100 -50],'g','LineWidth',2);
    h_icf = plot([-100 -50],[-100 -50],'r','LineWidth',1);
    %h_gkcf = plot([-100 -50],[-100 -50],'b','LineWidth',1);
    h_kcf = plot([-100 -50],[-100 -50],'k','LineWidth',1);
    
    h_legend = legend([h_gt,h_icf,h_kcf,h_obs],'GroundTruth','ICF','KCF','Observation');
    set(h_legend,'FontSize',12);
    
end



end