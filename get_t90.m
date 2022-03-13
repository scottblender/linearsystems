function t90 = get_t90(b,h,L,m)
g=9.81;
theta = atan(h/L);
Gamma = g*sin(theta);
t1 = sqrt(2*h/(Gamma*sin(theta)));
t1 = get_t1(b, h, L, m);
v1 = Gamma*cos(theta)/(b/m) * (1- exp(-b/m*t1));
t90 = t1 - m/b*log(1/10*(1 + L/(v1/(b/m))));
