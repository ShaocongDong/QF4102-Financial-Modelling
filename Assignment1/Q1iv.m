% Parameter initialization
N = 210:1:250;
q = 0;
X = 6.5;
t = 0.5;
r = 0.02;
sigma = 0.3;
H = 6;
S0 = 8;

CdoN = rand(41,1);
for i = 1:41
    CdoN(i) = BTM_Euro_down_out_call(S0, X, r, t, sigma, q, N(i), H);
end
Cdo = Euro_down_out_call (q, H, S0, X, t, r, sigma);
error = CdoN-Cdo;
a1 = plot(N, error, 'm*-');   % mark each data point with an asterisk in red
ylabel('method error');
xlabel('Number of steps');
title('BTM error plot Down-and-Out call option');
legend([a1],'error');
