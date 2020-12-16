%% Filtered Historical Value-at-Risk Forecasting
% This task shows how to perform historical simulation, which simply uses the 
% empirical CDF, to forecast VaR
%% Prepare the workspace
% Clean up before starting
%%
clear all
close all
clc
%% SP500
% Load the data and the VaR estimates
%%
load sp500
load HS_VaR
load FHS_VaR
 
rets = diff(log(sp500));
VaRs = [sp500_HS_VaR sp500_FHS_VaR];
%% HITs
% HIT is a VaR violation, and so it is an indicator variable for the return 
% less than the VaR forecast, recalling that the forecast for period t is stored 
% in position t-1. bsxfun is used to apply the < operator (@lt) for all series 
% at once.
%%
HITs = bsxfun(@lt,rets(2:end),VaRs(1:end-1,:));
% The expected HIT percentage
alpha = [.05 .01 .05 .01];
 
labels = {'HS VaR 5%','HS VaR 1%','FHS VaR 5%','FHS VaR 1%'};
%% Unconditional Testing
% The most basic test is an unconditional test using the average HIT probability, 
% which should match alpha. This is easy to implement using a regression.
% 
% Only the 1% VaR from FHS passes this test. The t-stats are positive for 
% the HS methods, indicating under prediction of VaR. They are negative for the 
% 5% FHS, indicating that it is conservative.
%%
disp('Unconditional test (T-stat)')
for i=1:4
    [excess,tstat,~,~,vcvw] = ols(HITs(:,i) - alpha(i),[],1);
    disp(labels{i})
    disp(tstat)
end
%% Dynamic Quantile Testing
% The DQ test includes lagged values and so generalizes the previous test. The 
% first version includes a single lag while the second looks at 10 lags. When 
% 1 lag is included, only the 1% FHS is not rejected. When 10 lags are included 
% all models are rejected. The tests are also performed on only the lag parameters 
% by excluding the intercept. The previous test showed that the intercepts are 
% often off, so it may be interesting to test the dynamics. However, these are 
% also generally rejected.
%%
disp('DQ test (P-val), 1 lag')
for i=1:4
    [y,X] = newlagmatrix(HITs(:,i) - alpha(i),1,0);
    [excess,tstat,~,~,vcvw] = ols(y,X,1);
    test_stat = excess' * inv(vcvw) * excess;
    pval = 1 - chi2cdf(test_stat,6);
    disp(labels{i})
    disp(pval)
    sel = 2;
    test_stat = excess(sel)' * inv(vcvw(sel,sel)) * excess(sel);
    pval = 1 - chi2cdf(test_stat,1);
    disp('Test excluding the intercept')
    disp(pval)
end
 
disp('DQ test (P-val), 10 lags')
for i=1:4
    [y,X] = newlagmatrix(HITs(:,i) - alpha(i),10,0);
    [excess,tstat,~,~,vcvw] = ols(y,X,1);
    test_stat = excess' * inv(vcvw) * excess;
    pval = 1 - chi2cdf(test_stat,11);
    disp(labels{i})
    disp('Test with the intercept')
    disp(pval)
    sel = 2:11;
    test_stat = excess(sel)' * inv(vcvw(sel,sel)) * excess(sel);
    pval = 1 - chi2cdf(test_stat,10);
    disp('Test excluding the intercept')
    disp(pval)
end
%% Unconditional Testing using the Bernoulli
% The unconditional test can be improved using the Bernoulli. This isn't really 
% needed here since the unconditional tests rejected strongly, except for the 
% 1% FHS model.
%%
disp('Bernoulli test (P-val)')
for i=1:4
    y = HITs(:,i);
    p_0 = alpha(i);
    p_hat = mean(y);
    log_lik = sum(y.*log(p_hat) + (1-y).*log(1-p_hat));
    log_lik_0 = sum(y.*log(p_0) + (1-y).*log(1-p_0));
    test_stat = 2 * (log_lik - log_lik_0);
    pval = 1 - chi2cdf(test_stat, 1);
    disp(labels{i})
    disp(pval)
end
%% Christoffersen's Conditional Bernoulli Test
% Christoffersen's test follows the derivation in the book very closely. he 
% results are mostly similar to the unconditional Bernoulli results since there 
% isn't much in the first lag.
%%
disp('Christofersen''s test (P-val)')
for i=1:4
    a = alpha(i);
    y = double(HITs(:,i));
    n11 = y(1:end-1)'*y(2:end);
    n01 = (1 - y(1:end-1))'*y(2:end);
    n00 = (1 - y(1:end-1))'*(1 - y(2:end));
    n10 = y(1:end-1)'*(1 - y(2:end));
    p00 = n00 ./ (n00 + n01);
    p11 = n11 ./ (n11 + n10);
    log_lik  = n00*log(p00)+n01*log(1-p00)+n11*log(p11)+n10*log(1-p11);
    log_lik_0 = n00*log(1-a)+n01*log(a)+n11*log(a)+n10*log(1-a);
    test_stat = 2 * (log_lik - log_lik_0);
    pval = 1 - chi2cdf(test_stat, 2);
    disp(labels{i})
    disp(pval)
end
%% EURUSD
% The code for the EURUSD rate is identical, so only the results are discussed.
%%
load eurusd
load HS_VaR
load FHS_VaR
 
rets = diff(log(eurusd));
VaRs = [eurusd_HS_VaR eurusd_FHS_VaR];
%% HITs
% HIT is a VaR violation, and so it is an indicator variable for the return 
% less than the VaR forecast, recalling that the forecast for period t is stored 
% in position t-1. bsxfun is used to apply the < operator (@lt) for all series 
% at once.
%%
HITs = bsxfun(@lt,rets(2:end),VaRs(1:end-1,:));
% The expected HIT percentage
alpha = [.05 .01 .05 .01];
 
labels = {'HS VaR 5%','HS VaR 1%','FHS VaR 5%','FHS VaR 1%'};
%% Unconditional Testing
% The rejections are smaller here, but are still pervasive at 5%. The smaller 
% t-stats is most likely due to the smaller sample size. All models over-predict 
% the VaR.
%%
disp('Unconditional test (T-stat)')
for i=1:4
    [excess,tstat,~,~,vcvw] = ols(HITs(:,i) - alpha(i),[],1);
    disp(labels{i})
    disp(tstat)
end
%% Dynamic Quantile Testing
% The DQ results are somewhat different. The 1-lag tests do not reject for the 
% 1% models, and surprisingly the HS 1% VaR does very well. The 5% VaRs are worse, 
% although the FHS does not appear to have a lot of neglected dynamics.
%%
disp('DQ test (P-val), 1 lag')
for i=1:4
    disp(i)
    [y,X] = newlagmatrix(HITs(:,i) - alpha(i),1,0);
    [excess,tstat,~,~,vcvw] = ols(y,X,1);
    test_stat = excess' * inv(vcvw) * excess;
    pval = 1 - chi2cdf(test_stat,6);
    disp(labels{i})
    disp(pval)
    sel = 2;
    test_stat = excess(sel)' * inv(vcvw(sel,sel)) * excess(sel);
    pval = 1 - chi2cdf(test_stat,1);
    disp('Test excluding the intercept')
    disp(pval)
end
 
disp('DQ test (P-val), 10 lags')
for i=1:4
    [y,X] = newlagmatrix(HITs(:,i) - alpha(i),10,0);
    [excess,tstat,~,~,vcvw] = ols(y,X,1);
    test_stat = excess' * inv(vcvw) * excess;
    pval = 1 - chi2cdf(test_stat,11);
    disp(labels{i})
    disp('Test with the intercept')
    disp(pval)
    sel = 2:11;
    test_stat = excess(sel)' * inv(vcvw(sel,sel)) * excess(sel);
    pval = 1 - chi2cdf(test_stat,10);
    disp('Test excluding the intercept')
    disp(pval)
end
%% Unconditional Testing using the Bernoulli
% The 1% VaRs do not reject while the 5% do.
%%
disp('Bernoulli test (P-val)')
for i=1:4
    y = HITs(:,i);
    p_0 = alpha(i);
    p_hat = mean(y);
    log_lik = sum(y.*log(p_hat) + (1-y).*log(1-p_hat));
    log_lik_0 = sum(y.*log(p_0) + (1-y).*log(1-p_0));
    test_stat = 2 * (log_lik - log_lik_0);
    pval = 1 - chi2cdf(test_stat, 1);
    disp(labels{i})
    disp(pval)
end
%% Christoffersen's Conditional Bernoulli Test
% Only the FHS does not reject the conditional Bernoulli test.
%%
disp('Christofersen''s test (P-val)')
for i=1:4
    a = alpha(i);
    y = double(HITs(:,i));
    n11 = y(1:end-1)'*y(2:end);
    n01 = (1 - y(1:end-1))'*y(2:end);
    n00 = (1 - y(1:end-1))'*(1 - y(2:end));
    n10 = y(1:end-1)'*(1 - y(2:end));
    p00 = n00 ./ (n00 + n01);
    p11 = n11 ./ (n11 + n10);
    log_lik  = n00*log(p00)+n01*log(1-p00)+n11*log(p11)+n10*log(1-p11);
    log_lik_0 = n00*log(1-a)+n01*log(a)+n11*log(a)+n10*log(1-a);
    test_stat = 2 * (log_lik - log_lik_0);
    pval = 1 - chi2cdf(test_stat, 2);
    disp(labels{i})
    disp(pval)
end