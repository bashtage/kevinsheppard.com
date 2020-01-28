%% ARMA - Unit Root Testing
% Unit roots are common in economic time series, and when modeling a time series, 
% it is necessary to difference until the series is stationary.
%% Clean Up
% Clean up the environment before starting
%%
clear all
close all
clc
%% Load the data
% Load the default premium data and the CPI data
%%
load def
defdates = mldates;
load cpi
cpidates = mldates;
%% Plot
% Start by plotting the data using a series of subplots
%%
figure();
X={defdates,defdates(2:end),cpidates,cpidates(13:end)};
Y = {def, diff(def), log(cpi), log(cpi(13:end)./cpi(1:end-12))};
titles = {'Default Premium','Diff of Default Prem','Log CPI','Annual Inflation'};
for i=1:4
    subplot(2,2,i)
    plot(X{i},Y{i})
    axis tight
    title(titles{i})
    datetick('x','keeplimits')
end
%% ADF Testing
% The main test for unit roots is the Augmented Dickey-Fuller (ADF). This code 
% uses _adfautolag_ which will use AIC or BIC to select the lag length in the 
% ADF. The values returned are the test statistic (which is just a t-stat), it's 
% pval (which is not from a normal), and critical values.
%% Default Premium
% The level of the default premium just rejects for any reasonable lag length 
% selection, or for either no deterministic or an intercept (which means a trend 
% in the original data).
%%
[ts, pv, cv] = augdfautolag(def,0,20);
disp('Default Premium')
disp('Levels')
disp('    T-stat    Pval (Lag = Auto (AIC), No Deterministic)')
disp([ts,pv]);

disp('    T-stat    Pval (Lag = 1, No Deterministic)')
[ts, pv] = augdf(def,0,1);
disp([ts,pv]);

disp('    T-stat    Pval (Lag = Auto (BIC), No Deterministic)')
[ts, pv] = augdfautolag(def,0,20,'BIC');
disp([ts,pv]);

disp('    T-stat    Pval (Lag = Auto (BIC), Intercept)')
[ts, pv] = augdfautolag(def,1,20,'BIC');
disp([ts,pv]);

disp('Default Premium')
disp('Differences')
disp('    T-stat    Pval (Lag = Auto (AIC), No Deterministic)')
[ts, pv] = augdfautolag(diff(def),0,20);
disp([ts,pv]);
%% CPI
% Log CPI is clearly trending, so it is tested with both an intercept and an 
% intercept and a trend. The intercept and trend nearly reject, which would mean 
% ln CPI would be a pure time-driven process (plus possibly stationary component)
%%
disp('Log CPI')
disp('Levels')
disp('    T-stat    Pval (Lag = Auto (AIC), Intercept & Trend)')
[ts, pv] = augdfautolag(log(cpi),2,20);
disp([ts,pv]);

disp('    T-stat    Pval (Lag = Auto (AIC), Intercept)')
[ts, pv] = augdfautolag(log(cpi),1,20);
disp([ts,pv]);
%% Inflation
% Inflation is the difference of log CPI. Inflation also appears to have a unit 
% root, and so ln CPI might be I(2).
%%
disp('Inflation')
disp('Diff of Log CPI')
inflation = diff(log(cpi));
disp('    T-stat    Pval (Lag = Auto (AIC), Intercept)')
[ts, pv] = augdfautolag(inflation,1,20);
disp([ts,pv]);
disp('    T-stat    Pval (Lag = Auto (AIC), No Deterministic)')
[ts, pv] = augdfautolag(inflation,0,20);
disp([ts,pv]);
%% Inflation Difference
% The change in inflation is clearly stationary.
%%
disp('Diff of Diff of Log CPI')
disp('Diff of Inflation')
disp('    T-stat    Pval (Lag = Auto (AIC), No Deterministic)')
[ts, pv] = augdfautolag(diff(inflation),0,20);
disp([ts,pv]);