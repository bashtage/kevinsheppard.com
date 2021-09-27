function cols = stg(y, x, alpha)
% STG(y, x, alpha)
%   STG(y, x, alpha) selects a model using Specific-to-General where the
%   stopping rule is when the pvalues of the exlcuded variables are all >
%   alpha.
%
% Y - N by 1 array of dependent data
% X - N by K array of regressors
% ALPHA - Size to use when to stop the StG method

% Initialize pval to that we run the algorithm
pval = 0;
% Start with no variables in the model
included = [];
% Get the number of regressors
k = size(x,2);
% Construct the list of variables not in the model
excluded = 1:k;
while min(pval) < alpha
    % Place holder for the tstats
    tstats = zeros(length(excluded),1);
    for i = 1:length(excluded)
        % Add one of the excluded columns in
        cols = [included  excluded(i)];
        % Compute the beta and vcv
        [b,~, ~, vcv] = ols(y, x(:,cols), 0);
        % Construct the tstats
        tstat = b ./ sqrt(diag(vcv));
        tstat = tstat(length(tstat));
        % Save only the absolute value of the last tstat
        tstats(i) = abs(tstat(length(tstat)));
    end
    % Compute the pvalues for the excluded variables
    pval = 2 - 2 *normcdf(abs(tstats));
    % Check if any pval is smaller than alpha
    if min(pval) < alpha
        % If one is smaller, find the maximum tstat
        % Minimum pval is problematic since many can be numerically 0
        to_add = excluded(tstats == max(tstats));
        % Add the index of the excluded variable to included lsit
        included = [included to_add];
        % Construct an excluded list that doesn't include the included
        excluded = setdiff(1:k, included);
    end
    % If the pval was small, this loop will run again. If the pval > alpha
    % then this while loop will end
end
% Define the columns to return
cols = included;
