function opt_value = Old_Euro_float_lookback_put(S0, r, T, sigma, q, N, running)
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
x0 = log(max(S0,running)/S0);
k = floor(x0/dx);

% initialization
jshift = 1; 
nshift = 1;
initial = max(k-N,0);
V = rand(k+N+2,N+1);
j = initial:1:(k+N+1); 
V(j+jshift,N+nshift) = exp(j*dx)-1;

% backward recursive through time
for n = N-1:-1:0
    if (k-n <= 0)
        V(0+jshift,n+nshift) = df*(p*u*V(0+jshift,n+1+nshift)...
            + (1-p)*d*V(1+jshift, n+1+nshift));
    end
    for j = max((k-n),1):1:(k+n+1)
        V(j+jshift,n+nshift) = df*(p*u*V(j-1+jshift,n+1+nshift)...
            + (1-p)*d*V(j+1+jshift, n+1+nshift));
    end
end
% interpolation
y1=S0*V(k+jshift, 0+nshift);
y2=S0*V(k+1+jshift, 0+nshift);
x1=k*dx;
x2=(k+1)*dx;
opt_value = ((x0-x2)/(x1-x2))*y1 + ((x0-x1)/(x2-x1))*y2;
end