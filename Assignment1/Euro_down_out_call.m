function opt_value = Euro_down_out_call (q, H, S0, X, t, r, sigma)
% Exact solution for European down-and-out call option
% This function is able to work with the intial underlier price S0 in a
% vector form; whereas the rest of the inputs are real numbers.

% Cdo: option price for the down-and-out call
% C: Black-Schole price for the equivalent vanilla call
% q: the continuous dividend rate
% H: the barrier level
% S0: current underlier price
% X: strike price
% t: time to matuirity, in years
% sigma: volatility of the underlier
% r: risk free interest rate

%Initialization
lambda = (r-q+sigma^2/2)/(sigma^2);  %constant
y = log((H^2/X)./S0)./(sigma*sqrt(t)) + lambda*sigma*sqrt(t);  %vector
x1 = log(S0./H)./(sigma*sqrt(t)) + lambda*sigma*sqrt(t);  %vector
y1 = log(H./S0)./(sigma*sqrt(t)) + lambda*sigma*sqrt(t);  %vector
C = Black_Scholes (t, S0, X, r, q, sigma);  %constant
%Cp = Black_Scholes (t, H^2./S0, X, r, q, sigma);  %vector

%Main Logic
if (H<X || H==X)
    opt_value = C - (S0.*exp(-q*t)).*(H./S0).^(2*lambda).*normcdf(y)...
        + (X*exp(-r*t)).*(H./S0).^(2*lambda-2).*normcdf(y-sigma*sqrt(t));
else
    opt_value = S0.*(normcdf(x1)*exp(-q*t))...
        - X*exp(-r*t)*normcdf(x1-sigma*sqrt(t))...
        - S0.*exp(-q*t).*(H./S0).^(2*lambda).*normcdf(y1)...
        + (X*exp(-r*t)).*(H./S0).^(2*lambda -2).*normcdf(y1-sigma*sqrt(t));
end
end

