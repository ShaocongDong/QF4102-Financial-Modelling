function sol = A2qiv(S0, X, r, q, T, sig, dS, Nmax)
    disp('Calculating...');
    %exact = Ce(S0,X,r,t,sigma,q);
    for N = Nmax:-1:1
        sol = N;
        dt = T/N;
        opt = EDSiiiEuropeanVanillaCall(S0, X, r, q, T, sig, dt, dS);
        disp(['At N = ', num2str(N), ', option value is ', num2str(opt)]);
        %disp(num2str(opt));
        if (opt<0.8 || opt>0.9)
            disp(['At N = ', num2str(N), ', option value is ', num2str(opt) , ', it loses all significant figures.']);
            break
        end
    end
end
