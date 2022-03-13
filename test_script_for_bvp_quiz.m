tt=linspace(0, 5, 1001);
closed_form = @(x) (((125*sin(sqrt(5)*5)+14*sqrt(5)))/(25*cos(sqrt(5)*5))).*sin(sqrt(5).*x)+((5)).*cos(sqrt(5).*(x))+x/5;
sor_bvp_test = second_order_recipe_bvp_quiz([1 0 5], @(x) x, 0, 5, 5, 3, tt);
plot(tt(1:10:end), closed_form(tt(1:10:end)), '+g',tt, sor_bvp_test, 'r');
legend('Closed form', 'Second Order BVP Function')