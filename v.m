function vv = v(b,h,L,m,t)
rhs = @(t) RHS(b,h,L,m,t);
vv = first_order_recipe([1 b/m], rhs, 0, t);
end