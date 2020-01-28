%% ARMA Residual Diagnostics
%% Clear the environment
% It is a good idea to clear all variables and close all figures before proceeding
%%
clear all
close all
clc
%% Load the data
% The next step is to load the data. 
%%
load term
%% Model
% I chose an ARMA(1,1) since it fit well and was selected by BIC
%%
% Estimate the model
[parameters, ll, errors] = armaxfilter(term,1,1,1);
disp('Parameters')
disp(parameters)
% Standardized errors are simpler to use since they are scale free
stderrors = errors / std(errors);
%% ACF/PACF plots of the residuals
% The first step is to check the residuals for evidence of autocorrelation. 
% Normally it is necessary to go beyond the lag length used since the estimation 
% will try and make the autocorrelations 0 up to the selected lag-length, and 
% so these can be deceptive. 
%%
% Open a figure
figure()
% Plot the errors
plot(stderrors)
% Plot the SACF
sacf(stderrors,24)
% Plot thr SPACF
spacf(stderrors,24)
%% Ljung-Box and LM Test
% The LJ and LM test look at multiple correlations simultaneously. These results 
% output the test statistic and 100 x the p-value. The LM indicates rejection 
% at longer lags, while the LM cannot reject (large p-vals over 5%).
%%
disp('Lung-Box Test (Test stat, 100x p-value)' )
[ts,pv]=ljungbox(stderrors,12);
disp([ts,100*pv])
disp('LM Test (Test stat, 100x p-value)' )
[ts,pv]=lmtest1(stderrors,12);
disp([ts,100*pv])
%% Random Walk Model
% There is no need to estimate a model here since it is simple.
%%
% Errors are just difference
errors = diff(term);
% Standardized errors are simpler to use since they are scale free
stderrors = errors / std(errors);
% Open a figure
figure()
% Plot the errors
plot(stderrors)
% Plot the SACF
sacf(stderrors,24)
% Plot thr SPACF
spacf(stderrors,24)
%% Ljung-Box and LM Test
% The LJ and LM test look at multiple correlations simultaneously. These results 
% output the test statistic and 100 x the p-value. Both tests reject strongly 
% - probably due ot the missing MA component.
%%
disp('Lung-Box Test (Test stat, 100x p-value)' )
[ts,pv]=ljungbox(stderrors,12);
disp([ts,100*pv])
disp('LM Test (Test stat, 100x p-value)' )
[ts,pv]=lmtest1(stderrors,12);
disp([ts,100*pv])