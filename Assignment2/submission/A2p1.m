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
    tic;
    optionValue = FSGMAmericanFixedArithmeticPut(t, T, S0, sigma, q, runningAvg, r, K, rho, N);
    message = ['Option Value is: ', num2str(optionValue), ', Rho is : ', num2str(rho), ', number of time periods: ', num2str(N), ', and time used: '];
    display(message);
    toc;
end

%% First round with rho=1/2. N = 50, 100, 200, 400
rho = 0.5;
for N = [50, 100, 200, 400]
    tic;
    optionValue = FSGMAmericanFixedArithmeticPut(t, T, S0, sigma, q, runningAvg, r, K, rho, N);
    message = ['Option Value is: ', num2str(optionValue), ', Rho is : ', num2str(rho), ', number of time periods: ', num2str(N), ', and time used: '];
    display(message);
    toc;
end

%% First round with rho=1/5. N = 50, 100, 200, 400
rho = 0.2;
for N = [50, 100, 200, 400]
    tic;
    optionValue = FSGMAmericanFixedArithmeticPut(t, T, S0, sigma, q, runningAvg, r, K, rho, N);
    message = ['Option Value is: ', num2str(optionValue), ', Rho is : ', num2str(rho), ', number of time periods: ', num2str(N), ', and time used: '];
    display(message);
    toc;
end

%%% Script for question 1 (ii)

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
    tic;
    optionValue = FSGMAmericanFixedLookbackPut(t, T, S0, sigma, q, runningMin, r, K, N);
    message = ['Option Value is: ', num2str(optionValue), ', number of time periods: ', num2str(N), ', and time used: '];
    display(message);
    toc;
end

%% Second round with runningMin = 0.57;
runningMin = 0.57;
for N = 50:50:500
    tic;
    optionValue = FSGMAmericanFixedLookbackPut(t, T, S0, sigma, q, runningMin, r, K, N);
    message = ['Option Value is: ', num2str(optionValue), ', number of time periods: ', num2str(N), ', and time used: '];
    display(message);
    toc;
end



