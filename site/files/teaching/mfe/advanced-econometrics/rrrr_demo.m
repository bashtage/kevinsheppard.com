%% Reduced Rank Regression
% A simple demo of hwo to implement reduced rank regression

% A small simulation that shows how reduced rank regression works
% Time
T = 1000;
% Number of x
k = 100;
% Number of factors
r = 3;
% Factors
f = randn(T,r);
% Number of y
m = 5;
% Factor loadings for x
lambda = 1+randn(r,k);
% x simulation
x = f*lambda + randn(T,k);
% Factor loadings for y
lambda_y = 1+randn(r,m);
% Y data
y =  f*lambda_y + randn(T,m);
% ovariance of y and x
Sigma = cov([y,x]);
% Last k rows, first m columns
SigmaXY = Sigma(m+1:m+k,1:m);
% X block in last k rows/columns
SigmaXX = Sigma(m+1:m+k,m+1:m+k);
% Set up generalized eigenvalue problem
W = eye(m);
% Same notaiton as in notes
A = SigmaXY*W*SigmaXY';
B = SigmaXX;
% Solve problem
[V,D] = eig(A,B);
% Sort from largest to smallest
d = diag(D);
[~,ind] = sort(d,'descend');
% Reorder V to match d
V = V(:,ind);
% Estimated factors
f_hat = x*V(:,1:r);
alpha = [ones(T,1) f_hat]\y;
% R2 of estimated factors on actual factors
e = f_hat - f*(f\f_hat);
% Compute R2
R2 = 1 - sum(sum(e.^2)) / sum(sum(f_hat.^2));
% Should be high >95%
disp(R2)

%% Reduced Rank Regularized Regression
% Identical to previous, only used principal components of X

% Choose too many
rf = 6;
[~,comp]=pca(x);
comp = comp(:,1:rf);
% ovariance of y and x
Sigma = cov([y,comp]);
% Last rf rows, first m columns
SigmaXY = Sigma(m+1:m+rf,1:m);
% X block in last rf rows/columns
SigmaXX = Sigma(m+1:m+rf,m+1:m+rf);
% Set up generalized eigenvalue problem
W = eye(m);
% Same notaiton as in notes
A = SigmaXY*W*SigmaXY';
B = SigmaXX;
% Solve problem
[V,D] = eig(A,B);
% Sort from largest to smallest
d = diag(D);
[~,ind] = sort(d,'descend');
% Reorder V to match d
V = V(:,ind);
% Estimated factors
f_hat = comp*V(:,1:r);
alpha = [ones(T,1) f_hat]\y;
% R2 of estimated factors on actual factors
e = f_hat - f*(f\f_hat);
% Compute R2
R2 = 1 - sum(sum(e.^2)) / sum(sum(f_hat.^2));
% Should be very high, usually around 99% - Extra restrictions increase fit
% by focusing attention
disp(R2)

%% Reduced Rank Regularized Regression - Increase rf
% Mild increase in rf doesn't affect results

% Choose too many
rf = 10;
[~,comp]=pca(x);
comp = comp(:,1:rf);
% ovariance of y and x
Sigma = cov([y,comp]);
% Last rf rows, first m columns
SigmaXY = Sigma(m+1:m+rf,1:m);
% X block in last rf rows/columns
SigmaXX = Sigma(m+1:m+rf,m+1:m+rf);
% Set up generalized eigenvalue problem
W = eye(m);
% Same notaiton as in notes
A = SigmaXY*W*SigmaXY';
B = SigmaXX;
% Solve problem
[V,D] = eig(A,B);
% Sort from largest to smallest
d = diag(D);
[~,ind] = sort(d,'descend');
% Reorder V to match d
V = V(:,ind);
% Estimated factors
f_hat = comp*V(:,1:r);
alpha = [ones(T,1) f_hat]\y;
% R2 of estimated factors on actual factors
e = f_hat - f*(f\f_hat);
% Compute R2
R2 = 1 - sum(sum(e.^2)) / sum(sum(f_hat.^2));
% Should be very high, usually around 99% - Extra restrictions increase fit
% by focusing attention
disp(R2)