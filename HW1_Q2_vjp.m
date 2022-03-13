function my_roots = HW1_Q2_vjp(f,g,N)
%
% Nroots(f(x),g(x),interval)
%
% f = your function f(x)
% g = your function g(x)
% N = number of roots you wish to finhold off
fun=@(x) f(x)-g(x);
dx=1/10; x=1/10;
my_roots = zeros(1,N);
count =0;

while count< N
    while fun(x)*fun(x+dx)>0
        x= x+dx;
    end
    
    if x > 10
    xx=linspace(0,5,201);
    plot(xx, fun(xx));
    error('cannot find the roots :(')
    end
    
    count = count+1;
    my_roots(count) = fzero(fun,x);
    x=x+2*dx;
end

xx= linspace(0, ceil(my_roots(end)),401);
plot(xx, f(xx), 'b', xx, g(xx), 'r'); hold on;
stem(my_roots, f(my_roots),'filled')
hold off
        