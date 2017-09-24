N = 200:200:2000;
new_values = rand(10,1);
for i = 1:10
    disp(i);
    new_values(i,1) = New_Euro_float_lookback_put(1, 0.04, 0.5, 0.4, 0.02, N(i));
end
plot(N, new_values, 'm*-');