%% Program flow
%% Reset the workspace
% Start with a clear workspace
%%
clear all
close all
clc
rng('default')
%% For loop sum
% To compute a sum in a loop, it is necessary to have a value to hold the sum. 
% Normally |sum| would be directly called on an array to avoid the loop.
%%
N = 10;
tot = 0;
for i=1:N
    tot = tot + i;
end
disp('Direct')
disp(sum(1:N))
disp('Loop')
disp(tot)
%% Compound return
% Compound return computation is similar to sums only the initial value is 1.0. 
% Here we want to save all value
%%
cr = zeros(10,1);
tot = 1;
for i = 1:10
    tot = tot * 1.063;
    cr(i) = tot;
end
disp(cr)
%% Simulated random walk
% Here |randn| is used to generate normals and then a loop is used to construct 
% the random walk using the index of the current observation and the previous 
% one
%%
e = randn(100,1);
y = zeros(100,1);
y(1) = e(1);
for i=2:100
    y(i) = y(i-1) + e(i);
end
%% Simpler random walk (no loop)
% To simulate a random walk it isn't strictly necessary to use a loop since 
% |cumsum| - cumulative sum - can be used to compute the same result without a 
% loop.
%%
easy = cumsum(e);
disp([y(end), easy(end)])
%% Random walk with stochastic volatility
% The is just a more complex simulation that could not easily be implemented 
% without a loop.
%%
u = randn(250,1);
e = randn(250,1);
sigma = ones(100,1);
lnsigma = log(sigma);
y = zeros(100,1);

for i=2:100
    lnsigma(i) = 0.99 * lnsigma(i-1) + 0.1 * u(i);
    sigma(i) = exp(lnsigma(i));
    y(i) = y(i-1) + sigma(i) * e(i);
end
subplot(2,1,1)
plot(y)
title('y')
subplot(2,1,2)
plot(sigma)
title('sigma')
%% Nested Loops
% Loops can be nested to iterate across multiple dimensions of an array.
%%
load momentum
momentum = [mom_01 mom_02 mom_03 mom_04 mom_05 mom_06 mom_07 mom_08 mom_09 mom_10];
legend_text = cell(10,1);
cr=zeros(size(momentum));
gr = 1 + momentum;
for i=1:10
    cr(1,i) = 1+momentum(1,i);
    legend_text{i} = ['mom_{' num2str(i) '}'];
    for t=2:size(momentum,1)
        cr(t,i)=cr(t-1,i)*gr(t,i);
    end
end
% New figure window
figure()
plot(cr)
legend(legend_text)

% Direct way using cumprod
cr2 = cumprod(gr);
% Difference
max(max(abs(cr-cr2)))
%% Many random walks
% Here we use a nested loop to simulate many random walks, although the command 
% |cumsum| can be used to do the same here as well. 
%%
e = randn(1000,10);
rw = zeros(size(e));
for i=1:10
    rw(1,i) = e(1,i);
    for t=2:1000
        rw(t,i) = rw(t-1,i) + e(t,i);
    end
end
rw2 = cumsum(e);
%% 
% 
%% Detecting Runs
% Here we will detect the runs.  The description of the problem is 
% 
% * Start at t=1 and define |run(1) = 1|
% 
% * For i in 2,...,T, define |run(i) = run(i-1) + 1| if  the sign of `r(i)` 
% and the sign of `r(i-1)` are equal  else 1.
%%
load momentum
T = length(mom_01);
runs = zeros(T,1);
runs(1) = 1;
for i = 2:T
    if sign(mom_01(i)) == sign(mom_01(i-1))
        runs(i) = runs(i-1)+1;
    else
        runs(i) = 1;
    end
end
plot(runs)
title('Momentum 1')
max(runs)
locs = find(runs==max(runs))
locs
for loc=locs'
    disp('Run ending')
    disp(loc)
    disp('Sign')
    disp(sign(mom_01(loc)))
end
disp('Number 5 days or more')
sum(runs >= 5)

% Momentum 10
for i = 2:T
    if sign(mom_10(i)) == sign(mom_10(i-1))
        runs(i) = runs(i-1)+1;
    else
        runs(i) = 1;
    end
end
plot(runs)
title('Momentum 10')
max(runs)
loc = find(runs==max(runs))
disp('Run ending')
disp(loc)
disp('Sign')
disp(sign(mom_01(loc)))