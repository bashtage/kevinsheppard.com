%% Model Selection and Cross-Validation
%% Notes
% I have only compute these quantities for 1 series. The code is complex enough 
% without another level of nesting. 
% 
% * The series can be changed using |series_index|.
% * The StG and GtS should probably be manually implemented
% * The cross-validation example is a good one to implement since the algorithm 
% is relatively simple.
% * In practice, using the |ols| function is very heavy handed (but easy) - 
% it would be better to directly compute the regression (i.e. |X\y|) so that only 
% the required quantities are computed.
%% Setup
% Clear and reset the workspace and load required data

% Clean up everything
clear all
close all
clc
% Reset rng to make runs the same
rng('default')
% Load data
load FF_data
%% AIC and BIC
% This example first builds a cell array containing all sets of regressors and 
% the loops across these to compute the s2, which can then be used to compute 
% the AIC and BIC.  _min_ is used to find the location of the smallest one, which 
% is then used with a cell array of strings to print the "best" model.

% Set the series to use
series_index = 6;
% Setup regressors
X = FF_factors_monthly(:,2:4);
% Set up the dependent variables
y = FF_portfolios_monthly(:,series_index);
% Remove any bad observations
pl = any(isnan(X),2);
X = X(~pl,:);
y = y(~pl);
% Cell array of variables in each model
variables = {'None','VWM','SMB','HML','VWM & SMB','VWM & HML','SMB & HML','All'};
% Cell array of regressor matrices
Xmats = {[],X(:,1),X(:,2),X(:,3),X(:,1:2),X(:,[1 3]),X(:,2:3),X};
% Arrays to hold AIC and BIC
AIC = zeros(8,1);
BIC = zeros(8,1);
% Loop over regressor matrices
for i=1:length(Xmats)
    % Get the s2
    [~,~,s2] = ols(y,Xmats{i},1);
    % Get the number of regressors
    k = size(Xmats{i},2) + 1;
    T = size(y,1);
    % Compute AIC and BIC
    AIC(i) = log(s2) + 2*k/T;
    BIC(i) = log(s2) + log(T)*k/T;
end
% Use min to find the smallest
disp('AIC selects')
disp(variables{AIC==min(AIC)})
disp('BIC selects')
disp(variables{BIC==min(BIC)})
%% StG
% This is an algorithmic presentation of StG model selection. The main idea 
% is to start with no variables, and then add variables one at a time, which the 
% largest absolute t-stat, as long as one of the excluded t-stats is significant. 
% In this example, I've used 2-sided 95% confidence intervals.
% 
% You should probably manually run through this exercise. In practice it 
% is quick.

% Critical value to use in StG
CV = norminv(.975);
% Nothing included at first
included = [];
% Used to make sure the while loop runs
excluded_tstats = inf;
while any(abs(excluded_tstats)>CV)
    % Find the index of the excluded variables.
    excluded = setdiff(1:3,included);
    % Setup t-stats for the excluded
    excluded_tstats = zeros(1,3);
    % Loop over excluded
    for i=1:length(excluded)
        % Add 1 excluded at a time
        tempX = [X(:,included) X(:,excluded(i))];
        % Run regression
        [b,~,~,~,VCV_white] = ols(y,tempX, 1);
        % Update t-stat in the correst position
        pos = excluded(i);
        excluded_tstats(pos) = b(end)./sqrt(diag(VCV_white(end,end)));
    end
    if max(abs(excluded_tstats))>CV
        % Find the largest, since 1 is large enough
        [~,pos] = max(abs(excluded_tstats));
        % Its position is the regressor, add to included list
        included = sort([included pos]);
    end
    % Return to the start of the while, only ending if no variable was
    % added in the previous round
end
% Display results
disp('StG Selects X columns')
disp(included)
%% GtS
% Like StG, this is also algorithmic. The idea is virtually identical, only 
% in reverse. Start with all variables in the model so that the excluded list 
% is empty, and then exclude variables if their t-stat is too small relative to 
% a t-stat.

% Make sure the loop runs
included_tstat = 0;
% Empty excluded list to start
excluded = [];
while any(abs(included_tstat)<CV)
    % Find the variables included
    included = setdiff(1:3,excluded);
    % Set up regressors
    tempX = X(:,included);
    % Estimate model
    [b,~,~,~,VCV_white] = ols(y,tempX, 1);
    % Holder for t-stats.  inf ensures that t-stats already excluded will
    % be ignored.
    included_tstat = inf * ones(1,3);
    % Compute t-stats
    tstat = b(2:end)./sqrt(diag(VCV_white(2:end,2:end)));
    % Store them in the correct positions
    included_tstat(included) = tstat;
    % IF any are too small, add one to excluded list
    if any(abs(included_tstat)<CV)
        % Find smallest in absolute value
        [~,pos] = min(abs(included_tstat));
        % Add to excluded list
        excluded = sort([excluded included(pos)]);
    end
    % Return to while loop if any t-stats are small
end
disp('GtS selects X columns')
disp(setdiff(1:3,excluded))
%% Cross-validation
% k-fold Cross validation used k blocks of randomly selected observations. k-1 
% are used to estimates, and the remaining is used to compute the SSE (or R2). 
% The blocks are looped over to compute the SSE using all observations so that 
% each block is held out once.

% Randperm generates a randomly ordered vector containing 1 to T
random_order = randperm(T);
% Set the number of folds
folds = 5;
% splits contains the break points, which is a function of k
splits = round(linspace(1,T+1,folds + 1));
% Initialize holders for SSE and R2
SSEs_xv = zeros(8,1);
R2s_full_sample = zeros(8,1);
R2s_xv = zeros(8,1);
% Loop over models.  Also uses the cell array of regressors
for j=1:8
    % Initialize SSE
    SSE = 0;
    % Set the X for this loop
    X = Xmats{j};
    % Get full sample R2
    [~,~,~,~,~,R2_full_sample]=ols(y,X,1);
    for i=1:length(splits)-1
        % Choose points to delete and retain
        delete = random_order(splits(i):splits(i+1)-1);
        % Set diff - those not deleted are retained
        retain = setdiff((1:T)',delete);
        
        % This is needed since one of the X matrices is empty (which
        % produces a model with only a constant)
        
        % Delete observation
        if ~isempty(X)
            X_xv = X(retain,:);
        else
            X_xv = [];
        end
        y_xv = y(retain,:);
        % Estimate Model
        b = ols(y_xv,X_xv,1);
        % Again, needed to handle constant
        if ~isempty(X)
            e = y(delete) - X(delete,:)*b(2:end) - b(1);
        else
            e = y(delete) - b;
        end
        % Compute SSE using hold out observations
        SSE = SSE + e'*e;
    end
    % Store the SSE, and compute corresponding R2
    SSEs_xv(j) = SSE;
    TSS = (y-mean(y))'*(y-mean(y));
    R2s_xv(j) = 1 - SSE / TSS;
    R2s_full_sample(j) = R2_full_sample;
end
% Display results
disp('R2s: Full and X-val')
disp([R2s_full_sample R2s_xv])
% Full sample R2s are always larger.  The difference is related to
% overfitting.
disp('R2 difference - must be negative')
disp(R2s_xv - R2s_full_sample)
[~,pos] = max(R2s_xv);
disp('X-validation selects')
disp(variables{pos})