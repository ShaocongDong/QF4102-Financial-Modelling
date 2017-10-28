function fd_v=EDSiiiAmericanVanillaCall(S0, X, r, q, T, sig, dt, dS)

%% Meanings of the parameters
% S0: the current underlier price
% X: 
% r: the market's risk free rate
% q: the underlier's dividend yield
% T: the time to maturity of this option
% sig: vollatility of the underlier price
% dt: the small interval of time
% dS: the small interval of underlier price

%% Initial set up
Smax=4*X;   % set maximum S to be four times the strike value
N = round(T/dt);
I = round(Smax/dS);

VGrid=zeros(I+1,N+1); % finite difference grid
ishift=1; 

%% Conditions
% Boundary conditions
VGrid(1,:)=0; % at S=0;
VGrid(I+1,:)=(Smax-X)*exp(-r*(T-(0:dt:T))); % at Smax, unlikely to have positive payoff for large S

% Terminal condition
VGrid(:,N+1)=max((0:I)*dS-X,0);

i=(1:I-1)';  isq=i.^2;

%% Explicit Scheme III
c=(0.5*sig^2*isq+(r-q)*i)*dt/(1+r*dt);
b=(1-sig^2*isq*dt-(r-q)*i*dt)/(1+r*dt);
a=(0.5*sig^2*isq)*dt/(1+r*dt);

% Check on monotonicity
len01=length(a);
len02=length(find(a<0));
% disp(['Coeff a, Of ',num2str(len01), ' elements, ', num2str(len02),' violated the positivity condition.']);
len01=length(b);
len02=length(find(b<0));
% disp(['Coeff b, Of ',num2str(len01), ' elements, ', num2str(len02),' violated the positivity condition.']);
len01=length(c);
len02=length(find(c<0));
% disp(['Coeff c, Of ',num2str(len01), ' elements, ', num2str(len02),' violated the positivity condition.']);

i=(1:I-1)'+ishift;

for n=N:-1:1  % backward time recursive
    VGrid(i,n)=max(a.*VGrid(i-1,n+1)+b.*VGrid(i,n+1)+c.*VGrid(i+1,n+1), (((i-ishift)*dS-X))*exp(-r*n*dt));
end

ExactValue=Ce(S0,X,r,T,sig,q);
fd_v=VGrid(round(S0/dS)+ishift,1);
% disp(['At S0=',num2str(S0),' exact value=',num2str(ExactValue),' FD value=',num2str(fd_v)]);


end

function y=Ce(S,X,r,t,sigma,q)

d1=(log(S/X)+(r-q+sigma*sigma/2)*t)/sigma/sqrt(t);
d2=d1-sigma*sqrt(t);
%y=X*exp(-r*t)*normcdf(-d2)-S*exp(-q*t)*normcdf(-d1);
y = S*normcdf(d1) - normcdf(d2)*X*exp(-r*t);

end

