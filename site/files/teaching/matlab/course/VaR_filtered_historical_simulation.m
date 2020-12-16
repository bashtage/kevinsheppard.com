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
% Load the data and compute returns
%%
load sp500
rets = diff(log(sp500));
%% Estimate the Volatilty
% Here I use a TARCH(1,1,1) model which has been found to work well for the 
% S&P 500. In this task, I am "cheating" since I am not going to use true out-of-sample 
% volatility in my FHS VaR
%%
[~,~,ht] = tarch(rets,1,1,1);
std_rets = rets ./ sqrt(ht);
%% FHS VaR
% The FHS VaR is simply the unconditional quantile at any point in time of the 
% standardized returns, which is then scaled back by the forecast volatility. 
% Here I am "cheating" and using ht(t+1) as the forecast which is really the in-sample 
% fit value.
%%
% Data length and place holders
T = length(rets);
FHS_forecast_05 = nan(T,1);
FHS_forecast_01 = nan(T,1);
% Iterate through the time series.  The forecast for t+1 is stored in t
for t = ceil(T*.25):(T-1)
    FHS_forecast_05(t) = sqrt(ht(t+1)) * quantile(std_rets(1:t),.05);
    FHS_forecast_01(t) = sqrt(ht(t+1)) * quantile(std_rets(1:t),.01);
end
 
sp500_VaR = [FHS_forecast_05 FHS_forecast_01];
%% Plotting
% This plot shows the returns, the FHS VaR and the HITs, which have been scaled 
% to match the returns that caused the HIT. The non-HITs are removed from the 
% graph by setting their values to nan. While this isn't a test, the HITs appear 
% to be uniformly distributed in time, and there are HITs even in the low volatility 
% periods.
%%
dates = mldates(2:end);
% 5% VaR
figure()
hit05 = rets(2:end)<FHS_forecast_05(1:end-1);
scaled_hit = hit05.*rets(2:end);
scaled_hit(~hit05) = nan;
h = plot(dates,rets,dates,FHS_forecast_05,dates(2:end),scaled_hit);
set(h(1),'Color',[.9 .9 .9])
set(h(2),'Color',[.0 0 .6],'LineWidth',3)
set(h(3),'LineStyle','none','Marker','.')
title('5% FHS VaR Hits')
axis tight
datetick('x','keeplimits')
 
% 1% VaR
figure()
hit01 = rets(2:end)<FHS_forecast_01(1:end-1);
scaled_hit = hit01.*rets(2:end);
scaled_hit(~hit01) = nan;
h = plot(dates,rets,dates,FHS_forecast_01,dates(2:end),scaled_hit);
set(h(1),'Color',[.9 .9 .9])
set(h(2),'Color',[0 0 .6],'LineWidth',3)
set(h(3),'LineStyle','none','Marker','.')
axis tight
title('1% FHS VaR Hits')
datetick('x','keeplimits')

sp500_FHS_VaR = [FHS_forecast_05 FHS_forecast_01];
%% EURUSD
% The results for the EURUSD rate are broadly the same, with seemingly regular 
% HITs throughout the sample
%%
% Load the data
load eurusd
rets = diff(log(eurusd));
%% Estimate the Volatilty
% Here I use a TARCH(1,0,1) model which has been found to work well for the 
% S&P 500. In this task, I am "cheating" since I am not going to use true out-of-sample 
% volatility in my FHS VaR.
%%
[~,~,ht] = tarch(rets,1,0,1);
std_rets = rets ./ sqrt(ht);
 
% Format the FHS series
T = length(rets);
FHS_forecast_05 = nan(T,1);
FHS_forecast_01 = nan(T,1);
% Iterate through the time series.  The forecast for t+1 is stored in t
for t = ceil(T*.25):(T-1)
    FHS_forecast_05(t) = sqrt(ht(t+1)) * quantile(std_rets(1:t),.05);
    FHS_forecast_01(t) = sqrt(ht(t+1)) * quantile(std_rets(1:t),.01);
end
 
% Adjust the dates
dates = mldates(2:end);
%% Plotting
% These plots are similar to the S&P 500, only easier to see due to the shorter 
% sample.
%%
% 5% VaR
figure()
hit05 = rets(2:end)<FHS_forecast_05(1:end-1);
scaled_hit = hit05.*rets(2:end);
scaled_hit(~hit05) = nan;
h = plot(dates,rets,dates,FHS_forecast_05,dates(2:end),scaled_hit);
set(h(1),'Color',[.9 .9 .9])
set(h(2),'Color',[.0 0 .6],'LineWidth',3)
set(h(3),'LineStyle','none','Marker','.')
title('5% FHS VaR Hits  (EURUSD)')
axis tight
datetick('x','keeplimits')
 
 
% 1% VaR
figure()
hit01 = rets(2:end)<FHS_forecast_01(1:end-1);
scaled_hit = hit01.*rets(2:end);
scaled_hit(~hit01) = nan;
h = plot(dates,rets,dates,FHS_forecast_01,dates(2:end),scaled_hit);
set(h(1),'Color',[.9 .9 .9])
set(h(2),'Color',[.0 0 .6],'LineWidth',3)
set(h(3),'LineStyle','none','Marker','.')
axis tight
title('1% FHS VaR Hits (EURUSD)')
datetick('x','keeplimits')

eurusd_FHS_VaR = [FHS_forecast_05 FHS_forecast_01];
    
save FHS_VaR *_FHS_VaR