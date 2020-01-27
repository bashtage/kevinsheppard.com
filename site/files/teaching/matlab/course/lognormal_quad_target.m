function gx_fx = lognormal_quad_target(x,mu,sigma)
% Quadrature target for the log-normal

gx_fx = exp(x).*normpdf(x,mu,sigma);
