function sse = kfold_cross_val(y,x,folds,selection)
% KFOLD_CROSS_VAL compute SSE for K-fold cross validation of a lin reg
%   SSE = KFOLD_CROSS_VAL(Y, X, FOLDS, SELECTION)
%
% Y - N by 1 array of dependent data
% X - N by K array of regressors
% FOLDS - Number of observations to use
% SELECTION - Cell array where each value is a set of columns to consider

% Set up the start and end locations of the blocks and compute the indices
% of the observations that will be used in estimation and evaluation

% Number of observations
n = length(y);
% Number of models to consider
m = size(selection, 1);
% Place holder for blocks (estimation) and evaluation samples
blocks = cell(folds,1);
eval = cell(folds,1);
% Number of observations in the blocks
block_size = n / folds;
for i = 1:folds
    % Find the first and last observation in each block.  Use floor to
    % ensure these are integers
    st = floor((i-1) * block_size + 1);
    en = floor(i * block_size);
    % Save the blocks and eval locations
    blocks{i} = setdiff(1:n,st:en);
    eval{i} = st:en;
end

% Array to hold x-val SSE
sse = zeros(m,1);
% Array to hold errors from a single pass
e = zeros(n,1);
% Loop across models
for i = 1:m
    % Get one set of column indexes
    cols = selection{i};
    % Construct x for these columns
    temp_x = x(:,cols);
    % Loop over folds
    for j = 1:folds
        % Construct the estimation x and y
        block_x = temp_x(blocks{j},:);
        block_y = y(blocks{j},1);
        % Estimate beta
        b = block_x \ block_y;
        % Save evaluation residuals using the evaluation sample
        e(eval{j}) = y(eval{j}) - temp_x(eval{j}, :) * b;
    end
    % Compute the sse for model i using the evaluation residuals
    sse(i) = e'*e;
end
