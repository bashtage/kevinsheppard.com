function ll = std_studentst_loglike(nu,x)

% Avoid very large values and problems with exp
if nu<50
    nu = 2 + exp(nu);
else
    nu = 50 + log(nu);
end

lls = gammaln((nu+1)/2)-gammaln(nu/2)-(1/2)*log(pi*(nu-2))-((nu+1)/2)*log(1+x.^2/(nu-2));
ll = -1*sum(lls);