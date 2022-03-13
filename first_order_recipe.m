function y = first_order_recipe(coef, f, y0, t)
%==============================================
%y = first_order_recipe(coef, RHS, y0, t)
% coef = vector of differential operator coefficients 
% f = function handle to non-homogenous term 
%y0 = y(t(1))
%t = vector of values to calculate y(t)
%
% y returned will be the same size as t
%===============================================
a = coef(2)/coef(1); RHS=@(x) f(x)/coef(1);
integrand=@(mu) RHS(mu).*exp(a*mu);
y= zeros(size(t));
y(1) = y0;
for jj=2:length(t)
    y(jj)= exp(-a*t(jj))*(integral(integrand, t(jj-1), t(jj)) + exp(a*t(jj-1))*y(jj-1));
end 