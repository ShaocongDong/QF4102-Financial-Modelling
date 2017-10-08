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

