% Sample Monte-Carlo simulation program for European vanilla call options
%
% call syntax: Euro_vanilla_call=MC_EurCall(S0,X,r,T,sigma,q,no_samples)
%
function Euro_vanilla_call=MC_EurCall(S0,X,r,T,sigma,q,no_samples)
% 
mu=r-q-sigma^2/2;
epsv=randn(no_samples,1);  % random standard normal numbers
ST=S0*exp(mu*T+epsv*sigma*sqrt(T));  % terminal prices in a vector
Euro_vanilla_call=exp(-r*T)*mean(max(ST-X,0)); % discounted expectation 
                                               % of the payoffs


