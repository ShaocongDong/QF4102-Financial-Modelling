% Finite Difference - fully implicit scheme for vanilla put options
%   calling syntax:
%   v=FD_ids_put(S0, X, r, T, sig, N, dS)
function fd_v=FD_ids_put(S0, X, r, T, sig, N, dS)
Smax=3*X;   % set maximum S to be three times the strike value
dt=T/N;
I=round(Smax/dS);
%
VGrid=zeros(I+1,N+1); % finite difference grid

% Boundary conditions
VGrid(1,:)=X*exp(-r*(T-(0:dt:T))); % at S=0;
VGrid(I+1,:)=0; % at Smax, unlikely to have positive payoff for large S

% Terminal condition
VGrid(:,N+1)=max(X-(0:I)*dS,0);

i=(1:I-1)';  isq=i.^2;
a= -0.5*(sig^2*isq - r*i)*dt;
b=(1 + sig^2*isq*dt + r*dt);
c= -0.5*(sig^2*isq + r*i)*dt;
CoeffMatrix=spdiags([c, b, a],-1:1, I-1, I-1)';

ishift=1;
for n=N:-1:1  % backward time recursive
    RhsB=VGrid(i+ishift,n+1); 
    RhsB(1)  =RhsB(1)  -a(1)  *VGrid(0+ishift,n); 
    RhsB(I-1)=RhsB(I-1)-c(I-1)*VGrid(I+ishift,n);
    VGrid(i+ishift,n)=CoeffMatrix\RhsB;
end;      
ExactValue=Pe(S0,X,r,T,sig,0);
fd_v=VGrid(round(S0/dS)+ishift,1);
disp(['At S0=',num2str(S0),' exact value=',num2str(ExactValue),' FD value=',num2str(fd_v)]);

function y=Pe(S,X,r,t,sigma,q)

d1=(log(S/X)+(r-q+sigma*sigma/2)*t)/sigma/sqrt(t);
d2=d1-sigma*sqrt(t);
y=X*exp(-r*t)*normcdf(-d2)-S*exp(-q*t)*normcdf(-d1);
   
