function y = recipe_2nd(coef, f, y0, v0, t)
%================================
%| y = recipe_1st([a b], RHS, y0, t)
%| solve ay'' + by' + cy = RHS; y(0) = y0, y'(0) = v0
%| f is a function handle
%| t is a vector of values
%| y(t) a vector of values returned
%================================
r = roots(coef); RHS = @(x) f(x)/coef(1);
y = zeros(size(t));

%------- get u1 and u2 -----
u1 = @(t) exp(r(1)*t); du1 = @(t) r(1)*exp(r(1)*t);
if r(1) == r(2)
    u2 = @(t) t.*exp(r(1)*t); du2 = @(t) (r(1)*t+1).*exp(r(1)*t);
else 
    u2 = @(t) exp(r(2)*t); du2 = @(t) r(2)*exp(r(2)*t);
end
W = @(t) (u1(t).*du2(t) - u2(t).*du1(t));
I1 = @(t) -u2(t).*RHS(t)./W(t);
I2 = @(t) u1(t).*RHS(t)./W(t);

C = [u1(0) u2(0); du1(0) du2(0)]\[y0; v0-(u1(0)*I1(0) + u2(0)*I2(0))];

%---- get y ----------------
for jj=1:length(y)
    t0 = t(jj);
    y(jj) = u1(t0)*(C(1) + integral(I1, 0, t0)) + u2(t0)*(C(2) + integral(I2, 0, t0));
end
