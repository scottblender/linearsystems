function y = second_order_recipe(coef, f, y0, v0, t)
%==============================================
% y = second_order_recipe(coef, f, y0, v0, t)
% coef = vector of differential operator coefficients 
% f = function handle to non-homogenous term 
% y0 = y(t(1))
% v0 = dy/dt(0)
% t = vector of values to calculate y(t)
%
% y returned will be the same size as t
%===============================================
RHS = @(x) f(x)/coef(1); coef = coef/coef(1);
rr = roots(coef);
%---- get u1 and u2 ---
u1 = @(x) exp(rr(1)*x);
du1 = @(x) rr(1)*exp(rr(1)*x);
if rr(1) == rr(2)
    u2 = @(x) x.*exp(rr(1)*x);
    du2 = @(x) (1 + rr(1)*x).*exp(rr(1)*x);
else
    u2 = @(x) exp(rr(2)*x);
    du2 = @(x) rr(2)*exp(rr(2)*x);
end 
W = @(x) u1(x).*du2(x)-u2(x).*du1(x);
I1 = @(x) -u2(x).*RHS(x)./W(x);
I2 = @(x) u1(x).*RHS(x)./W(x);
%---- get the constants next ---
cc = [u1(0) u2(0); du1(0) du2(0)] \ [y0; (v0 - (I1(0)*u1(0) + I2(0)*u2(0)))];

%---- start calculating -------
y = zeros(size(t));
y(1) = y0;
for jj=2:length(t)
    tp =t(jj);
    y(jj) = u1(tp)*(integral(I1, 0, tp) + cc(1)) + ...
        u2(tp)*(integral(I2,0,tp) + cc(2));

y = round(y, 6);
end
end

