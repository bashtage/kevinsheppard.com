%% Estimating Vector Autoregressions
% This task shows how to estimate a VAR(1) for three series.
%% Prepare the workspace
% Clean up before starting
%%
clear all
close all
clc
%% Load the data
% The data was prepared in the time_series_data file, including transforming 
% GDPDEF to be a growth rate. The data is standardized to make the magnitudes 
% more comparable.
%%
load VAR_data
var_data = VAR_data.Variables
std_data = bsxfun(@rdivide,var_data,std(var_data));
%% Basic IR - Uncorrelated Errors
% The basic IR assumes shocks are uncorrelated but are scaled by the estimated 
% standard deviation. The patters is complex with feedback across all series, 
% although the cross 0-lags are all 0 due to the assumption of 0 correlation.
%%
impulseresponse(std_data,1,1:2,24)
%% Choleski
% The Choleski is an alternative which orders series so that earlier series 
% immediately cause later series by not the reverse. Note the changes in the 0-lag 
% impulse of y_2 and y_3 (which are GS1 and GS10)
%%
[~,~,h]=impulseresponse(std_data,1,1:2,24,2);
 
plots = get(h,'Children');
set(get(plots(9),'YLabel'),'String','GDPDEF Growth')
set(get(plots(6),'YLabel'),'String','GS1')
set(get(plots(3),'YLabel'),'String','GS10')
%% Reodered Choleski
% Reordering the series and using the Choleski produces different IRs. The code 
% below replaces the labels to make the more meaningful.
%%
[~,~,h] = impulseresponse(std_data(:,[2,3,1]),1,1:2,24,2);
 
plots = get(h,'Children');
set(get(plots(9),'YLabel'),'String','GS1')
set(get(plots(6),'YLabel'),'String','GS10')
set(get(plots(3),'YLabel'),'String','GDPDEF Growth')
%% Generalized IR
% The generalized IR reorders the series so each is first in a Choleski, is 
% an an alternative to choosing one to be first. 
%%
[~,~,h]=impulseresponse(std_data(:,[2,3,1]),1,1:2,24,4);
 
plots = get(h,'Children');
set(get(plots(9),'YLabel'),'String','GDPDEF Growth')
set(get(plots(6),'YLabel'),'String','GS1')
set(get(plots(3),'YLabel'),'String','GS10')
%% Other questions
% Since earlier series affect later ones, GDP deflator should probably be last 
% since it is a price series. On the other hand, GS1 and GS10 are both financial 
% and there is no obvious ordering.