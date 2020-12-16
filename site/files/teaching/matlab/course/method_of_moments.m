%% Method of Moments
%% Notes
% This solution relies heavily on the maximum likelihood solution, especially 
% for the Probit standard error Monte Carlo.
% 
% This solution first shows a simple example, and then wraps it in a loop 
% to perform the Monte Carlo.
%% Setup
% Clear and reset the workspace and load required data

% Clean up everything
clear all
close all
clc
% Reset rng to make runs the same
rng('default')
% Load the data
load SP_FTSE
%% S&P 500
% This solution answers questions 1 - 4 for the S&P 500 and then for the FTSE 
% 100. This produces a simpler solution.
%% Returns
% Here I use 100 x returns which are nicer to look at than actual returns. The 
% method of moment estiamtors are implemented directly from the notes.

% 100 x returns
r = 100 * diff(log(SP500_monthly(:,3)));
% First four moments, and transformation to get skewness and kurtotis
mu = mean(r)
sigma2 = mean((r-mu).^2)
mom3 = mean((r-mu).^3);
skewness = mom3/sigma2^(3/2)
mom4 = mean((r-mu).^4);
kurtosis = mom4/sigma2^2
%% Covariance estimation
% Here I use compute the moment errors for the mean and the variance. Since 
% these conditions are linear in the moments I am interested in, the Jacobian 
% is just an identity matrix and so it doesn't appear.

u1 = r - mu;
u2 = (r - mu).^2 - sigma2;
u = [u1 u2];
T = length(r);
% This is the cov that appears in the sqrt(T)(theta-hat - theta_0) version
% of the CLT
acov = u'*u / T
% This is the covariance uses for inference, ntoe the divide by T
cov_for_inverence = acov / T
% The standard error is just the square root of the parameter variances
stderr = sqrt(diag(cov_for_inverence))
%% Sharpe ratio
% The sharpe ratio is the ratio of the mean to the standard deviation. The delta 
% method is used to compute the covariance of the Sharpe ratio

SR = mu/sqrt(sigma2)
% Derivative matrix of the non-linear function w.r.t. parameters
D = [sigma2^(-1/2) -1/2*mu*sigma2^(-3/2)];
% Asymptotic covariance
SR_acov = D*acov*D'
% Divide by T for inference
SR_cov_for_inference = SR_acov/T
% Standard error
SR_stderr = sqrt(diag(SR_cov_for_inference))
SR_tstat = SR/SR_stderr
%% Moving windows
% Moving windows are simple graphical tools to examine estimators for stability. 
% This code uses the same moment estimators are in the first part of the solution. 
% subplot is used to graph the data.

% Relabel returns so I can use r in the loop
returns = r;
% Initialize somewhere to store the estimates
mus = zeros(T-119,1);
sigma2s = zeros(T-119,1);
skewnesses = zeros(T-119,1);
kurtoses = zeros(T-119,1);
% Use a loop to estimate the parameters
for i=1:T-119
    r = returns(i:i+119);
    mus(i) = mean(r);
    sigma2s(i) = mean((r-mus(i)).^2);
    mom3 = mean((r-mus(i)).^3);
    skewnesses(i) = mom3/sigma2s(i)^(3/2);
    mom4 = mean((r-mus(i)).^4);
    kurtoses(i) = mom4/sigma2s(i)^2;
end
% Form into a matrix
data = [mus sigma2s skewnesses kurtoses];
% Open a new figure
figure(1)
% Loop over data and use subplot to graph
for i=1:4
    subplot(4,1,i)
    plot(data(:,i))
    axis tight
end
%% FTSE 100
% The remainder presents the results for the FTSE. Note the differences in teh 
% kurtosis, Sharpe ratio and the standard errors
%% Returns
% Here I use 100 x returns which are nicer to look at than actual returns. The 
% method of moment estiamtors are implemented directly from the notes.

% 100 x returns
r = 100 * diff(log(FTSE100_monthly(:,3)));

% First four moments, and transformation to get skewness and kurtotis
mu = mean(r)
sigma2 = mean((r-mu).^2)
mom3 = mean((r-mu).^3);
skewness = mom3/sigma2^(3/2)
mom4 = mean((r-mu).^4);
kurtosis = mom4/sigma2^2
%% Covariance estimation
% Here I use compute the moment errors for the mean and the variance. Since 
% these conditions are linear in the moments I am interested in, the Jacobian 
% is just an identity matrix and so it doesn't appear.

u1 = r - mu;
u2 = (r - mu).^2 - sigma2;
u = [u1 u2];
T = length(r);
% This is the cov that appears in the sqrt(T)(theta-hat - theta_0) version
% of the CLT
acov = u'*u / T
% This is the covariance uses for inference, ntoe the divide by T
cov_for_inverence = acov / T
% The standard error is just the square root of the parameter variances
stderr = sqrt(diag(cov_for_inverence))
%% Sharpe ratio
% The sharpe ratio is the ratio of the mean to the standard deviation. The delta 
% method is used to compute the covariance of the Sharpe ratio

SR = mu/sqrt(sigma2)
% Derivative matrix of the non-linear function w.r.t. parameters
D = [sigma2^(-1/2) -1/2*mu*sigma2^(-3/2)];
% Asymptotic covariance
SR_acov = D*acov*D'
% Divide by T for inference
SR_cov_for_inference = SR_acov/T
% Standard error
SR_stderr = sqrt(diag(SR_cov_for_inference))
SR_tstat = SR/SR_stderr
%% Moving windows
% Moving windows are simple graphical tools to examine estimators for stability. 
% This code uses the same moment estimators are in the first part of the solution. 
% subplot is used to graph the data.

% Relabel returns so I can use r in the loop
returns = r;
% Initialize somewhere to store the estimates
mus = zeros(T-119,1);
sigma2s = zeros(T-119,1);
skewnesses = zeros(T-119,1);
kurtoses = zeros(T-119,1);
% Use a loop to estimate the parameters
for i=1:T-119
    r = returns(i:i+119);
    mus(i) = mean(r);
    sigma2s(i) = mean((r-mus(i)).^2);
    mom3 = mean((r-mus(i)).^3);
    skewnesses(i) = mom3/sigma2s(i)^(3/2);
    mom4 = mean((r-mus(i)).^4);
    kurtoses(i) = mom4/sigma2s(i)^2;
end
% Form into a matrix
titles = {'Ann mean','Ann std','Skewness','Kurtosis'};
data = [12 * mus / 100 sqrt(12*sigma2s/10000) skewnesses kurtoses];
% Open a new figure
figure(2)
% Loop over data and use subplot to graph
for i=1:4
    subplot(4,1,i)
    plot(data(:,i))
    title(titles{i});
    axis tight
end