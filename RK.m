function [t,z] = RK(f, range, z0)
dt = diff(range)/10;
while dt > 1/40, dt = dt/2; end
t = range(1):dt:range(2);
z = zeros(length(z0), length(t));
z(:,1) = z0;
for jj=2:length(t)
Z0 = z(:,jj-1); t0 = t(jj-1);
z(:, jj) = Z0 + RKStep(f, Z0, t0, dt);
end

function foo = RKStep(f, Z0, t0, dt)
K1 = dt*f(t0, Z0);
K2 = dt*f(t0+dt/2, Z0 + K1/2);
K3 = dt*f(t0+dt/2, Z0 + K2/2);
K4 = dt*f(t0+dt, Z0 + K3);
foo = 1/6*(K1+2*(K2+K3)+K4);