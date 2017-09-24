S0 = 7:0.1:10;
C01 = Euro_down_out_call(0, 7, S0, 6.5, 0.5, 0.02, 0.3);
plot(S0,C01,'r*-');   % mark each data point with an asterisk in red
hold on;
C02 = Euro_down_out_call(0, 6, S0, 6.5, 0.5, 0.02, 0.3);
plot(S0,C02, 'b*-');  % mark each data point with an asterisk in blue
hold on;
C03 = Black_Scholes(0.5, S0, 6.5, 0.02, 0, 0.3);
plot(S0,C03, 'm*-');  % mark each data point with an asterisk in yellow