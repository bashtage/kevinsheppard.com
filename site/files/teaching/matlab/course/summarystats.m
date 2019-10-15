function stats = summarystats(x)
% Produce summary stats in a table
%
% Inputs
%    x - T by K array
%
% Outputs
%    stats - K by 4 table containins the mean, std dev, skewness and
%              kurtotis

% ... is used to continue long lines.
stats = table(mean(x)', std(x)', skewness(x)', kurtosis(x)', ...
              'VariableNames',{'Mean','Std','Skew','Kurt'});
