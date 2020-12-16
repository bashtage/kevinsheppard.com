function [y, x] = generate_data(n, k, m, r2, strength, rho)
% GENERATE_DATA Simulate data to experiment with prediction
%   [Y, X] = GENERATE_DATA(N, K, M, R2, STRENGTH, RHO) 
%
%  N - Number of data points to generate
%  K - Number of relevant regressors in the model 
%  M - Number of irrelevant regressors to generate
%  R2 - Population R2 of model
%  STRENGTH - Value in (0, 1) which determines speed that true coefficients
%             decline
%  RHO - Scalar correlation between regressors
%
%  Returns Y (N by 1) and X (N by K+M) where the true regressors are in
%  positions 1:K and the extraneous regressors are in positions (K+1:M)
%
%  Regressors are generated using a 1 factor model so that rho is the
%  correlation between all regressors.  The true coefficient will decay so
%  that the ratio of STRENGTH = beta(i) / beta(i - 1)

% Generate the x data
x = randn(n, (k+m));
% Use a common factor to enfore a specific value for correlation.  This is
% like a CAP-M where correlation is due to exposure to a common factor
x = bsxfun(@plus, sqrt(rho) * randn(n,1), sqrt(1-rho) * x);
% Compute initial values of b
b = strength .^ (0:k-1);
% Compute the fitted values
fit = x(:,1:k) * b';
% Compute the theoretical correlation of the x data
corr = ones(k,k) * rho + eye(k)*(1-rho);
% Compute the variance of the fit
tot_var = b*corr*b';
% Rescale fot to have unit variance
fit = fit / sqrt(tot_var);
% Rescale fit to achieve the target R2
fit = fit * sqrt(r2 / (1-r2));
% Generate the residuals
e = randn(n, 1);
% Generate the data
y = fit + e;
