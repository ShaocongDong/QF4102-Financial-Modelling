%%% Script for question 1 (i)

%% Variable settings
t = 0.25;
T = 0.5;
S0 = 1;
sigma = 0.4;
q = 0.01;
r = 0.1;
K = 0.95;

%% First round with runningMin = 0.97;
runningMin = 0.97;
for N = 50:50:500
    FSGMLookbackComputation (t, T, S0, sigma, q, runningMin, r, K, N);
    break;
end

%% Second round with runningMin = 0.57;


