% For Assignment 2 problem 2 implementation
S0 = 9.8;
X = 9;
r = 0.001;
q = 0.01;
T = 0.25;
sig = 0.15;
dt = 0.00001;
dS = 0.05;
%% question i

EDSiiiEuropeanVanillaCall(S0, X, r, q, T, sig, dt, dS);

%% question ii
N = 1;
dt = T/N;

%% question iii


%% question iv


%% question v
EDSiiiAmericanVanillaCall(S0, X, r, q, T, sig, dt, dS);
