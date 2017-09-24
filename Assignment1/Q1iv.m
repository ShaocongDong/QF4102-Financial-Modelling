N = 210:1:250;
CdoN = rand(41,1);
for i = 1:41
    CdoN(i) = BTM_Euro_down_out_call(8, 6.5, 0.02, 0.5, 0.3, 0, N(i), 6);
end
Cdo = Euro_down_out_call (0, 6, 8, 6.5, 0.5, 0.02, 0.3);
error = CdoN-Cdo;
plot(N, error, 'm*-');   % mark each data point with an asterisk in red
