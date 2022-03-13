%_______________________________________
% Define Constants and y(t)
I=9;H=1;G=5;F=9;E=5;D=9;C=2;B=3;A=5;
m = mean([A B C D]);
g = 9.81;
b = max([E F G])/5;
L = 1;
k = sum([A B C D E F G H I]);
y0 = 1/10;
w0 = max([B C D]);
tt = linspace(0, 8*(2*pi)/w0, 100);
y = y0*sin(w0*tt);
y_dot = w0*y0*cos(w0*tt);
%_______________________________________
% Plot x(t) and y(t)
coef_1 = m*L; coef_2 = b*(L/4); coef_3 = m*g + k*(L/4);
x = second_order_recipe([coef_1 coef_2 coef_3], @(t) k*(L/2).*y0*sin(w0*t) + b*(L/2).*w0*y0*cos(w0*t), 0, 0, tt);
plot(tt, y, '--',tt, x, '-')
legend('y(t)','x(t)')
title('Plot of y(t) and response x(t) for 8 cycles of the applied frequency.')