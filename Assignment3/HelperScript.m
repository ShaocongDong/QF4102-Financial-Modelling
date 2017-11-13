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

%% Getting the estimates
for I = 100:100:1500
    index = round(I/100,0);
    estimates(index) =...
        FD_ids_call_trans(S0, X, r, q, T, sigma, I, N, xmax);
end

%% Plot of estimates against I values
plot(100:100:1500, estimates, 'm-*');
legend('estimation of option value');
xlabel('value of parameter I');
ylabel('estimated value');
title('European Vanilla Call-Implicit Scheme');
