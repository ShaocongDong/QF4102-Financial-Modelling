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
beta = dt*(r-q-sigma^2/2)/(2*dx);
a = (beta - alpha/2) * ones(2*I+1,1);
b = (1 + alpha + r*dt) * ones(2*I+1,1);
c = (-alpha/2 - beta) * ones(2*I+1,1);
%CoeffMatrix=spdiags ([c, b, a],-1:1, 2*I-1, 2*I-1)';
priceVector = exp(-xmax:dx:xmax)';

%% Loop
ishift=1;
for n=N:-1:1  % backward time recursive
    
    %RhsB = VGrid(1+ishift:2*I-1+ishift, n+1);
    %RhsB(1)  =RhsB(1) -a(1)*VGrid(0+ishift,n);
    %RhsB(2*I-1)=RhsB(2*I-1)-c(2*I-1)*VGrid(2*I+ishift,n);
    payoffVector = (priceVector(:)-X) * exp(-r*dt*n);
    VGrid(:,n)=...
        psor(I, a, b, c, 0, 1, 0, VGrid(:, n+1),...
        eps, omega, payoffVector);
        %sor(CoeffMatrix, CoeffMatrix\RhsB, RhsB, 2*I-1, omega, eps);
    
    %VGrid(1+ishift:2*I-1+ishift,n) = max(VGrid(1+ishift:2*I-1+ishift,n), payoffVector);
    
end;

%% Linear Interpolation and Value comparisons
lower_index = floor(round(log(S0)/dx,1)) + I;
higher_index = lower_index+1;
Low_Val=VGrid(lower_index+ishift,1);
High_Val=VGrid(higher_index+ishift,1);
OptVal = LinearInterpolate(S0, exp(lower_index*dx-xmax),...
    exp(higher_index*dx-xmax), Low_Val, High_Val);
disp(['At S0=',num2str(S0), ' FD value=',num2str(OptVal)]);
end

function sol = LinearInterpolate(x, x0, x1, f0, f1)
%% Linear interpolation function
sol = (x - x1) / (x0 - x1) * f0 + (x - x0) / (x1 - x0) * f1;
end

function Vn = psor(I, a, b, c, alp, bet, gam, Vnplus, eps, omega, fai)
%% Function for psor iterative algorithm
converged = false;
Vk = Vnplus;
Vkplus = Vk;
while (converged == false)
    Vgs = zeros(2*I+1,1);
    for i=2:1:2*I % compute iterate k+1
        Vgs(i) = 1/b(i) * (-a(i)*Vkplus(i-1) - c(i)*Vk(i+1)...
            + alp*Vnplus(i-1) + bet*Vnplus(i) + gam*Vnplus(i+1));
        Vkplus(i) = max(((1-omega)*Vk(i) + omega*Vgs(i)), fai(i));
    end
    if (sqrt(((Vkplus-Vk).*(Vkplus-Vk))) < eps)
        converged = true;
    end
    Vk = Vkplus;
end
Vn = Vk;
end

