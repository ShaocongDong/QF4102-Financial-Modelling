function FSGMLookbackComputation (t, T, S0, sigma, q, runningMin, r, K, N)
 %% Meaning of the parameters of this function
 % t: time left to maturity measured in years
 % T: the total time to maturity from initiation
 % S0: the current underlier price
 % sigma: the underlier's volatility
 % q: the underlier's dividend yield
 % runningMin: The current running minimum
 % r: the market's risk free rate
 % K: the fixed strike price for this option
 % N: the number of time periods in lattice
 
 %% Actual working and displaying of message
 tic;
 optionValue = FSGMAmericanFixedLookbackPut(t, T, S0, sigma, q, runningMin, r, K, N);
 message = ['Option Value is: ', num2str(optionValue), ', number of time periods: ', num2str(N), ', and time used: '];
 display(message);
 toc;
 
end
