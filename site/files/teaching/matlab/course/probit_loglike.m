function ll = probit_loglike(parameters,y,x)
% Negative log-likelihood for a simple Probit model
% p_i = Phi(a_0 + a_1 x_i)
%

a0 = parameters(1);
a1 = parameters(2);

p = normcdf(a0+a1*x);
ll = y.*log(p) + (1-y).*log(1-p);
ll = -sum(ll);
