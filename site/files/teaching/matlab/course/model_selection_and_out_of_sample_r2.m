%% Model selection and Out-of-Sample $R^2$
% This exercise looks at the effect of model selection on out-of-sample $R^2$.  
% The true model has 3 variables $y_t = \beta_1x_{1,t-1}+\beta_2x_{2,t-1}+\beta_3x_{3,t-1}+\epsilon_t$.  
% These three variables are correlated with a correlation of $\rho$.  In addition, 
% there are 5 more variables that are available which are correlated with the 
% true variables with a correlation of $\rho$.  When $\rho$ is large, these variables 
% will look similar to the true variables.  The ${\beta}$ is generated with two 
% considerations in mind:
% 
% * There is a parameter $\lambda\in(0,1]$ (called strength) that determines 
% how the coefficients decline in importance.  The coefficient are constructed 
% so that $\beta_j/\beta_{j-1} = \lambda$. When $\lambda=1$ all ${\beta}$ will 
% have the same value.  
% * The variance of residual is set of 1.  The ${\beta}$ are scaled so that 
% $R^2 =Var(x{\beta}) / (Var(x{\beta}) + Var(\epsilon))$ where $R^2$ is a model 
% parameter. 
% 
% All data in this exercise is simulated. We will conduct 8 scenarios using 
% all permutations of:
% 
% * Correlation $\rho\in\{0.2,0.8\}$
% * Strength $\lambda\in\{0.6,1\}$
% * $R^2\in\{0.1,0.25}$
% * 
%% Model Selection
% I will consider 5 model selection methods:
% 
% * AIC
% * BIC
% * 10-fold Cross Validation
% * GtS
% * StG
% 
% 
% 
% When using AIC, BIC and X-validation, all possible model with the regressors 
% will be evaluated leading to a total of $2^8-1$ models since I won't consider 
% models with no regressors. 
% 
% First I restore the random number generator to its default so that multiple 
% runs of the simulation will generate similar answers.

rng('default')
%% 
% Next I setup the selection arrays which will contains the entire set of 
% possible column combinations that could be jointly setup.


selection = {};
for i = 1:8
    vals = nchoosek(1:8,i);
    vals = mat2cell(vals,ones(size(vals,1),1),i);
    selection = [selection;vals];
end
%% Single Run
% Before writing loops to compute all simulations, it is useful to step through 
% the steps for a single run. The data is generated using the function |generate_data|. 
% The model is selected and fit using half and then will be evaluated using the 
% second half.
% 
% *Note*: See the functions for information on the steps used to implement 
% the various statistical measures
%%
n = 250;
r2 = 0.25;
rho = 0.8;
strength=0.6;
[y, x] = generate_data(n, 3, 5, r2, strength, rho);
full_y = y;
full_x = x;
y = y(1:n/2);
x = x(1:n/2,:);
%% Information Criteria
% The information criteria are computed in a helper function.  Here I compute 
% the IC and show the columns selected.  Ideally these would both be [1, 2, 3] 
% since these are the true regressors.

[aic, bic] = compute_ic(y,x,selection);
aic_cols = selection{aic == min(aic)}
bic_cols = selection{bic == min(bic)}
%% Cross validation
% Cross varidation is also implemented in a function.

folds = 10;
sse = kfold_cross_val(y,x,folds,selection);
xval_cols = selection{sse == min(sse)}

%% General-to-Specific and Specific-to-General
% Finally GtS and StG are implemented in their own functions. 

gts_cols = gts(y,x,0.05)
stg_cols = stg(y, x, 0.05)
%% Out-of-Sample Measure
% The final step is to use the columns selected by the different methods to 
% compute in-sample $\beta$ and then to evaluate these in-sample $\beta$ using 
% the out-of-sample data. 
% 
% I use a table to format output before showing it. 
%%
cols = {aic_cols, bic_cols, xval_cols, gts_cols, stg_cols};
oos_sse = zeros(5,1);
is_sse = zeros(5,1);
% Split the sample into eval and fit
eval_y = full_y(n/2+1:n) ;
eval_x = full_x(n/2+1:n, :);
fit_y = y(1:n/2);
fit_x = x(1:n/2, :);
% Loop across methods
for i = 1:5
    b = x(1:n/2, cols{i}) \ y(1:n/2);
    is_e = fit_y - fit_x(:, cols{i}) * b;
    is_sse(i) = is_e'*is_e;
    e = eval_y - eval_x(:, cols{i}) * b;
    oos_sse(i) = e'*e;
end
oos_r2 = 1 - oos_sse ./ (eval_y' * eval_y);
is_r2 = 1 - is_sse ./ (fit_y' * fit_y);
% Use a table to display results
names = {'AIC','BIC','X-Validation','GtS','StG'};
t = table(oos_sse, oos_r2, is_r2,  'RowNames',names,...
        'VariableNames',{'OutOfSample_SSE', 'OutOfSample_R2', 'InSample_R2'});
disp(t)
%% Full run
% We can now wrap the same code in a loop to execute across multiple configs. 
% 
% First I setup the configs for different 
%%
configs = {};
for strength = [0.5, 1]
    for rho = [0.2, 0.8]
        for r2 = [0.1, 0.2]
            configs = [configs;[strength, rho, r2]];
        end
    end
end
%% 
% The final step is to loop over the configs to run the models. |B| is the 
% number of runs of the simulation.  I keep it small so that this will run quickly 
% enough. 
% 
% The results are printed using a table.  I report three measures:
% 
% * The average in-sample SSE 
% * The average out-of-sample SSE
% * The average in-sample R2
% * The average out-of-sample R2
% * The average number of variables selected
% * The percentage of models that selected only the three relevant variables

B = 500;
for ii = 1:length(configs)
    c = configs{ii};
    strength = c(1);
    rho = c(2);
    r2 = c(3);
    
    oos_r2 = zeros(5,B);
    is_r2 = zeros(5,B);
    oos_sse = zeros(5,B);
    is_sse = zeros(5,B);
    num_var = zeros(5,B);
    correct_sel = zeros(5,B);
    for bb = 1:B
        [y, x] = generate_data(n, 3, 5, r2, strength, rho);
        full_y = y;
        full_x = x;
        fit_y = y(1:n/2);
        fit_x = x(1:n/2,:);
        eval_y = y(n/2+1:n);
        eval_x = x(n/2+1:n,:);        
        [aic, bic] = compute_ic(y,x,selection);
        aic_cols = selection{aic == min(aic)};
        bic_cols = selection{bic == min(bic)};
        gts_cols = gts(y,x,0.05);
        
        sse = kfold_cross_val(y,x,folds,selection);
        xval_cols = selection{sse == min(sse)};
        stg_cols = stg(y, x, 0.05);
        cols = {aic_cols, bic_cols, xval_cols, gts_cols, stg_cols};
        
        for i = 1:5
            b = fit_x(:, cols{i}) \ fit_y;
            e = fit_y - fit_x(:, cols{i}) * b;
            is_sse(i,bb) = e'*e;
            is_r2(i,bb) = 1 - is_sse(i,bb) / (fit_y'*fit_y);
            
            e = eval_y - eval_x(:, cols{i}) * b;
            oos_sse(i,bb) = e'*e;
            oos_r2(i,bb) = 1 - oos_sse(i,bb) / (eval_y'*eval_y);
            num_var(i,bb) = length(cols{i});
            correct_sel(i,bb) = isempty(setxor(cols{i},1:3));
        end
    end
    mean_sse = mean(oos_sse,2);
    disp('-------------------------------------------------------------')
    t = table(c(1),c(2), c(3), 'VariableNames',{'Strength', 'Rho', 'R2'});
    disp(t)
    disp('')
    disp(['Best selection is: ' names{mean_sse == min(mean_sse)}])
    disp('')
    t = table(mean_sse, mean(oos_r2,2), mean(is_sse,2), mean(is_r2,2), mean(num_var,2),mean(correct_sel,2),...
        'RowNames',names,...
        'VariableNames',{'OutOfSample_SSE', 'OutOfSample_R2', 'InSample_SSE', 'InSample_R2', 'NumVar', 'PrCorrect'});
    t = sortrows(t);
    disp(t)
end
%% Conclusions
% Overall these methods work well and the out-of-sample SSE is close to the 
% true one (125).  When 
% 
% Putting the results together, there are a few patterns that emerge:
% 
% * In-sample $R^2$ is always larger than out-of-sample $R^2$ , often substantially. 
% * AIC and cross validation tend to select larger models
% * When the regressor correlation is low then it is easier to get the correct 
% model.  
% * When strength is high (all $\beta$  are equal) ...
% * Overall the better selectors in this exercise were the looser ones, cross 
% validation and GtS.
% * When correlation is high, small models can work well since some of the information 
% in other regressors are in the small number of included regressors.
% 
% *Note* these is the dependent on this setup.  Other setups will provide 
% other rankings. This is in particular a simple exercise where the data are all 
% IID.  Adding dependence and heteroskedasticity may change these rankings.