%% ARMA Forecasting
%% Clear the environment
% It is a good idea to clear all variables and close all figures before proceeding
%%
clear all
close all
clc
%% Load the data
% The next step is to load the data. The next two lines set the maximum AR and 
% MA lags.
%%
load term
%% Parameter Estimation
% Only the first 50% of the data is used for estimation.  _T50_ is used to indicate 
% the index of the point. The full-sample parameters, as well as the 2nd half 
% parameters, are also estimated. There is a non-trivial change in the parameters, 
% and in particular the AR parameter changes substantially between the first half 
% and the 2nd half.
%%
T50 = floor(length(term)/2);
parameters_full = armaxfilter(term,1,1,1);
parameters = armaxfilter(term(1:T50),1,1,1);
parameters_2nd_half  = armaxfilter(term(T50+1:end),1,1,1);

disp('    Full      Correct   2nd half')
disp([parameters_full parameters parameters_2nd_half])
%% Forecasts
% The forecasts are produced using _arma_forecaster_ which takes the data, parameters, 
% model configuration, starting point and horizon
% 
% |  arma_forecaster(y,parameters,const,p,q,in_sample,h)|
%%
% h=1 case
h = 1;
[forecast_arma_h1,~,fe_arma_h1] = arma_forecaster(term,parameters,1,1,1,T50,h);
% Use a 'trick' to produce the RW forecasts
[forecast_rw_h1,~,fe_rw_h1] = arma_forecaster(term,1,0,1,0,T50,h);
% h=3 case
h = 3;
[forecast_arma_h3,~,fe_arma_h3] = arma_forecaster(term,parameters,1,1,1,T50,h);
% Use the same 'trick' to produce the RW forecasts
[forecast_rw_h3,~,fe_rw_h3] = arma_forecaster(term,1,0,1,0,T50,h);
%% Forecast Errors
% A simple plot can often show problems - in this case, neither forecast error 
% series looks like white noise.
%%
% Use the errors and forecasts from arma_forecaster
errors = [fe_arma_h1 fe_rw_h1];
forecasts = [forecast_arma_h1 forecast_rw_h1];
% NaNs appear where forecasts are not valid
valid = all(~isnan(errors),2);
errors = errors(valid,:);
forecasts = forecasts(valid,:);
% Standardize for plotting
std_forecast_errors = bsxfun(@rdivide,errors,std(errors));
% Plot
figure()
plot(std_forecast_errors)
legend('ARMA Errors','RW Errors')
title('Standardized Forecast Errors')
%% MZ Regressions
% MA regressions regress the realizeation on forecast and a constant. The null 
% here is that the intercept is 0 and the slope is 1. An alternative and equivalent 
% formulation is to regress the error on the forecast and a constant, and the 
% null is now that all parameters are 0.
%%
% Model names
models = {'ARMA','RW'};
for i=1:2
    % Show name
    disp(['Model: ' models{i}])
    % Setup X and y
    y = errors(:,i);
    X = forecasts(:,i);
    % Run regression, plain OLS with white errors
    [beta,~,~,~,vcv_white] = ols(y,X,1);
    % Display parameters and t-stats
    disp('    Parames   T-stats')
    disp([beta beta./sqrt(diag(vcv_white))]);
    % Display wald tests - note no subtraction since null value is 0
    disp('Wald Stat')
    disp(beta'*inv(vcv_white)*beta)
    disp('P-value (Wald)')
    disp(1-chi2cdf(beta'*inv(vcv_white)*beta,2))
end
%% Serial Correlation Tests
% Serial correlation in 1-step ahead forecast errors is also a sign of issues. 
% Here a LM test is used to test for serial correlation - both series reject, 
% with the RW rejecting badly for all lags.
%%
for i=1:2
    disp(['Model: ' models{i}])
    disp(models{i})
    y = errors(:,i);
    [lm,pval] = lmtest1(y,10);
    disp('   LM test    P-val (x100)')
    disp([lm 100*pval])
end
%% ACF/PACF
% ACF and PACF plots are useful for inspecting the source of the problem.
%%
for i=1:2
    y = errors(:,i);
    sacf(y,12,[],0)
    title([models{i} ' SACF'])
    spacf(y,12)
    title([models{i} ' SPACF'])
end
%% Diebold Mariano: MSE
% DM tests use the squarred errors and a OLS regression with NW errors. Positive 
% indicate the left (ARMA) model is rejected, negative indicate the right (RW) 
% model is rejected.
%%
[dm,~,~,vcvnw]=olsnw(errors(:,1).^2 - errors(:,2).^2,[],1);
disp('DM , MSE (+ prefers RW, - prefers ARMA), h=1')
disp(dm./sqrt(vcvnw))
%% Diebold Mariano: MAE
% MAE replaces the square with absolute value, but is otherwise identical
%%
[dm,~,~,vcvnw]=olsnw(abs(errors(:,1)) - abs(errors(:,2)),[],1);
disp('DM, MAE (+ prefers RW, - prefers ARMA), h=1')
disp(dm./sqrt(vcvnw))
%% Multi-step forcasts
% Multi-step is virtually identical except that some serial correlation, up 
% to h-1, is expected.
%%
h = 3;
errors = [fe_arma_h3 fe_rw_h3];
valid = all(~isnan(errors),2);
errors = errors(valid,:);
std_errors = bsxfun(@rdivide,errors,std(errors));
figure()
plot(std_errors)
legend('ARMA Errors','RW Errors')
title('Standardized Forecast Errors (h=3)')
%% Diebold Mariano: MSE, h=3
% Same proceedure for any h
%%
[dm,~,~,vcvnw]=olsnw(errors(:,1).^2 - errors(:,2).^2,[],1);
disp('DM, MSE (+ prefers RW, - prefers ARMA), h=3')
disp(dm./sqrt(vcvnw))
%% Diebold Mariano: MAE, h=3
% Same proceedure for any h
%%
[dm,~,~,vcvnw]=olsnw(abs(errors(:,1)) - abs(errors(:,2)),[],1);
disp('DM, MAE (+ prefers RW, - prefers ARMA), h=3')
disp(dm./sqrt(vcvnw))
%% Forecasting with look-ahead bias
% Look-ahead bias refers to using parameters which are estiamted using the full-sample. 
% test statistics are vast improved - although this could never be accomplished 
% in practice.
%%
% Same as before, only using parameters_full
[forecasts,~,errors] = arma_forecaster(term,parameters_full,1,1,1,T50,1);
valid = all(~isnan(errors),2);
errors = errors(valid,:);
forecasts = forecasts(valid,:);
% Look-ahead MZ regression
[beta,~,~,~,vcv_white] = ols(errors,forecasts,1);
disp('    Parames   T-stats')
disp([beta beta./sqrt(diag(vcv_white))]);
disp('Wald Stat')
disp(beta'*inv(vcv_white)*beta)
disp('P-value (Wald)')
disp(1-chi2cdf(beta'*inv(vcv_white)*beta,2))
%% "Forecasting" by cheating
% Cheating is using only the out-of-sample to forecast. Since the objective 
% function minimizes the SSE, it is no suprise that the test statistic is tiny.
%%
% Use the 2nd half parameters
[forecasts,~,errors] = arma_forecaster(term,parameters_2nd_half,1,1,1,T50,1);
valid = all(~isnan(errors),2);
errors = errors(valid,:);
forecasts = forecasts(valid,:);
[beta,~,~,~,vcv_white] = ols(errors,forecasts,1);
disp('    Parames   T-stats')
disp([beta beta./sqrt(diag(vcv_white))]);
disp('Wald Stat')
disp(beta'*inv(vcv_white)*beta)
disp('P-value (Wald)')
disp(1-chi2cdf(beta'*inv(vcv_white)*beta,2))