function t1 = get_t1(b,h,L,m)
g=9.81;
theta = atan(h/L);
Gamma = g*sin(theta);
t1 = sqrt(2*h/(Gamma*sin(theta)));
if b>0
    y=@(t) h + Gamma*sin(theta)/(b/m)^2 * (1- exp(-b/m*t) - b/m*t);
    t1 = fzero(y,t1);
end
end