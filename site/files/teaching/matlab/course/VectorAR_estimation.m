%% Estimating Vector Autoregressions
% This task shows how to estimate a VAR(1) for three series.
 
%% Prepare the workspace
% Clean up before starting
clear all
close all
clc
 
%% Load the data
% The data was prepared in the time_series_data file, including
% transofrming GDPDEF to be a growth rate.
load VAR_data
 
%% Estimate a VAR(1)
% The function used is vectorar which takes the matrix of data, an 0/1
% variable for the constant and the lags.  The output is a cell array
% containing the matrix of parameters at different lags.
%
% The first three outputs are the parameters, their standard errors and
% their t-stats.
%
% The maximum eigenvalue of the VAR(1) parameter matrix is the measure of
% the persistence.  In higher order VARs, a companion form is needed to
% compute this value.
 
[parameters,stderr,tstats] = vectorar(VAR_data(:,2:4),1,1);
disp(parameters{1})
disp(stderr{1})
disp(tstats{1})
 
% Display the parameters
series = {'GDPDEF growth','1 Year','10 Year'};
for i=1:3
    disp(['For series: ' series{i}])
    str = [];
    for j=1:3
        str = [str ' '  num2str(parameters{1}(i,j)) ' * '  series{j} ',']; %#ok<*AGROW>
    end
    disp(str)
end
% Display the maximum eigenvalue, which measure the persistence
disp('Persistence')
disp(max(eig(parameters{1})))
 
%% Standardized Data
% When data have very different scales, rescaling the data to have common
% standard deviations makes the lag parameters more interpretable.
%
% Note that the eigenvalue does not change.
 
VAR_data_std = bsxfun(@rdivide,VAR_data(:,2:4),std(VAR_data(:,2:4)));
[parameters,stderr,tstats] = vectorar(VAR_data_std,1,1);
disp(parameters{1})
disp(stderr{1})
disp(tstats{1})
 
for i=1:3
    disp(['For series: ' series{i}])
    str = [];
    for j=1:3
        str = [str ' ' num2str(parameters{1}(i,j)) ' * '  series{j} ','];
    end
    disp(str)
end
 
disp('Persistence')
disp(max(eig(parameters{1})))


