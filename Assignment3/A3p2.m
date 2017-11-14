%% File A3p1: Assignment 3 problem 2 script
%% ----------------------------------------------------------------------
%% Digital call option without control variate:
% call: MC_noCV=MC_3AssetMD(S0, X, sigma, C, r, q, T, no_samples)

%% parameter setup:
S0 = [9.5;10.2;8.8];
sigma = [0.35;0.21;0.18];
q = [0.01;0.04;0];
C = [1,0.88,0.17;0.88,1,0.34;0.17,0.34,1];
r = 0.05;
T = 0.75;
estimates = zeros(30,1);
sd1 = zeros(12,1);
index = 1;
%% Itarate through all X, number of samples each with 30 rounds
for X = [8.5, 9.5, 10.5]
    for no_samples = [100, 1000, 10000, 100000]
        for i=1:1:30
            estimates(i) = MC_3AssetMD(S0, X, sigma, C, r, q, T, no_samples);
        end
        disp(['no=',num2str(no_samples) ,' X=', num2str(X), ' Estimate', num2str(mean(estimates)), ' Standard error', num2str(var(estimates)^(0.5))]);
        sd1(index) = var(estimates)^(0.5);
        index = index + 1;
    end
end

%% ----------------------------------------------------------------------
%% Digital call option without control variate:
% call MC_3AssetMD_CV(S0, X, sigma, C, r, q, T, no_samples)

sd2 = zeros(12,1);
index = 1;

%% Itarate through all X, number of samples each with 30 rounds
for X = [8.5, 9.5, 10.5]
    for no_samples = [100, 1000, 10000, 100000]
        for i=1:1:30
            estimates(i) = MC_3AssetMD_CV(S0, X, sigma, C, r, q, T, no_samples);
        end
        disp(['no=',num2str(no_samples) ,' X=', num2str(X), ' Estimate', num2str(mean(estimates)), ' Standard error', num2str(var(estimates)^(0.5))]);
        sd2(index) = var(estimates)^(0.5);
        index = index + 1;
    end
end

sd1plot = plot(sd1, 'm-*');
% legend(sd1plot, 'STD without control variate');
hold on;
sd2plot = plot(sd2, 'b-*');
legend([sd1plot, sd2plot], 'STD without control variate', 'STD with control variate');

xlabel('the nth round');
ylabel('STD');
title('STD comparison between Monte Carlo method with and without control variate');





