function EU = expected_utility(mu_prime,EW_1,gamma)
% Computes a taylor-expanded version of CRRA
%
%  INPUTS
%    mu_prime - 5 by 1 vector of [1 E[r-mu] E[(r-mu)^2] ... E[(r-mu)^4]]'
%    EW_1     - Expected wealth next period, W_0 * (1+mu)
%    gamma    - Coefficient of Relative Risk Aversion 
% 
%  OUTPUTS
%    EU        - Expected utility
%
%  NOTES
%    CRRA utility is given by
%               U(W) = W^(1-gamma)/(1-gamma)
%
%    Log utility when gamma = 1.  Probably unreliable for gamma close to 1 
%    (e.g 0.9<=gamma<=1.1).


if gamma ~= 1
    phi_0 = EW_1^(1 - gamma)/(1- gamma);
else
    phi_0 = log(EW_1);
end
phi_1 = EW_1^(-gamma);
phi_2 = -gamma * phi_1 * EW_1^(-1);
phi_3 = (-gamma-1) * phi_2 * EW_1^(-1);
phi_4 = (-gamma-2) * phi_3 * EW_1^(-1);
scales = factorial(0:4).^(-1);
phi = scales .* [phi_0 phi_1 phi_2 phi_3 phi_4];
EU = phi*mu_prime;