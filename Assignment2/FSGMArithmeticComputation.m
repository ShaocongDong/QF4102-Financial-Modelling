function FSGMArithmeticComputation (t, T, S0, sigma, q, runningAvg, r, K, rho, N)
 %% Meaning of the parameters of this function
 % t: time elapsed measured in years
 % T: the total time to maturity from initiation
 % S0: the current underlier price
 % sigma: the underlier's volatility
 % q: the underlier's dividend yield
 % runningAvg: The current running average
 % r: the market's risk free rate
 % K: the fixed strike price for this option
 % rho: the FSGM parameter
 % N: the number of time periods in lattice
 
 %% Actual working and displaying of message
 tic;
 optionValue = FSGMAmericanFixedArithmeticPut(t, T, S0, sigma, q, runningAvg, r, K, rho, N);
 message = ['Option Value is: ', num2str(optionValue), ', Rho is : ', num2str(rho), ', number of time periods: ', num2str(N), ', and time used: '];
 display(message);
 toc;
 
end
