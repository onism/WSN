%% Code Author: Ahmed Tashrif Kamal - tashrifahmed@gmail.com
% http://www.ee.ucr.edu/~akamal
% no permission necessary for non-commercial use
% Date: 4/27/2013

%% 
function flag = pointInRect(z,Rect)
flag = 0;
if z(1)>=Rect(1) && z(1)<=Rect(3) && z(2)>=Rect(2) && z(2)<=Rect(4)
    flag = 1;
end
end