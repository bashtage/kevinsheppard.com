%% Functions
% This lesson covers the use of functions
%% Reset
% Reset the workspace and load the momentum data
%%
clear all
load momentum
%% Help and Doc
% |help| shows information about using a function in the command window. |doc| 
% opens another window containing a formatted and expanded help document for a 
% function.
%%
help std
doc std
%% Sorting
% |sort| will sort data from smallest to largest
%%
mom10_sorted = sort(mom_10);
mom10_sorted(1) % First element
mom10_sorted(end) % Last element
%% Using multiple outputs
% Multiple outpus are grouped using square brackets (|[ ]|).  |sort| supports 
% two outputs. The first is the sorted data as in the previous problem. The second 
% is the set of indices that will sort the data so that mom|10_sorted| is the 
% same as mom|10(mom10_indices)|.
%%
[mom10_sorted,mom10_indices]=sort(mom_10);
n = length(mom_10);
mom10_indices([1,n]) % First and last index
mom_10(mom10_indices([1,n])) % Same as above
%% Calling functions with multiple inputs
% Most functions take more than one input.  |linspace| generates a linear space 
% of points equally spaced and is used like
% 
% |linspace(start, end, number_of_points)|
% 
% This example will make an array containing 11 points between 0 and 1 inclusive 
% (0, 0.1, 0.2, ..., 1)
%%
linspace(0,1,11)
%% Calling functions with empty inputs or outpus
% Sometimes it is necessary to call a function using some but not all inputs. 
% This is a problem when, say, you want to access inputs 1 and 3 but not 2. The 
% solution is to use the special character ~ to skip any inputs not required. 
% These inputs will use the default value.
%%
momentum=[mom_01 mom_02 mom_03 mom_04 mom_05 mom_06 mom_07 mom_08 mom_09 mom_10];
std(momentum)
std(momentum,[],1); % Same
std(momentum,[],2); % Use axis 2, which computes the std row by row 
                   % instead of column by column
%% Calling a custom function
% The function is in |normal_likelihood.m|
% 
% |% Compute the normal likelihood for a data point|
% 
% |%|
% 
% |% Inputs|
% 
% |% x - The datapoint|
% 
% |% mu - The mean|
% 
% |% sigma2 - The variance|
% 
% |%|
% 
% |% Outputs|
% 
% |% likelihood - The likelihood from the normal distribution|
% 
% |%|
% 
% |% Notes:|
% 
% |% This string is what appears when you enter help normal_likelihood|
% 
% |likelihood = 1 / sqrt(2*pi*sigma2) * exp(-(x-mu)^2/(2*sigma2));|
%%
normal_likelihood(0,1,1)
normal_likelihood(0,1,4)
%% Improving the custom function
% It is usually best practice to write functions that take vectors. The original 
% function is extended to allow vector inputs using dot-operations such as |.*|, 
% |./| and |.^| which are element-by-element multiplication, division and exponentiation, 
% respectively.
% 
% The main changs to the function is
% 
% |likelihood = 1 / sqrt(2*pi*sigma2) .* exp(-(x-mu).^2./(2*sigma2))|
%%
x=[-3; 0; 0];
mu = [-3;0;1];
sigma2=[9; 4; 1];
normal_likelihood_vec(x, mu, sigma2)
%% Writing a summary statistic function
% This function outputs a table using the |table| command. It makes use of the 
% built-in functions for |mean|, |std|, |skewness|, |kurtosis| so that it is fairly 
% simple.
% 
% |function stats = summarystats(x)|
% 
% |% Produce summary stats in a table|
% 
% |%|
% 
% |% Inputs|
% 
% |% x - T by K array|
% 
% |%|
% 
% |% Outputs|
% 
% |% stats - K by 4 table containins the mean, std dev, skewness and|
% 
% |% kurtotis|
% 
% |% ... is used to continue long lines.|
% 
% |stats = table(mean(x)', std(x)', skewness(x)', kurtosis(x)', ...|
% 
% | 'VariableNames',{'Mean','Std','Skew','Kurt'});|
%%
summarystats(momentum)