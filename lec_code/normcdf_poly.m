function N=normcdf_poly(x)
% A polynomial approximation of normcdf giving 6 decimal place accuracy
% Input x must be either a scalar or a row for this implementation
% See M.Abramowitz and I.Stegun, Handbook of Mathematics Functions.
%
if (size(x,1)>1)
   error('approx_normcdf: input x must either be a scalar or a row vector');
end;
if x<0
   N=1-normcdf_poly(-x);
else
   a=[0.319381530 -0.356563782 1.781477937 -1.821255978 1.330274429];
   k=1./(1+0.2316419*x);
   N=1-1/(sqrt(2*pi))*exp(-x.^2/2).*(a*cumprod(repmat(k,5,1),1));
end;

