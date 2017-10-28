% For Assignment 2 problem 2 implementation
S0 = 9.8;
X = 9;
r = 0.001;
q = 0.01;
T = 0.25;
sig = 0.15;

dS = 0.05;
%% question i
dt = 0.01;
disp('-----question i----- dt = 0.01 Euro');
EDSiiiEuropeanVanillaCall(S0, X, r, q, T, sig, dt, dS);

%% question iii
N = 2915;
dt = T/N;
disp('-----question iii----- N = 2915 Euro');
EDSiiiEuropeanVanillaCall(S0, X, r, q, T, sig, dt, dS);

%% question iv
disp('-----question iv----- Finding cut-off value Euro');
Nmax = 2915;
%A2qiv(S0, X, r, q, T, sig, dS, Nmax);
%% question v
disp('-----question v----- N = 2915 American');
EDSiiiAmericanVanillaCall(S0, X, r, q, T, sig, dt, dS);
