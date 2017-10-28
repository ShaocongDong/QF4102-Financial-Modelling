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
val = EDSiiiEuropeanVanillaCall(S0, X, r, q, T, sig, dt, dS);
disp(['option Value is:', num2str(val)]);

%% question iii
N = 2915;
dt = T/N;
disp('-----question iii----- N = 2915 Euro');
val = EDSiiiEuropeanVanillaCall(S0, X, r, q, T, sig, dt, dS);
disp(['option Value is:', num2str(val)]);

%% question iv
disp('-----question iv----- Finding cut-off value Euro');
disp('Calculating...');

Nmax = 2915;
for N = Nmax:-1:1
    sol = N;
    dt = T/N;
    opt = EDSiiiEuropeanVanillaCall(S0, X, r, q, T, sig, dt, dS);
    
    % disp(['At N = ', num2str(N), ', option value is ', num2str(opt)]);
    %disp(num2str(opt));
    if (opt<0.8 || opt>0.9)
        disp(['At N = ', num2str(N), ', option value is ', num2str(opt) , ', it loses all significant figures.']);
        break
    end
end
%% question v
disp('-----question v----- N = 2915 American');
EDSiiiAmericanVanillaCall(S0, X, r, q, T, sig, dt, dS);
