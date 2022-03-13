function y = second_order_bvp(coef, f, aa, bb, m0, A, B, t)
%==============================================
% y = second_order_recipe(coef, f, y0, t)
% coef = vector of differential operator coefficients 
% f = function handle to non-homogenous term 
% A = y(t(a))
% B = dy/dt((b)) + m*y(b)
% aa = boundary condition #1
% bb = boundary condition #2
% m0 = mew constant
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
m = m0;
%---- get the constants next ---
%cc = [u1(0) u2(0); du1(0) du2(0)] \ [y0; (v0 - (I1(0)*u1(0) + I2(0)*u2(0)))];
cc = [u1(aa) u2(aa) 0 0; du1(bb) du2(bb) m*u1(bb) m*u2(bb)] \ [A; (B - (I1(bb)*u1(bb)+I2(bb)*u2(bb)))];
%---- start calculating -------
y = zeros(size(t));
y(1) = A;
for jj=2:length(y)
    tp = t(jj);
    y(jj) = u1(tp)*(integral(I1, aa, tp) + cc(1)) + ...
        u2(tp)*(integral(I2,aa,tp) + cc(2));

y = round(y, 6);
end
end

