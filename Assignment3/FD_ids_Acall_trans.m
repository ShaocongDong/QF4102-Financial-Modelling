%% Finite Difference - fully implicit scheme for:
%  transformed European vanilla call options
%   calling syntax:
%   v=FD_ids_call_trans(S0, X, r, q, T, sigma, I, N, xmax)
%function fd_v=FD_ids_put(S0, X, r, T, sig, N, dS)

function OptVal=FD_ids_Acall_trans(S0, X, r, q, T, sigma, I, N, xmax, omega, eps)
%% Initialization
dt = T/N;
dx = xmax/I; % as defined in the question
VGrid=zeros(2*I+1,N+1); % finite difference grid (-xmax, xmax) so 2*I+1

%% Boundary conditions
VGrid(1,:) = 0; % at -xmax, too small stock price, value 0
VGrid(2*I+1,:) = exp(xmax)*exp(-q*(T-(0:dt:T))) - X*exp(-r*(T-(0:dt:T)));

%% Terminal condition
VGrid(:,N+1)=max((exp(-xmax:dx:xmax)-X), 0); % for every possible x

%% Looping and parameters setup
alpha = sigma^2*dt/(dx^2);
a = (-alpha/2) * ones(2*I-1,1);
b = (1 + alpha + (r-q-sigma^2/2)*dt/dx + r*dt) * ones(2*I-1,1);
c = (-alpha/2 - (r-q-sigma^2/2)*dt/dx) * ones(2*I-1,1);
CoeffMatrix=spdiags ([c, b, a],-1:1, 2*I-1, 2*I-1)';
priceVector = exp(-xmax:dx:xmax)';

%% Loop
ishift=1;
for n=N:-1:1  % backward time recursive
    
    RhsB = VGrid(1+ishift:2*I-1+ishift, n+1);
    RhsB(1)  =RhsB(1) -a(1)*VGrid(0+ishift,n);
    RhsB(2*I-1)=RhsB(2*I-1)-c(2*I-1)*VGrid(2*I+ishift,n);
    VGrid(1+ishift:2*I-1+ishift,n)=...
        sor(CoeffMatrix, CoeffMatrix\RhsB, RhsB, 2*I-1, omega, eps);
    payoffVector = (priceVector(1+ishift:2*I-1+ishift)-X) * exp(-r*dt*n);
    VGrid(1+ishift:2*I-1+ishift,n) =...
        max(VGrid(1+ishift:2*I-1+ishift,n), payoffVector);
    
end;

%% Linear Interpolation and Value comparisons
ExactValue=Ce(S0,X,r,T,sigma,q);
lower_index = floor(round(log(S0)/dx,1)) + I;
higher_index = lower_index+1;
Low_Val=VGrid(lower_index+ishift,1);
High_Val=VGrid(higher_index+ishift,1);
OptVal = LinearInterpolate(S0, exp(lower_index*dx-xmax),...
    exp(higher_index*dx-xmax), Low_Val, High_Val);
disp(['At S0=',num2str(S0),' exact value=',...
    num2str(ExactValue),' FD value=',num2str(OptVal)]);
end

function y=Ce(S,X,r,t,sigma,q)
%% European vanilla call exact value solution
d1=(log(S/X)+(r-q+sigma*sigma/2)*t)/sigma/sqrt(t);
d2=d1-sigma*sqrt(t);
y=-X*exp(-r*t)*normcdf(d2)+S*exp(-q*t)*normcdf(d1);
end

function sol = LinearInterpolate(x, x0, x1, f0, f1)
%% Linear interpolation function
sol = (x - x1) / (x0 - x1) * f0 + (x - x0) / (x1 - x0) * f1;
end

function x = sor(A, x0, b, n, epsilon, omega)
%% Function for sor iterative algorithm
converged = false;
disp('In side sor');
xK = x0;
while(converged == false)
    xKplus = zeros(n,1);
    
    for i = 1:1:n
        
        % Calculate summation product a*x
        sum1 = 0;
        sum2 = 0;
        for j = 1:1:i-1
            sum1 = sum1 + A(i, j) * xKplus(j);
        end
        for j = i+1:1:n
            sum2 = sum2 + A(i, j) * xK(j);
        end
        % Update to the next round
        xgsKplus = 1/A(i,i) * (-sum1 - sum2 + b(i));
        xKplus(i) = (1-omega)*xK(i) + omega*xgsKplus;
    end
    
    % Test for convergence
    if (sqrt((xKplus - xK).*(xKplus - xK)) < epsilon)
        converged = true;
    end
    xK = xKplus;
end
x = xK;
end

