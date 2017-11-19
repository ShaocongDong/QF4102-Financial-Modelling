%% Finite Difference - fully implicit scheme for:
%  transformed American vanilla call options
%   calling syntax:
%   v=FD_ids_Acall_trans(S0, X, r, q, T, sigma, I, N, xmax, omega, eps)

function OptVal=FD_ids_Acall_trans(S0, X, r, q, T, sigma, I, N, xmax, omega, eps)
%% Initialization
dt = T/N;
dx = xmax/I; % as defined in the question

%% Looping and parameters setup
alpha = sigma^2*dt/(dx^2);
beta = dt*(r-q-sigma^2/2)/(2*dx);
a = (beta - alpha/2);
b = (1 + alpha + r*dt);
c = (-alpha/2 - beta);
%CoeffMatrix=spdiags ([c, b, a],-1:1, 2*I-1, 2*I-1)';
priceVector = exp(-xmax:dx:xmax)';
payoffVector = max((priceVector(:)-X), 0);
VGrid = payoffVector;

%% Loop
ishift=1;
for n=N:-1:1  % backward time recursive

    VGrid = psor(I, a, b, c, VGrid, eps, omega, payoffVector);

end;

%% Linear Interpolation and Value comparisons
lower_index = floor(log(S0)/dx) + I;
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

function Vn = psor(I, a, b, c, Vnplus, eps, omega, fai)
%% Function for psor iterative algorithm
converged = false;
Vk = Vnplus;
Vkplus = Vk;
Vgs = Vkplus;
while (converged == false)
    
    for i=2:1:2*I-1 % compute iterate k+1
        Vgs(i) = 1/b * (-a*Vkplus(i-1) - c*Vk(i+1) + Vnplus(i));
        Vkplus(i) = max(((1-omega)*Vk(i) + omega*Vgs(i)), fai(i));
    end
    if ((norm(Vk-Vkplus)) < eps)
        converged = true;
    end
    Vk = Vkplus;
end
Vn = Vk;
end

