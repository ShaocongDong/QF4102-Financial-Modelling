% Sample BTM program for European vanilla call options
% call syntax: OptVal=btm_EurCall(S0,X,r,T,sigma,q,N)
function OptVal=btm_EurCall(S0,X,r,T,sigma,q,N)
% set up lattice parameters
dt=T/N; dx=sigma*sqrt(dt);
u=exp(dx); d=1/u;
df=exp(-r*dt);     % discount factor 
p=(exp((r-q)*dt)-d)/(u-d);  % risk-neutral probability
% initialization
j = 0:1:N;  jshift = 1; % range of index for price states
V(j+jshift)=max(S0*u.^(2*j-N)-X,0);
% backward recursive through time
for n=N-1:-1:0   
   j = 0:1:n; 
   V=df*(p*V(j+1+jshift)+(1-p)*V(j+jshift));
end
OptVal=V(0+jshift);


