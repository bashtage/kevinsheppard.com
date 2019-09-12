% Min mse
P = 500;
m = 500;
B = 1000;
rho = 0.5;
bm_error = randn(P,1);
errors = bsxfun(@plus,rho*randn(P,1), ...
    sqrt(1-rho^2) * randn(P,m));


delta = bsxfun(@minus,bm_error.^2,errors.^2);

T_RC = max(mean(delta));

w = 10;
indices = zeros(P,1);
T_RC_star = zeros(B,1);
for b=1:B
    indices(1) = randi(P);
    for i= 2:P
        if rand < (1/w)
            indices(i) = randi(P);
        else
            indices(i) = indices(i-1) + 1;
        end
    end
    indices(indices>P) = indices(indices>P) - P;
    
    delta_star = delta(indices,:);
    delta_bar_star = mean(bsxfun(@minus,delta_star, mean(delta)));
    T_RC_star(b) = max(delta_bar_star);
end
pvalue = mean(T_RC_star > T_RC);