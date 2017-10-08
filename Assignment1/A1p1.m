%Group G04
%Dong Shaocong A0148008J
%He Xinyi A0141132B

% A1.1
% Question (iii)
% Parameter initialization
S0 = 7:0.1:10;
q = 0;
X = 6.5;
t = 0.5;
r = 0.02;
sigma = 0.3;


C01 = Euro_down_out_call(q, 7, S0, X, t, r, sigma);
a1 = plot(S0,C01,'r*-'); M1 = 'Down-and-Out with barrier equals 7';
hold on;
C02 = Euro_down_out_call(q, 6, S0, X, t, r, sigma);
a2 = plot(S0,C02, 'b*-');  M2 = 'Down-and-Out with barrier equals 6';
hold on;
C03 = Black_Scholes(t, S0, X, r, q, sigma);
a3 = plot(S0,C03, 'm*-');  M3 = 'European vanilla option black scholes value';
title('European Down-and-Out option Compared with Plain Vanilla');
xlabel('initial underlier price');
ylabel('option values');
legend([a1;a2;a3],M1,M2,M3);


figure;

% Question (iv)
% Parameter initialization
N = 210:1:250;
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
