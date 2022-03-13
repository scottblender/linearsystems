function y = second_order_recipe_bvp_quiz(coef, f,aa, bb, A, B, t)
%==============================================
% y = second_order_recipe(coef, f,aa, bb, A, B, t)
% coef = vector of differential operator coefficients 
% f = function handle to non-homogenous term 
% aa = starting point
% bb = ending point
% A = y(t(a))
% B = dy/dt(b)
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
cc = [u1(aa) u2(aa); du1(bb) du2(bb)] \ [A; (B - (du1(bb)*integral(I1,aa,bb))-(u1(bb)*I1(bb))-(du2(bb)*integral(I2,aa,bb))-(u2(bb)*I2(bb)))];
%---- start calculating -------
y = zeros(size(t));
y(1) = A;
for jj=2:length(y)
    tp =t(jj);
    y(jj) = u1(tp)*(integral(I1, aa, tp) + cc(1)) + ...
        u2(tp)*(integral(I2,aa,tp) + cc(2));

y = round(y, 6);
end
end

