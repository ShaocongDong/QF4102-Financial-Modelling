%Group G04
%Dong Shaocong A0148008J
%He Xinyi A0141132B
function opt_value = New_Euro_float_lookback_put(S0, r, T, sigma, q, N)
% Sample BTM program for European floating strike options

% q: the continuous dividend rate
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
jshift = 1; 
nshift = 1;
V = rand(N+1,N+1);
j = 0:1:N; 
V(j+jshift,N+nshift) = exp(j*dx)-1;

% backward recursive through time
for n = N-1:-1:0
    V(0+jshift,n+nshift) = df*(p*u*V(0+jshift,n+1+nshift)...
        + (1-p)*d*V(1+jshift, n+1+nshift));
    for j = 1:1:n
        V(j+jshift,n+nshift) = df*(p*u*V(j-1+jshift,n+1+nshift)...
            + (1-p)*d*V(j+1+jshift, n+1+nshift));
    end
end
%
opt_value=S0*V(0+jshift, 0+nshift);
end