function two_ways(m, b, k, y0, v0, ff, TEND)
%_____ second-order recipe _____%
tt = linspace(0, TEND, 101);
plot(tt, second_order_recipe([m b k], ff, y0, v0, tt));
%_____ transition matrix method _____%
hold on;
A = [0 1; -k/m, -b/m]; R = [0; 1/m]; Z0 = [y0;v0];
Z = tmm(A, R, ff, Z0, tt);
plot(tt, Z(1,:), '-+'); hold off
end