function xx = x(b,h,L,m,t)
rhs = @(t) RHS(b,h,L,m,t);
xx = second_order_recipe([1 b/m 0], rhs, 0, 0, t);
end