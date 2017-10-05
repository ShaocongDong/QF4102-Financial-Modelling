S0 = 7:0.1:10;
C01 = Euro_down_out_call(0, 7, S0, 6.5, 0.5, 0.02, 0.3);
a1 = plot(S0,C01,'r*-'); M1 = 'Down-and-Out with barrier equals 7';
hold on;
C02 = Euro_down_out_call(0, 6, S0, 6.5, 0.5, 0.02, 0.3);
a2 = plot(S0,C02, 'b*-');  M2 = 'Down-and-Out with barrier equals 6';
hold on;
C03 = Black_Scholes(0.5, S0, 6.5, 0.02, 0, 0.3);
a3 = plot(S0,C03, 'm*-');  M3 = 'European vanilla option black scholes value';
title('European Down-and-Out option Compared with Plain Vanilla');
xlabel('option values');
ylabel('initial underlier price');
legend([a1;a2;a3],M1,M2,M3);

