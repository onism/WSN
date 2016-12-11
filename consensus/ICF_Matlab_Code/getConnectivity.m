%% Code Author: Ahmed Tashrif Kamal - tashrifahmed@gmail.com
% http://www.ee.ucr.edu/~akamal
% no permission necessary for non-commercial use
% Date: 4/27/2013

%% 
function E = getConnectivity(Nc,degree)
if mod(degree,2) ~= 0
    error('degree must be a multiple of 2');
end

if degree >= Nc
    error('degree must be less than the number of cameras');
end

r = zeros(Nc,1);
r(2:degree/2+1) = ones(degree/2,1);
r(end-degree/2+1:end) = ones(degree/2,1);
E = toeplitz(r);
E(1,end) = 0;
E(end,1) = 0;
end

