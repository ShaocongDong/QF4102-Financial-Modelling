function opt_value = BTM_Euro_down_out_call(S0, X, r, T, sigma, q, N, H)
% Sample BTM program for European down and out call options

% q: the continuous dividend rate
% H: the barrier level
% S0: current underlier price
% X: strike price
% T: time to maturity, in years
% sigma: volatility of the underlier
% r: risk free interest rate
% N: number of periods

% set up lattice parameters
dt=T/N; dx=sigma*sqrt(dt);
u=exp(dx); d=1/u;
df=exp(-r*dt);
p=(exp((r-q)*dt)-d)/(u-d);

% initialization
jshift = 1; V = rand(N+1,1);
for j = 0:1:N
    price = S0*u^(2*j-N);
    if (price<H)
        V(j+jshift) = 0;
    else
        V(j+jshift) = max(price - X,0);
    end
end

% backward recursive through time
for n = N-1:-1:0
    for j = 0:1:n
        price = S0*u^(2*j-n);
        if (price<H)
            V(j+jshift) = 0;
        else
            V(j+jshift) = df*(p*V(j+1+jshift) + (1-p)*V(j+jshift));
        end
    end
end
%
opt_value=V(0+jshift);
end