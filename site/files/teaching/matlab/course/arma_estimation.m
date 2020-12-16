%% ARMA Estimation
% This assignment introduces basic estimation of ARMA models. This code, along 
% with most of the remainder of the course, uses the Oxford MFE toolbox which 
% needs to be downloaded, extracted to a folder and then added to the MATLAB path.
%% Load the data
% See the file time_series_data for the construction of the data sets used in 
% the time series portion of the course
%%
load term
%% AR(1) Estimation
% The main function to estimate ARMA models is _armaxfilter_. The inputs are 
% an indicator variable for a constant (True/False or 1/0) and the lags to include.
% 
% The basic use is 
% 
% |armaxfilter(y, const, ar, ma)|
% 
% where const is boolean and ar and ma are vectors of lags to include.
% 
% See
% 
% |help armaxfilter|
% 
% for more on the use of _armaxfilter_
%%
[parameters, ~, ~, ~, ~, vcv_robust, vcv] = armaxfilter(term, 1, 1);
disp(parameters)
disp([sqrt(diag(vcv)) sqrt(diag(vcv_robust))])
%% MA(5) Estimation
% When using more than one lag, the estimation function requires the indices 
% of the lags. This allows models to be constructed that skip lags (e.g. lags 
% 1, 4, and 12 are included, but not other values < 12). The [] in the _ar_ position 
% indicates that no AR lags should be included.
%%
[parameters, ~, ~, ~, ~, vcv_robust, vcv] = armaxfilter(term, 1, [], 1:5);
disp(parameters)
disp([sqrt(diag(vcv)) sqrt(diag(vcv_robust))])
%% ARMA(1,1) Estimation
% ARMA(1,1) estimation combines the two inputs.
%%
[parameters, ~, ~, ~, ~, vcv_robust, vcv] = armaxfilter(term, 1, 1, 1);
disp(parameters)
disp([sqrt(diag(vcv)) sqrt(diag(vcv_robust))])