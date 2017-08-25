% Black-Scholes formulae for European vanilla call
% call syntax: c = BS_call(S0, X, r, T, sigma, q)
function  c = bs_call(S0, X, r, T, sigma, q)
d1=(log(S0/X)+(r-q+sigma^2/2)*T)/sigma/sqrt(T);
d2=d1-sigma*sqrt(T);
c=exp(-q*T)*S0.*normcdf(d1)-exp(-r*T)*X*normcdf(d2);
return

