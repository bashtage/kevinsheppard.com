%% ARCH Model Selection
% This task shows how to estimate GARCH models and provides some description 
% of common features of models and parameters
%% Prepare the workspace
% Clean up before starting
%%
clear all
close all
clc

% Suppress a warning
warning off
% Only if the econ toolbox installed
rmpath('C:\Program Files\MATLAB\R2013a\toolbox\econ\econ')
%% S&P 500: Data and Returns
% Start by loading the data and constructing returns. It is usually a good idea 
% to use 100 * returns which helps numerical stability
%%
load sp500
% Select the last 10 years
sub = (dates > datetime(2008,12,31)) & (dates < datetime(2019,1,1));
sp500 = sp500(sub)
r = 100 * diff(log(sp500));
%% Model Fitting
% All models are fit with p, o and q ranging between 0 and 2. The results are 
% printed and then a discussionp will follow.
% 
% The options below are used to suppress iterative output of the optimizer
%%
options = optimset('fminunc');
options.Display = 'none';
options.Diagnostics = 'off';

% Lag values to use
p = [1 1 2 1 1];
o = [0 1 1 2 1];
q = [1 1 1 1 2];

LLs = zeros(15,1);
k = zeros(15,1);
count = 1;
% Loop across models, and output
for i=1:5
    [parameters,ll,~,vcv]=tarch(r,p(i),o(i),q(i),[],[],[],options);
    tarch_display(parameters,ll,vcv,r,p(i),o(i),q(i),[],2);
    
    LLs(count) = ll;
    k(count) = p(i)+o(i)+q(i)+1;
    count = count + 1;
end

for i=1:5
    [parameters,ll,~,vcv]=tarch(r,p(i),o(i),q(i),[],1,[],options);
    tarch_display(parameters,ll,vcv,r,p(i),o(i),q(i),[],1);
    
    LLs(count) = ll;
    k(count) = p(i)+o(i)+q(i)+1;
    count = count + 1;    
end

options = optimset('fmincon');
options.Display = 'none';
options.Diagnostics = 'off';

for i=1:5
    [parameters,ll,~,vcv]=egarch(r,p(i),o(i),q(i),[],[],options);
    egarch_display(parameters,ll,vcv,r,p(i),o(i),q(i),[]);
    
    LLs(count) = ll;
    k(count) = p(i)+o(i)+q(i)+1;
    count = count + 1;    
end
%% Log-likelihoods and AIC/BIC
% Looking at the LL and the AIC/BIC, the best most is the penultimate one, which 
% is an EGARCH(1,2,1). This model has 2 asymmetry terms with different signs. 
% 
% In all cases the asymmetry leads to large LL gains and reductions in AIC/BIC. 
% However, the evidence of the other parameters mattering is not especially strong, 
% and so I would choose either an EGARCH(1,1,1), or possibly a simple TARCH(1,1,1)
%%
disp(LLs - max(LLs))

T = length(r);
AICs = -LLs/T + 2*k/T;

T = length(r);
BICs = -LLs/T + log(T)*k/T;

disp([AICs - min(AICs) BICs - min(BICs)])