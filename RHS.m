function foo = RHS(b,h,L,m,t)
t1 = get_t1(b,h,L,m);
foo = zeros(size(t));
theta = atan(h/L); g=9.81; Gamma = g*sin(theta);
foo(t<=t1) = Gamma*cos(theta);