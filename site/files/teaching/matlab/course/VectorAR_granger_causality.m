%% Estimating Vector Autoregressions
% This task shows how to estimate a VAR(1) for three series.
%% Prepare the workspace
% Clean up before starting
%%
clear all
close all
clc
%% Load the data
% The data was prepared in the time_series_data file, including transofrming 
% GDPDEF to be a growth rate.
%%
load VAR_data
var_data = VAR_data.Variables
%% Granger Causality Testing
% The basic GC test uses a likelihood ratio-type test, which is a standard likelihood 
% ratio if the data is homoskedastic. The outputs are the pairwise test and the 
% 'all' test which tests whether a VAR is needed for variable i. In these results 
% a VAR may not be needed for the GDP deflator growth, which has an 'all' pval 
% of just over 5%.
%%
std_data = bsxfun(@rdivide,var_data,std(var_data));
[gc_stat, pval, stat_all, pval_all] = grangercause(std_data,1,1:2);
disp('GC statistic')
disp(gc_stat)
disp('GC statistic pvals')
disp(pval)
disp('GC statistic for all other variables')
disp(stat_all)
disp('GC statistic pval for all other variables')
disp(pval_all)
%% Granger Causality Testing with Different Inference Method
% The inference method can be changed from the likelihood-ratio based method 
% to LM (2) or Wald (3). The other options are to use heteroskedasticity robust 
% testing (the first 1) and to assume that the errors are uncorrelated (the 0, 
% since I want to allow correlation).
%%
disp('Wald-based testing')
[gc_stat, pval, stat_all, pval_all] = grangercause(std_data,1,1:2,1,0,3);
disp('GC statistic')
disp(gc_stat)
disp('GC statistic pvals')
disp(pval)
disp('GC statistic for all other variables')
disp(stat_all)
disp('GC statistic pval for all other variables')
disp(pval_all)
%% Granger Causality for only GS10 and GS1
% The final assignment is to drop the GDP Deflator and rerun the test. The main 
% observation from this is that the 'all' test is identical to the pairwise since 
% there are no other variables to drop.
%%
disp('Bivariate Testing')
[gc_stat, pval, stat_all, pval_all] = grangercause(std_data(:,2:3),1,1:2);
disp('GC statistic')
disp(gc_stat)
disp('GC statistic pvals')
disp(pval)
disp('GC statistic for all other variables')
disp(stat_all)
disp('GC statistic pval for all other variables')
disp(pval_all)