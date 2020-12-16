%% Estimating Vector Autoregressions
% This task shows how to estimate a VAR(1) for three series.
%% Prepare the workspace
% Clean up before starting
%%
clear all
close all
clc
%% Load the data
% The data was taken from Sydney Ludvigson's web page
%%
load cay
% Pull out the arrays from the table
c=cay.c;
a=cay.a;
y=cay.y;
%% Basic EG Test
% The basic EG test uses a cross sectional regression of one variable on the 
% others, plus possibly deterministic terms (an intercept here). The test is an 
% AugDf on the errors, and in this simple example, the null is rejected which 
% indicates evidence of cointegration.
%%
T = length(c);
X=[a y];
Y = c;
beta = olsnw(Y,X,1);
e = c - [ones(T,1) X] * beta;
figure()
plot(e)
title('Error, OLS')
disp('Cointegrating Vector')
disp(beta')
[adf, pval] = augdfautolag(e,0,24);
disp('Basic test    Pval')
disp([adf pval])
%% Change the LHS
% The EG test is not robust to changing the LHS variable, although the same 
% conclusion is reached using 'a' as the LHS. The same is not true when 'y' is 
% the LHS.
%%
T = length(c);
X=[c y];
Y = a;
beta = olsnw(Y,X,1);
e = a - [ones(T,1) X] * beta;
figure()
plot(e)
title('Error, OLS, a as LHS')
[adf, pval] = augdfautolag(e,0,24);
disp('Basic test    Pval')
disp([adf pval])
 
 
T = length(c);
X=[c a];
Y = y;
beta = olsnw(Y,X,1);
e = a - [ones(T,1) X] * beta;
figure()
plot(e)
title('Error, OLS, y as LHS')
 
[adf, pval] = augdfautolag(e,0,24);
disp('Basic test    Pval')
disp([adf pval])
%% Post Volker
% The Same test can be used in the post-Volker era, and cointegration is found 
% since the ADF indicates rejection.
%%
sel = cay.date > datetime(1981,1,1);
 
c=c(sel);
a=a(sel);
y=y(sel);
 
 
T = length(c);
X=[a y];
Y = c;
beta = olsnw(Y,X,1);
e = c - [ones(T,1) X] * beta;
figure()
plot(e)
title('Error, OLS, Post Volker')
[adf, pval] = augdfautolag(e,0,24);
disp('Post Volker   Pval')
disp([adf pval])
%% DOLS
% A better way to estimate the cointegrating vector is to us Dynamic OLS which 
% is similar to the basic model, but also includes leads and lags of the _difference_ 
% of the LHS variables. The intuition behind this is similar to the inclusion 
% of the lags in an ADF (when compared to a DF) since these are, by design I(0) 
% if the LHS is I(1), and so they cannot account for the unit root. They can, 
% however, soak up some predictability and lead to errors closer to white noise.
%%
load cay
c=cay.c;
a=cay.a;
y=cay.y;
 
diffs = diff([c,a,y]);
 
ll = 1;
% Select the correct data, and the leads and the lags
new = [c a y];
new = new(2:end,:);
new = new(ll+1:end-ll,:);
tau = size(diffs,1);
Y = new(:,1);
X = new(:,2:3);
for i=-ll:ll
    d = diffs(ll+i+1:tau-ll+i,2:3);
    X = [X d];
end
beta = olsnw(Y,X,1);
 
e = Y - [ones(size(X,1),1) X(:,1:2)] * beta(1:3);
figure()
plot(e);
title('Error, DOLS, 1 lag')
disp('Cointegrating Vector')
disp(beta(1:3)')
[adf, pval] = augdfautolag(e,0,24);
disp('DOLS test     Pval')
disp([adf pval])
%% DOLS, 2 leads and lags
% DOLS can be used with additional leads and lags, which does not change the 
% results.
%%
ll = 2;
 
new = [c a y];
new = new(2:end,:);
new = new(ll+1:end-ll,:);
tau = size(diffs,1);
Y = new(:,1);
X = new(:,2:3);
for i=-ll:ll
    d = diffs(ll+i+1:tau-ll+i,2:3);
    X = [X d];
end
beta = olsnw(Y,X,1);
 
e = Y - [ones(size(X,1),1) X(:,1:2)] * beta(1:3);
figure()
title('Error, DOLS, 2 lags')
plot(e);
disp('Cointegrating Vector')
disp(beta(1:3)')
[adf, pval] = augdfautolag(e,0,24);
disp('DOLS test     Pval')
disp([adf pval])