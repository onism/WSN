%% compute_error: function description
function [ME_filt,SDE_icf] = compute_error(xa,filt,Nc,T,N)

for t=1:T
    for  i=1:Nc
        e_filt(i,t) = norm(xa(1:2,t)-filt(i).x(1:2,t));
    end
end


%% mean error
ME_filt = sum(e_filt(:))/N;


%% sqrerror
esqr_filt = e_filt.*e_filt;


%% standard deviation of error
SDE_icf = sqrt( sum(esqr_filt(:)) /N - ME_filt*ME_filt);
