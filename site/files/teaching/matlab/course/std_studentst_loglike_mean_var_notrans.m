function ll = std_studentst_loglike_mean_var_notrans(parameters,x)

mu = parameters(1);
sigma2 = parameters(2);
nu = parameters(3);

lls = gammaln((nu+1)/2)-gammaln(nu/2)...
    -(1/2)*log(pi*(nu-2))-0.5*log(sigma2)...
    -((nu+1)/2)*log(1+(x-mu).^2/(sigma2*(nu-2)));
ll = -1*sum(lls);