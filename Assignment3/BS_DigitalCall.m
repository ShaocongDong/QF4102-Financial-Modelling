%% Function for exact solution of digital option
% Call syntax:

function OptVal=BS_DigitalCall(S0, X, r, q,  T, sigma)
x = (log(S0/X)+(r-q-sigma^2/2)*T) / (sigma*sqrt(T));
OptVal = exp(-r*T)*normcdf(x);
end