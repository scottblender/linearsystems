t = linspace(0,10, 100);
N = 9;
x_est = 0;
for n=1:N
    if mod(n,2) == 1
        x_est = x_est + (8/pi^2)*cos(pi*n*t)*(1/n^2);
    end
end
plot(x_est, '--b')
hold on;
plot ((8/pi^2)*(cos(pi*t) + (1/9)*cos(3*pi*t) + (1/25)*cos(5*pi*t) + (1/49)*cos(7*pi*t) + (1/81)*cos(9*pi*t)), 'ro')