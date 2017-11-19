S0 = 5.25;
X = 5;
sigma = 0.3;
q = 0.1;
r = 0.03;
xmax = 5;
N = 1500;
T = 1;
I = 4;

dt = T/N;
dx = xmax/I; % as defined in the question

alpha = sigma^2*dt/(dx^2);
beta = dt*(r-q-sigma^2/2)/(2*dx);
a = (beta - alpha/2) * ones(2*I-1,1)*100000;
b = (1 + alpha + r*dt) * ones(2*I-1,1)*100000;
c = (-alpha/2 - beta) * ones(2*I-1,1)*100000;
disp([alpha, beta]);
disp([ a,b,c]);
CoeffMatrix=spdiags ([c, b, a],-1:1, 2*I-1, 2*I-1)';
