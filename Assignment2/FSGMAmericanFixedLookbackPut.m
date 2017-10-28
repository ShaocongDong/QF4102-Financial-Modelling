function optValue = FSGMAmericanFixedLookbackPut(t, T, S0, sigma, q, runningMin, r, K, N)

%% Meaning of the parameters of this function
% t: time elapsed measured in years
% T: the total time to maturity from initiation
% S0: the current underlier price
% sigma: the underlier's volatility
% q: the underlier's dividend yield
% runningMin: The current running minimum
% r: the market's risk free rate
% K: the fixed strike price for this option
% N: the number of time periods in lattice
% rho: In this function, we assume rho = 1 for lookback options

%% Initial set up of parameters

dt = (T - t)/N;
dx = sigma * sqrt(dt);
u = exp(dx);
d = exp(-dx);
p = (exp((r-q)*dt) - d) / (u-d);

runningMin = min(runningMin, S0); % the current running minimum

Minimum = zeros(2*N+1, 1); % the minimum vector that will be fixed after initialization
jshift = 1; % the j offset
kshift = N + 1; % the k offset

for k = (-N):1:(N)
    Minimum(k + kshift) = runningMin * exp(k*dx);
end

%% Initialization
Vtemp = zeros(1, 2*N+1);
for k = (-N):1:(N)
    Vtemp(1, k+kshift) = max((K - Minimum(k+kshift)), 0);
end
V = repmat(Vtemp, N+1, 1);

%% Algorithm: looping
for n = (N-1):-1:0 % for every time state
    
    Vtemp = zeros(n+1, 2*n+1); % the temprary matrix V for the current time state
    
    for j = n:-1:0 % for every price state
        
        S = S0 * exp((2 * j - n) * dx); % the current price state
        
        for k = (-n):1:(n) % for every running Min
            
            A = Minimum(k+N+1); % the current running Min
            
            % up branch ---- for j+1
            Aup = min(S * u, A); % calculated new running min when moving to the up branch
            kfloor = round(log(Aup / runningMin) / dx, 0); % the calculated floor index
            
            % kfloor2 = min(k, 2*j-n+1);
            
            kfloor_index = kfloor + (n + 1) + 1;
            Vup = V(j+1+jshift, kfloor_index);
            
            % down branch ----- for j
            Adown = min(S * d, A); % calculated new running min when moving to the down branch
            kfloor = round(log(Adown / runningMin) / dx, 0); % the calculated floor index
            
            % kfloor2 = min(k, 2*j-n-1);
            
            kfloor_index = kfloor + (n + 1) + 1;
            Vdown = V(j+jshift, kfloor_index);
            
            Vtemp(j+jshift, k+n+1) = max(exp(-r * dt) * (p * Vup + (1 - p) * Vdown), (K-A));
            
        end
    end
    
    V = Vtemp;
    
end

optValue = max(V(1,1), (K-runningMin));

end
