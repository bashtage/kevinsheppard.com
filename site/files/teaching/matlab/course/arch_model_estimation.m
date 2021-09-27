%% ARCH Model Estimation
% This task shows how to estimate GARCH models and provides some
% description of common features of models and parameters

%% Prepare the workspace
% Clean up before starting
clear all
close all
clc

%% S&P 500: Data and Returns
% Start by loading the data and constructing returns.  It is usually a good
% idea to use 100 * returns which helps numerical stability
load sp500

ret = 100 * diff(log(sp500));
rdates = mldates(2:end);
%% Estimation
% ARCH, GARCH, GJR-GARCH and TARCH models are all estimated using _tarch_
[g11_p, g11_ll, g11_ht] = tarch(ret,1,0,1);
[gjr_p, gjr_ll, gjr_ht, gjr_vcvr, gjr_vcv] = tarch(ret,1,1,1);
%% Parameters
% The parameters show the asymmetry (gamma is in position 3 of the GJR
% parameters).  The loglikelihood also prefers the GJR model strongly.
disp('GARCH parameters')
disp(g11_p)
disp('GJR-GARCH parameters')
disp(gjr_p)
disp('GARCH  GJR Loglikelihoods')
disp([g11_ll gjr_ll])

%% T-stats
% There are large differences in the magnitudes of the t-stats which
% reflects the non-normality in the standardized S&P 500 residuals
disp('Non-robust   Robust T-stats')
disp([gjr_p./sqrt(diag(gjr_vcv)) gjr_p./sqrt(diag(gjr_vcvr))])
%% Volatility
% This figure contains the annualized volatilities from the two models
% which are very similar (but not identical).  The returns, scaled by
% sqrt(252) to make them comparable, are also plotted in the background 
% for comparison.
figure()
h = plot(rdates,sqrt(252)*ret,rdates,sqrt(252*g11_ht),rdates,sqrt(252*gjr_ht),rdates,zeros(size(rdates)));
set(h(1),'Color',[.8 .8 .8],'LineStyle','none','Marker','.')
set(h(2),'Color',[.8 0 0],'LineWidth',2)
set(h(3),'Color',[0 .8 0],'LineWidth',2)
set(h(4),'Color',[0 0 0],'LineWidth',2)
legend('Absolute S&P 500 return (Scaled)','GARCH (Ann Vol)','GJR (Ann Vol)','Location','SouthWest')
axis tight
ax = axis;
ax(4) = 2 * max(max([sqrt(252*g11_ht) sqrt(252*gjr_ht)]));
ax(3) = -2 * max(max([sqrt(252*g11_ht) sqrt(252*gjr_ht)]));
axis(ax)
datetick('x','keeplimits')
%% Standardized Residuals
% The standardized residuals are plotted as a kernel density plot and are
% compared to a standard normal.
figure()
std_ret = [ret ret]./sqrt([g11_ht gjr_ht]);
[~,y1,x1] = pltdens(std_ret(:,1));
y1_0 = normpdf(x1);
[~,y2,x2] = pltdens(std_ret(:,2));
y2_0 = normpdf(x1);
subplot(2,1,1)
h = plot(x1,y1,x1,y1_0);
set(h(1),'Color',[.8 0 0],'LineWidth',2)
set(h(2),'Color',[0 0 0])
axis tight
legend('GARCH(1,1) std residuals','Std Normal','Location','SouthWest')
subplot(2,1,2)
h = plot(x2,y2,x2,y2_0);
legend('GJR-GARCH(1,1,1) std residuals','Location','SouthWest')
set(h(1),'Color',[0 .6 0],'LineWidth',2)
set(h(2),'Color',[0 0 0])
axis tight


%% USD/EUR: Data and Returns
% This component repeats the previous exercise only for the USD/EUR rate.
% There are some important differences:
%
% * There is little evidence of asymmetry
% * The level of volatility is much lower
% * Volatility is less responsive as measured by the alpha

%% Load Data
% The data is similarly loaded and scaled
load eurusd

ret = 100 * diff(log(eurusd));
rdates = mldates(2:end);
%% Estimation
% This code is identical 
[g11_p, g11_ll, g11_ht] = tarch(ret,1,0,1);
[gjr_p, gjr_ll, gjr_ht, gjr_vcvr, gjr_vcv] = tarch(ret,1,1,1);
%% Parameters
% There is little evidence of asymmetry in the exchange rate, and it is
% much less responsive.  Its volatility, however, is still very persistent.
disp('GARCH parameters')
disp(g11_p)
disp('GJR-GARCH parameters')
disp(gjr_p)
disp('GARCH  GJR Loglikelihoods')
disp([g11_ll gjr_ll])

%% T-stats
% The t-stats differ, but by less than in the S&P 500 example.  This is due
% to the standardized residuals being more normal-like.
disp('Non-robust   Robust T-stats')
disp([gjr_p./sqrt(diag(gjr_vcv)) gjr_p./sqrt(diag(gjr_vcvr))])


%% Volatility
% This figure contains the annualized volatilities from the two models
% which are very similar (but not identical).  The returns, scaled by
% sqrt(252) to make them comparable, are also plotted in the background 
% for comparison.  
%
% The volatility of the USD/EUR rate is much lower and clearly less
% responsive to news.
figure()
h = plot(rdates,sqrt(252)*ret,rdates,sqrt(252*g11_ht),rdates,sqrt(252*gjr_ht),rdates,zeros(size(rdates)));
set(h(1),'Color',[.8 .8 .8],'LineStyle','none','Marker','.')
set(h(2),'Color',[.8 0 0],'LineWidth',2)
set(h(3),'Color',[0 .8 0],'LineWidth',2)
set(h(4),'Color',[0 0 0],'LineWidth',2)
legend('Absolute USD/EUR return (Scaled)','GARCH (Ann Vol)','GJR (Ann Vol)','Location','SouthWest')
axis tight
ax = axis;
ax(4) = 2 * max(max([sqrt(252*g11_ht) sqrt(252*gjr_ht)]));
ax(3) = -2 * max(max([sqrt(252*g11_ht) sqrt(252*gjr_ht)]));
axis(ax)
datetick('x','keeplimits')


%% Standardized Residuals
% The standardized residuals are plotted as a kernel density plot and are
% compared to a standard normal.  While still not normal, these
% standardized residuals are less heavy tailed and not noticeably skewed.
figure()
std_ret = [ret ret]./sqrt([g11_ht gjr_ht]);
[~,y1,x1] = pltdens(std_ret(:,1));
y1_0 = normpdf(x1);
[~,y2,x2] = pltdens(std_ret(:,2));
y2_0 = normpdf(x1);
subplot(2,1,1)
h = plot(x1,y1,x1,y1_0);
set(h(1),'Color',[.8 0 0],'LineWidth',2)
set(h(2),'Color',[0 0 0])
axis tight
legend('GARCH(1,1) std residuals','Std Normal','Location','SouthWest')
subplot(2,1,2)
h = plot(x2,y2,x2,y2_0);
legend('GJR-GARCH(1,1,1) std residuals','Location','SouthWest')
set(h(1),'Color',[0 .6 0],'LineWidth',2)
set(h(2),'Color',[0 0 0])
axis tight
