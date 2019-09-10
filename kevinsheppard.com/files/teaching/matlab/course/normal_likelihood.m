function likelihood = normal_likelihood(x, mu, sigma2)
% Compute the normal likelihood for a data point
%
% Inputs
%     x      - The datapoint
%     mu     - The mean
%     sigma2 - The variance
%
% Outputs
%     likelihood - The likelihood from the normal distribution
%
% Notes:
%   This string is what appears when you enter help normal_likelihood
likelihood = 1 / sqrt(2*pi*sigma2) * exp(-(x-mu)^2/(2*sigma2));