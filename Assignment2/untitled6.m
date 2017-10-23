%%% Script for question 1 (i)

%% Variable settings
t = 0.25;
T = 0.5;
S0 = 100;
sigma = 0.4;
q = 0.01;
runningAvg = 95;
r = 0.1;
K = 100;

%% First round with rho=1, N = 50, 100, 200, 400
rho = 1;
for N = [50, 100, 200, 400]
    FSGMArithmeticComputation (t, T, S0, sigma, q, runningAvg, r, K, rho, N);
end