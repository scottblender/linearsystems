dt = 1/20; t = 0:dt:10;
v = recipe_2nd([1 0 1], @(x) 5 + 3*x.*sin(x) + 2*sqrt(x), 5, 9, t);
y = tabI(v, dt, 9);
subplot(2,1,1); plot(t,y);
subplot(2,1,2); plot(y, v);
