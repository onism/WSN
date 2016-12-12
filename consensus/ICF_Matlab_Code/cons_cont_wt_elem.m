function [x, T, X, norm_delta] = cons_cont_wt_elem(cm, x0, wt)



for i = 1:length(x0)
    x0(i) = wt(i) * x0(i);
end
x0_mean = mean(x0);

t0 = 0;
tf = 15;

D = diag(sum(cm, 2) );
L = D - cm;
assert(size(x0, 1) == 1);
[T, X] = ode45(@inputs, [t0, tf], x0, [], L);

delta = zeros(size(X, 1), length(x0) );
norm_delta = zeros(1, size(X, 1) );
for i = 1:size(X, 1)
    delta(i, :) = X(i, :) - x0_mean;
    norm_delta(i) = norm(delta(i, :) );
end

x = mean(X(end, :));