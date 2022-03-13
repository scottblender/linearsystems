function foo
tt = linspace(0,5,101);
exact = @(t) (5+1/5)*exp(-2*t) + (2*sin(t) - cos(t))/5;
%------ y'+2y=sin(t), y(0) = 5;-----------
plot(tt, exact(tt), '-', tt, recipe_1st([1 2], @(x) sin(x), 5, tt), '+')
