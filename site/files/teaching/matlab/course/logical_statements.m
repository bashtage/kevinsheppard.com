%% Logical Operators
% Logical operators are an important for producing complex programs that or 
% performing selection on arrays depending on the value contained in that or another 
% array
%% Reset the workspace
% Start with a clear workspace
%%
clear all
close all
clc
rng('default')
%% Load data
% Load the data to be used
%%
load momentum
%% Count negative returns
% Basic logical operations produce logical true (1) or logical false (0). Counts 
% can be implemented by summing the true values
%%
disp('Momentum 1')
disp([sum(mom_01<0) sum(mom_01==0) sum(mom_01>=0)])
disp('Momentum 10')
disp([sum(mom_10<0) sum(mom_10==0) sum(mom_10>=0)])
disp('Large returns (>2 sd)')
sum(abs(mom_05) > (2 * std(mom_05)))
%% Combining logical
% Locical arrays can be combined using and (&), or (|) or xor (which is a funtion, 
% |xor|). It is also possible to negative logical arrays using |~| which will 
% flip true to false and false to true
%%
sum((mom_01 < 0) & (mom_10 < 0))
mom_01_large = abs(mom_01) > 2*std(mom_01);
mom_10_large = abs(mom_10) > 2*std(mom_10);
sum(mom_01_large & mom_10_large)
%% For loops with logical statements
% Logical statements can be combined with for loops to produce conditional execution 
% in complex problems
%%
figure()
e = randn(100,1);
y = zeros(100,1);
y(1) = e(1) + (e(1) < 0) * e(1);
for i=2:100
    if e(i) < 0
        y(i) = y(i-1) + 2 * e(i);
    else
        y(i) = y(i-1) + e(i);
    end
end
plot([y cumsum(e)])
legend('With asym','No asym')
%% Logical selection
% Logical arrays can be used to select values in locations where the logical 
% is true
%%
a = mom_01(mom_01 < 0);
b = mom_01(mom_01 >= 0);
c = mom_01(mom_01 == 0);
disp(length(a) + length(b) + length(c))
disp(length(mom_01));


a = mom_01(mom_10 < 0);
b = mom_01(mom_10 >= 0);
c = mom_01(mom_10 == 0);
disp(length(a) + length(b) + length(c))
disp(length(mom_10));

% Both negative
[mom_01(mom_01 < 0 & mom_10 < 0) mom_10(mom_01 < 0 & mom_10 < 0)]
%% Using find
% Find takes a logical array and returns the locations (numbers) where the logical 
% array is true.
%%
mom_05(find(mom_05 < 0))

momentum = [mom_01, mom_02, mom_03, mom_04, mom_05, mom_06, mom_07, mom_08, mom_09, ...
    mom_10];
[i,j] = find(momentum < -0.02);
disp(length(i))
disp(length(j))
%% Any and all
% Any and all can be used to quickly determine when all elements are true or 
% any element is true.  |all| computes the value of and (&) for all elements in 
% an array while |any| computes the values of or (|) for all elements in an array
%%
bad_day = all(momentum < 0, 2)
disp('Percentage of bad days')
mean(bad_day)

a_neg_return = any(momentum < 0, 1);
no_neg_returns = all(momentum >= 0, 1);
no_neg_returns2 = ~any(momentum < 0, 1);

disp('In agreement')
disp(all(no_neg_returns2 == no_neg_returns))