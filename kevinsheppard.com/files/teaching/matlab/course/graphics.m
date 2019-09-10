%% Graphics
%% Reset the workspace
% Start with a clear workspace
%%
clear all
close all
clc
rng('default')
%% Load the data
%%
load hf
%% 
% 
%%
figure()
plot(IBMprices)
ylabel('Price')
xlabel('Observation')
title('IBM Price')
%% 
% 
%%
figure()
plot(IBM.price,'r.')
ylabel('Price')
xlabel('Observation')
title('IBM Price')
%% Subplots
%%
figure()
subplot(2,1,1)
plot(IBM.price,'r.')
title('IBM Price')
subplot(2,1,2)
plot(MSFT.price,'bx')
title('MSFT Price')
%% Dates using MATLAB dates
%%
figure()
plot(IBMtimes,IBMprices)
datetick('x')
%% Dates using data in tables
%%
figure()
subplot(2,1,1)
plot(IBM.time, IBM.price)
title('IBM Price')
subplot(2,1,2)
plot(MSFT.time, MSFT.price)
title('MSFT Price')
%% Histogram
%%
figure()
MSFT_ret = diff(log(MSFT.price));
hist(MSFT_ret,100)
title('MSFT high-frequency returns')