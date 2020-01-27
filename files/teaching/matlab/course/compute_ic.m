function [aic, bic] = compute_ic(y, x, selection)
% COMPUTE_IC computes AIC and BIC for a set of linear regressions
%   [AIC, BIC] = COMPUTE_IC(Y, X, SELECTION)
%
% Y - N by 1 array of dependent data
% X - N by K array of regressors
% SELECTION - Cell array where each value is a set of columns to consider

% The number of models considered
m = size(selection, 1);
% Setup output arrays
aic = zeros(m,1);
bic = zeros(m,1);
% Look over column combinations
for i = 1:m
    cols = selection{i};
    % Select columns
    temp_x = x(:,cols);
    % Compute errors
    e = y - temp_x * (temp_x\y);
    % Get the number of columns
    k = length(cols);
    % Get the number of observations
    n = length(y);
    % Compute the variance of the residuals
    sigma2 = e'*e /n;
    % Compute the IC.  Note the only differnce is the 2 or log(n)
    aic(i) = log(sigma2) + k * 2 / n;
    bic(i) = log(sigma2) + k * log(n) / n;
end
