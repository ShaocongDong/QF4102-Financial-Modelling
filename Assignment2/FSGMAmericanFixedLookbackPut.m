function optValue = FSGMAmericanFixedLookbackPut(t, T, S0, sigma, q, runningMin, r, K, N)
 
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
 % rho: In this function, we assume rho = 1
 
 %% Initial set up of parameters
 
 dt = t/N;
 dx = sigma * sqrt(dt);
 u = exp(dx);
 d = exp(-dx);
 p = (exp((r-q)*dt) - d) / (u-d);
 
 elapsedTime = T - t;
 elapsedPeriods = elapsedTime / dt;
 % currentPeriods = elapsedPeriods + 1;
 runningMin = min(runningMin, S0);
 
 Average = zeros(2*N+1); 
 jshift = 1;
 kshift = N + 1;
 
 for k = (-N):1:(N)
    Average(k + kshift) = S0 * exp(k*dx);
 end
 
 %% Initialization
 V = zeros(N+1, 2*N+1);
 for j = 0:1:N
    for k = (-N):1:(N)
        V(j+jshift, k+kshift) = max((K - Average(k+kshift)), 0);
    end
 end
 
 %% Algorithm: looping
 for n = (N-1):-1:0
    for j = 0:1:n
        for k = (-n):1:(n)
        
            % Set ups for this round
            S = S0 * exp((2 * j - n) * dx);
            % n = nl + elapsedPeriods;
            A = Average(k+kshift);
            
            Aup = min(S * u, A);
            kfloor = floor(log(Aup / S0) / dx);
            kfloor_index = max(kfloor + (n + 1) + 1,1);
            Vup = V(j+1+jshift, kfloor_index);

            Adown = min(S * d, A);
            kfloor = floor(log(Adown / S0) / dx);
            kfloor_index = max(kfloor + (n + 1) + 1,1);
            Vdown = V(j+jshift, kfloor_index);            
           
            V(j+jshift, k+kshift) = max(exp(-r * dt) * (p * Vup + (1 - p) * Vdown), (K-A));
            
        end
    end
 end
 
 optValue = max(V(0+jshift, 0+kshift), (K-runningMin));
 
end
