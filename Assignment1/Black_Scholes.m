%Group G04
%Dong Shaocong A0148008J
%He Xinyi A0141132B
function c = Black_Scholes (t, S0, X, r, q, sigma)
% t: time to maturity
% S0: the current spot price of the underlying asset
% X: the strike price
% r: the risk free rate
% q: continuous dividend yield
% sigma: the volatility of the underlying asset's return
% One can also directly use the normcdf to calculate the N value
d1=(log(S0/X)+(r-q+sigma^2/2)*t)/sigma/sqrt(t);
d2=d1-sigma*sqrt(t);
c=exp(-q*t)*S0.*normcdf(d1)-exp(-r*t)*X*normcdf(d2);
return
end



