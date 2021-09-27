%% Basic Linear Regression
%% Notes
% The main task in this assignment is to write an OLS function to compute many 
% interesting quantities from a regression. This function will be used in the 
% next 2 assignment as well as next term. Be sure to see |ols|
%% Setup
% Clear and reset the workspace and load required data

% Clean up everything
clear all
close all
clc
% Reset rng to make runs the same
rng('default')
% Load data
load FF_data.mat
%% Estimate the model on S1, V1
% The factors are in columns 2, 3 and 4.  The size 1, value 1 (small-growth) 
% return is in the month portfolio returns position 2 (position 1 is year and 
% month).

% Assign X
X = FF_factors_monthly(:,2:4);
% Assign y
y = FF_portfolios_monthly(:,2);
% Remove nan values due to missing data
pl = any(isnan(X),2);
X = X(~pl,:);
y = y(~pl);
% Use ols
[b,tstat,s2,VCV,VCV_white,R2,R2bar,yhat] = ols(y,X,1);
% Display results
disp('--------------------------')
disp('Size 1, Value 1')
disp('Coefficients')
disp(b)
disp('Non rubist T-stat')
disp(tstat)
disp('Robust tstat')
disp(b./sqrt(diag(VCV_white)));
disp('R2')
disp(R2);
%% Estimate the model on S1, V5
% The portfolio returns are sorted by size first then value, so the size 1, 
% value 5 returns are in position 6. 

% Assign y
y = FF_portfolios_monthly(:,6);
% Remove nan values due to missing data
y = y(~pl);
% Use ols
[b,tstat,s2,VCV,VCV_white,R2,R2bar,yhat] = ols(y,X,1);
% Display results
disp('--------------------------')
disp('Size 1, Value 5')
disp('Coefficients')
disp(b)
disp('Non rubist T-stat')
disp(tstat)
disp('Robust tstat')
disp(b./sqrt(diag(VCV_white)));
disp('R2')
disp(R2);
%% Estimate the model on S5, V1

% Assign y
y = FF_portfolios_monthly(:,22);
% Remove nan values due to missing data
y = y(~pl);
% Use ols
[b,tstat,s2,VCV,VCV_white,R2,R2bar,yhat] = ols(y,X,1);
% Display results
disp('--------------------------')
disp('Size 5, Value 1')
disp('Coefficients')
disp(b)
disp('Non rubist T-stat')
disp(tstat)
disp('Robust tstat')
disp(b./sqrt(diag(VCV_white)));
disp('R2')
disp(R2);
%% Estimate the model on S5, V5

% Assign y
y = FF_portfolios_monthly(:,26);
% Remove nan values due to missing data
y = y(~pl);
% Use ols
[b,tstat,s2,VCV,VCV_white,R2,R2bar,yhat] = ols(y,X,1);
% Display results
disp('--------------------------')
disp('Size 5, Value 5')
disp('Coefficients')
disp(b)
disp('Non rubist T-stat')
disp(tstat)
disp('Robust tstat')
disp(b./sqrt(diag(VCV_white)));
disp('R2')
disp(R2);