function hw022(A,K,alpha)
tt = linspace(0,2,101);
plot(tt, closed(tt,A,K,alpha), '-',tt, recipe_1st([1 alpha], @(t) ff(t, K), A, tt), '+')

function foo = ff(t,K)
foo = K*sin(pi*t);
foo(t>1) = 0;

function foo = closed(t, A, K, alpha)
foo = exp(-alpha*t)*(A+ K*pi/(alpha^2 + pi^2));
rr = t<=1;
foo(rr) = foo(rr) + K/(alpha^2+pi^2)*(alpha*sin(pi*t(rr)) - pi*cos(pi*t(rr)));
rr = t>1;
foo(rr) = foo(rr) + K*exp(-alpha*(t(rr)-1))*pi/(alpha^2 + pi^2);