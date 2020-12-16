%% Historical Value-at-Risk Forecasting
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
%% HS VaR
% The HS VaR is simply the unconditional quantile at any point in time. The 
% is computed using the MATLAB function quantile here.
%%
% Data length and place holders
T = length(rets);
HS_forecast_05 = nan(T,1);
HS_forecast_01 = nan(T,1);
% Iterate through the time series.  The forecast for t+1 is stored in t
for t = ceil(T*.25):T
    HS_forecast_05(t) = quantile(rets(1:(t-1)),.05);
    HS_forecast_01(t) = quantile(rets(1:(t-1)),.01);
end
 
sp500_HS_VaR = [HS_forecast_05 HS_forecast_01];
%% Plotting
% This plot shows the returns, the HS VaR and the HITs, which have been scaled 
% to match the returns that caused the HIT. The non-HITs are removed from the 
% graph by setting their values to 0. While this isn't a test, the HITs appear 
% to be very clustered in both figures (as evidenced by large periods with no 
% HITs).
%%
dates = mldates(2:end); 
% 5% VaR
figure()
hit05 = rets(2:end)<HS_forecast_05(1:end-1);
scaled_hit = hit05.*rets(2:end);
scaled_hit(~hit05) = nan;
h = plot(dates,rets,dates,HS_forecast_05,dates(2:end),scaled_hit);
set(h(1),'Color',[.9 .9 .9])
set(h(2),'Color',[.0 0 .6],'LineWidth',3)
set(h(3),'LineStyle','none','Marker','.')
title('5% HS VaR Hits')
axis tight
datetick('x','keeplimits')
 
% 1% VaR
figure()
hit01 = rets(2:end)<HS_forecast_01(1:end-1);
scaled_hit = hit01.*rets(2:end);
scaled_hit(~hit01) = nan;
h = plot(dates,rets,dates,HS_forecast_01,dates(2:end),scaled_hit);
set(h(1),'Color',[.9 .9 .9])
set(h(2),'Color',[0 0 .6],'LineWidth',3)
set(h(3),'LineStyle','none','Marker','.')
axis tight
title('1% HS VaR Hits')
datetick('x','keeplimits')
%% EURUSD
% The results for the EURUSD rate are broadly the same, with a large period 
% with effectively no hits prior to the financial crisis
%%
% Load the data
load eurusd
rets = diff(log(eurusd));
% Format the HS series
T = length(rets);
HS_forecast_05 = nan(T,1);
HS_forecast_01 = nan(T,1);
% Use quantile and iterate across sample
for t = ceil(T*.25):T
    HS_forecast_05(t) = quantile(rets(1:(t-1)),.05);
    HS_forecast_01(t) = quantile(rets(1:(t-1)),.01);
end
 
% Adjust the dates
dates = mldates(2:end);
%% Plotting
% These plots are similar to the S&P 500, only easier to see due to the shorter 
% sample.
%%
% 5% VaR
figure()
hit05 = rets(2:end)<HS_forecast_05(1:end-1);
scaled_hit = hit05.*rets(2:end);
scaled_hit(~hit05) = nan;
h = plot(dates,rets,dates,HS_forecast_05,dates(2:end),scaled_hit);
set(h(1),'Color',[.9 .9 .9])
set(h(2),'Color',[.0 0 .6],'LineWidth',3)
set(h(3),'LineStyle','none','Marker','.')
title('5% HS VaR Hits  (EURUSD)')
axis tight
datetick('x','keeplimits')
 
 
% 1% VaR
figure()
hit01 = rets(2:end)<HS_forecast_01(1:end-1);
scaled_hit = hit01.*rets(2:end);
scaled_hit(~hit01) = nan;
h = plot(dates,rets,dates,HS_forecast_01,dates(2:end),scaled_hit);
set(h(1),'Color',[.9 .9 .9])
set(h(2),'Color',[.0 0 .6],'LineWidth',3)
set(h(3),'LineStyle','none','Marker','.')
axis tight
title('1% HS VaR Hits (EURUSD)')
datetick('x','keeplimits')


eurusd_HS_VaR = [HS_forecast_05 HS_forecast_01];
    
save HS_VaR *_HS_VaR