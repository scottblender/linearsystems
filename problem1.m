
tau = linspace(0,5,51);

K = min([9, 1, 0])
v0 = max([7, 6, 5])
exact_b = (1/10)*(35 - 33*exp(-2*tau) + 4*sin(tau) - 2*cos(tau));


x0 = min([7, 9, 1])
a0 = max([7, 6, 5])
exact_c = (exp(-tau)/8).*((33*sin(2*tau)) - (2*tau - 8).*cos(2*tau));
RHS = @(tau) (exp(-tau)).*sin(2*tau);

exact_b_tau = @(tau) (1/10)*(35 - 33*exp(-2*tau) + 4*sin(tau) - 2*cos(tau));
exact_c_tau = @(tau) (exp(-tau)/8).*((33*sin(2*tau)) - (2*tau - 8).*cos(2*tau));

sor_b = second_order_recipe([1 2 K],@(tau) cos(tau), 0, v0, tau);
sor_c = second_order_recipe([1 2 5], RHS, x0, a0, tau);

b = @(tau) second_order_recipe([1 2 K],@(x) cos(x), 0, v0, tau);
c = @(tau) second_order_recipe([1 2 5], RHS, x0, a0, tau);

subplot(3, 1, 1);
plot(tau, exact_b, 'r', tau, sor_b, '+b');
title('Problem 1 Part B')
legend('Closed Form', '2nd Order', 'location', 'southeast')
xlabel('tau') 
ylabel('y(tau)') 

subplot(3, 1, 2)
plot(tau, exact_c, 'k', tau, sor_c, 'og');
title('Problem 1 Part C')
legend ('Closed Form', '2nd Order','Location','northeast')
xlabel('tau') 
ylabel('x(tau)') 
%Dr. P said my code was funky and that I could use the exact equations
subplot(3, 1, 3)
plot(tau, sor_c, tau, sor_b)
HW1_Q2_vjp(exact_b_tau,exact_c_tau,1)


