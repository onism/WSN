%% Code Author: Ahmed Tashrif Kamal - tashrifahmed@gmail.com
% http://www.ee.ucr.edu/~akamal
% no permission necessary for non-commercial use
% Date: 4/27/2013

%% Initialization
disp('Generating Ground Truth Tracks...');
xa = zeros(p,T); %groundtruth state


while 1
    
    flag_restart = 0;
    
    %% initial ground truth position
    speed = mag_min+(mag_max-mag_min)*rand;
    direction = angle_min+(angle_max-angle_min)*rand;
    x = gridxMin + (gridxMax-gridxMin) * rand;
    y = gridyMin + (gridyMax-gridyMin) * rand;
    xa(:,1) = [x ; y ; speed*cos(direction) ; speed*sin(direction)  ];
    
    for t = 1:T
        %% generate ground truth tracks
        if t>1
            xa(:,t) = Phi*xa(:,t-1)+mvnrnd(zeros(p,1),Q)';
            
            % keep iterating only if within the bounding box
            if xa(1,t)> 500 || xa(1,t) < 0 || xa(2,t) > 500 || xa(2,t) < 0
                flag_restart = 1;
                break;
            end
        end
    end %timestep t
    
    if flag_restart
        continue;
    elseif norm( xa(1:2,1) - xa(1:2,T) ) < 200 %discard small tracks
        continue;
    else
        break;
    end
    
end
% save ('groundTruthTracks','xa');
