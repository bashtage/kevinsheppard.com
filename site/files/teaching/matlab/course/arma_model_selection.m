%% ARMA Model Selection
%% Clear the environment
% It is a good idea to clear all variables and close all figures before proceeding
%%
clear all
close all
clc
%% Load the data
% The next step is to load the data. The next two lines set the maximum AR and 
% MA lags.
%%
load term
MAX_AR = 4;
MAX_MA = 4;
%% Estimation
% Model selection is challenging to automate. Instead, this code estimates all 
% ARMAR models with p=0,1,...,4 and q=0,1,...4, and then looks at log likelihoods, 
% AICs and BICs.
%%
% Use a cell array to hold results from the models.  Cell arrays allow
% arbitrary data to be stored.
models = cell(MAX_AR+1,MAX_MA+1);

% Options to suppress display.  ARMA models are estimated using lsqnonlin
options =  optimset('lsqnonlin');
options.MaxIter = 1000;
options.Display='none';

% Setup arrays to hold values
LLs = zeros(MAX_AR,MAX_MA);
AICs = zeros(MAX_AR,MAX_MA);
BICs = zeros(MAX_AR,MAX_MA);

% Get the effective T since MAX_AR will be held back
T = length(term) - MAX_AR;
% Loop over AR and MA order
for i=0:MAX_AR
    for j=0:MAX_MA
        disp(['AR: ' num2str(i) ' MA: ' num2str(j)])
        % The MAX_AR term below enforces the holdbac, which is requires
        % when comparing AR models with different lag lengths.  Failing to
        % use this will produce log-likelihods base don different number of
        % observations.
        [p,ll,ser] = armaxfilter(term,1,1:i,1:j,[],[],options,MAX_AR);
        % Use a struct to store results
        model = struct();
        model.parameters = p;
        model.LL = ll;
        model.SER = ser;
        models{i+1,j+1} = model;
        % Store other values for use later
        LLs(i+1,j+1) = ll;
        AICs(i+1,j+1) = ll - 2 * (1+i+j);
        BICs(i+1,j+1) = ll - log(T) * (1+i+j);
    end
end
%% Plot the Log-likelihoods
% This produces a surface plot of the log-likelihoods. The AR=0 case has been 
% eliminated since the log-lieklihoods of this model are very bad. Unsuprisingly, 
% the largest model has the largest LL, although the gains appear to be small 
% once the AR and MA order are both >= 1
%%
% New figure
figure()
% Use surf to produce a surface plot
surf(0:4,1:4,LLs(2:5,:))
% Labels - X is the first (columns of data), Y is the second (rows)
xlabel('MA Order')
ylabel('AR Order')
% Title
title('Log-likelihoods')
disp('LL difference from highest')
disp(LLs(2:5,:) - max(max(LLs)))
%% Plot the AICs
% The AICs are plotted in the same matter. The maximum value is also computed.
%%
% New figure
figure()
% Use surf to produce a surface plot
surf(0:4,1:4,AICs(2:5,:))
% Labels - X is the first (columns of data), Y is the second (rows)
xlabel('MA Order')
ylabel('AR Order')
% Title
title('AIC')
% Find the model which has the maximum value
[AIC_AR,AIC_MA] = find(AICs==max(max(AICs)));
disp('AIC Maximum at:')
disp([AIC_AR - 1 AIC_MA - 1]);
%% Plot the BICs
% The BICs are plotted in the same matter. The maximum value is also computed.
%%
% New figure
figure()
% Use surf to produce a surface plot
surf(0:4,1:4,BICs(2:5,:))
% Labels - X is the first (columns of data), Y is the second (rows)
xlabel('MA Order')
ylabel('AR Order')
% Title
title('BIC')
[BIC_AR,BIC_MA] = find(BICs==max(max(BICs)));
disp('BIC Maximum at:')
disp([BIC_AR - 1 BIC_MA - 1]);