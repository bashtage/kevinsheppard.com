function [b,tstat,s2,VCV,VCV_white,R2,R2bar,yhat]=ols(y,x,c)
% PURPOSE
%   Estimate coefficients using OLS and estimate VCV (standard and robust)
%
% USAGE
%   [b,tstat,s2,VCV,VCV_white,R2,R2bar,yhat]=ols(y,x,c)
%
% INPUTS:
%   y - T by 1 vector containing the independent variable
%   X - T by k matrix of regressors.  Should not contain a constant
%   c - Boolean indicating whether to add a constant to X
%
% OUTPUT:
%   b          - Parameter estimates
%   tstat      - T-stat using VCV
%   s2         - Estimated variance of residual (uses T, not T-1)
%   VCV        - Homoskedastic VCV
%   VCV_white  - White's Heteroskedasticity consistent VCV
%   R2         - R-squared
%   R2bar      - Degree of freedom adjusted R2
%   yhat       - Fit values
%
% COMMENTS:
%   This is an example of a useful help file

% Length of data
n = length(y);
% Number of regressors
k = size(x,2);
% Add constant if needed
if c
    x = [ones(n,1) x];
    k = k + 1;
end

% Compute OLS coefficients
b = x\y;
% Compute fitted values
yhat = x*b;
% Compute errors
e = y - yhat;
% Compute s2
s2 = e'*e/n;
% Compute (X'*X)^(-1) for use in 2 places
XpXi = inv(x'*x/n);
% Matlab gives a warning, and wants me to use
% XpXi = (x'*x/n)\eye(k);
% Compute homoskedastic VCV
VCV = s2 * XpXi/n;
% Compute t-stat using homoskedastic VCV
tstat = b./sqrt(diag(VCV));

% Middle of sandwich 
XEX = zeros(k);
% Loop, can be done without a loop, but less clear
for i=1:n
    XEX = XEX + e(i,:).^2*x(i,:)'*x(i,:);
end
XEX = XEX/n;
% Non-loop way:
% xe = bsxfun(@times,x,e)
% XEX = xe'*xe/n
% White's VCV
VCV_white = XpXi * XEX * XpXi / n;

% Demean for TSS if has a constant
if c
    y = y-mean(y);
end
% Compute correct R2 and R2bar
R2 = 1 - (e'*e)/(y'*y);
R2bar = 1-(1-R2)*(n-1)/(n-k);
