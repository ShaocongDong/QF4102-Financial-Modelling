%% File A3p1: Assignment 3 problem 1 script
%% ----------------------------------------------------------------------
%% European Vanilla Call:
% call FD_ids_call_trans(S0, X, r, q, T, sigma, I, N, xmax)

%% parameter setup:
S0 = 5.25;
X = 5;
sigma = 0.3;
q = 0.1;
r = 0.03;
xmax = 5;
N = 1500;
T = 1;
estimates = 100:100:1500;

%% -----------------------------------------------------------------------

%% American vanilla call with PSOR algorithm
% call FD_ids_Acall_trans(S0, X, r, q, T, sigma, I, N, xmax, omega, eps)

%% PSOR parameters setup:
omega = 1.3;
eps = 10^(-6);
index = 0;
%% Getting the estimates
for I = 100:100:1500
    index = index + 1;
    estimates(index) =...
        FD_ids_Acall_trans(S0, X, r, q, T, sigma, I, N, xmax, omega, eps);
end

%% Plot of estimates against I values
plot(100:100:1500, estimates, 'm-*');
legend('estimation of option value');
xlabel('value of parameter I');
ylabel('estimated value');
title('American Vanilla Call-Implicit Scheme with PSOR Algorithm');