S0 = 5.25;
X = 5;
sigma = 0.3;
q = 0.1;
r = 0.03;
xmax = 5;
N = 1500;
T = 1;
I = 100;

for I = 100:100:1500
    dt = T/N;
    dx = xmax/I; % as defined in the question

    alpha = sigma^2*dt/(dx^2);
    beta = dt*(r-q-sigma^2/2)/(2*dx);
    c = (-alpha/2 - beta);
    disp([alpha, beta]);
    disp(c);
end
