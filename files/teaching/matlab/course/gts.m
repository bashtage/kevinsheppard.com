function cols = gts(y, x, alpha)
% GTS(y, x, alpha)
%   GTS(y, x, alpha) selects a model using General-to-Specific where the
%   stopping rule is when the pvalues of the included variables are all <
%   alpha.
%
% Y - N by 1 array of dependent data
% X - N by K array of regressors
% ALPHA - Size to use when to stop the StG method


% Setup the pvalue so that it will always run at least once
pval = 1.0;
% Get the size of the data
k = size(x,2);
% Set up the list of variables in the model
included = 1:k;
% Run when insignificiant coefficients and there is at least 1 included
while max(pval) > alpha && ~isempty(included)
    % Compute coefficients
    [b,~, ~, vcv] = ols(y, x(:,included), 0);
    % Compute tstats
    tstat = b ./ sqrt(diag(vcv));
    % Compute pvals
    pval = 2 - 2 * normcdf(abs(tstat));
    if max(pval) > alpha
        % If any variables are insignificant, drop the largest pval
        remove = pval == max(pval);
        % Update the included so that the variable removed is not in this
        % list
        included = setdiff(included, included(remove));
    end
end
% Get the columns to return
cols = included;
