%% ARCH Model Forecasting
% This task shows how to estimate GARCH models and provides some description 
% of common features of models and parameters
%% Prepare the workspace
% Clean up before starting
%%
clear all
close all
clc

% Suppress a warning
warning off
%% S&P 500: Data and Returns
% Start by loading the data and constructing returns. It is usually a good idea 
% to use 100 * returns which helps numerical stability
%%
load sp500
% Select the last 10 years
sub = (dates > datetime(2008,12,31)) & (dates < datetime(2019,1,1));
sp500 = sp500(sub);
r = 100 * diff(log(sp500));
%% In=sample
% The first half of the sample is used as the in-sample to estimate parameters
%%
T = length(r);
T12 = floor(length(r)/2);
r_12 = r(1:T12);
r_oos = r(T12+1:end);
[parameters,ll,ht]=tarch(r_12,1,1,1,[],1);
%% Forecasting
% The forecast is produced starting at the mid-point and iterating forward using 
% the TARCH formula, which is in absolute values.
%%
sqrt_ht_forecast = zeros(T,1);
sqrt_ht_forecast(1:T12) = sqrt(ht);

omega = parameters(1);
alpha = parameters(2);
gamma = parameters(3);
beta = parameters(4);
for t=T12+1:T
    sqrt_ht_forecast(t) = omega + alpha * abs(r(t-1)) ...
        + gamma * abs(r(t-1)) * (r(t-1)<0) ...
        + beta * sqrt_ht_forecast(t-1);
end
ht_forecast = sqrt_ht_forecast.^2;
%% Absolute accuracy
% Absolute accuracy is tested using both MZ and MZ-GLS regressions. The first 
% is the MZ regression, which regresses the variance forecast error on the forecast 
% and a constant. The second is the GLS version which regresses the standardized 
% error on the inverse of the variance and a constant. Both reject, although the 
% rejection from the GLS is stronger.
%%
h_oos = ht_forecast(T12+1:end);
h_oos_tarch = h_oos;
std_oos = r_oos ./ sqrt(h_oos);

% MZ
y = r_oos.^2 - h_oos;
x = h_oos;
[b,~,~,~,vcv_white] = ols(y,x,1);
wald = b' * inv(vcv_white) * b;
pval = 1 - chi2cdf(wald,2);
disp('MZ')
disp('      Wald      Pval')
disp([wald pval])

% MZ-GLS
y = std_oos.^2 - 1;
x = 1./h_oos;
[b,tstat,s2,~,vcv_white] = ols(y,x,1);
disp('MZ-GLS')
wald = b' * inv(vcv_white) * b;
pval = 1 - chi2cdf(wald,2);
disp('      Wald      Pval')
disp([wald pval])
%% 2-year MA
% I uses 252 days as 1 year when computing the MA.
%%
for t=T12+1:T
    ht_forecast(t) = mean(r(t-(1:(2*252))).^2);
end

h_oos = ht_forecast(T12+1:end);
h_oos_ma = h_oos;
std_oos = r_oos ./ sqrt(h_oos);

y = r_oos.^2 - h_oos;
x = h_oos;
[b,~,~,~,vcv_white] = ols(y,x,1);
wald = b' * inv(vcv_white) * b;
pval = 1 - chi2cdf(wald,2);
disp('MZ')
disp('      Wald      Pval')
disp([wald pval])

y = std_oos.^2 - 1;
x = 1./h_oos;
[b,tstat,s2,~,vcv_white] = ols(y,x,1);
wald = b' * inv(vcv_white) * b;
pval = 1 - chi2cdf(wald,2);
disp('MZ-GLS')
disp('      Wald      Pval')
disp([wald pval])
%% MZ-GLS with bad models
% While both rejected in the MA model, the rejection for the GLS version was 
% weaker. This is driven by the fact that the variances used in the GLS are from 
% the model, and so if the MA is wrong, then the variance are also wrong. Using 
% the TARCH variances, which are much closer to being correct, produces a string 
% rejection.
%%
y = (r_oos.^2 - h_oos)./h_oos_tarch;
x = 1./h_oos_tarch;
[b,tstat,s2,~,vcv_white] = ols(y,x,1);
wald = b' * inv(vcv_white) * b;
pval = 1 - chi2cdf(wald,2);
disp('MZ-GLS')
disp('      Wald      Pval')
disp([wald pval])
%% Diebold Mariano
% Relative performance is accessed using Diebold-Mariano tests based on the 
% QLIK loss function. The loss differences are regressed on a constant using Newey-West 
% errors. The negative value indicated that A is better than B -- TARCH is better 
% than MA.
%%
la = r_oos.^2./h_oos_tarch + log(h_oos_tarch);
lb = r_oos.^2./h_oos_ma + log(h_oos_ma);

[dm,tstat] = olsnw(la-lb,[],1)