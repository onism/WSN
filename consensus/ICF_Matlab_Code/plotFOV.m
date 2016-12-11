%% Code Author: Ahmed Tashrif Kamal - tashrifahmed@gmail.com
% http://www.ee.ucr.edu/~akamal
% no permission necessary for non-commercial use
% Date: 4/27/2013
%% 
function plotFOV(FOV)
Nc = size(FOV,2);
for i = 1:Nc
    hold on;
    x = FOV(:,i);
    bbox = [x(1), x(2) ; x(3), x(2) ; x(3), x(4) ; x(1), x(4) ; x(1), x(2)]';
    
    while 1
        color = rand(3,1);
        if sum(color)<2
            break;
        end
    end
    plot(bbox(1,:),bbox(2,:),'Color',color','LineWidth',2);
    axis([0 500 0 500]);
end
end
