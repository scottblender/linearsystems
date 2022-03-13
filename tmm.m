function Z = tmm(A,R, ff, Z0, tt)
%_____ transition matrix method _____%
[N, ~] = size(A); Z = zeros(N, length(tt));
Z(:,1) = Z0;
for jj=2:length(tt)
    t0 = tt(jj-1); t1 = tt(jj);
    Z(:,jj) = expm(A*(t1-t0))*(Z(:,jj-1) + integral(@ (mu) expm(-A*(mu-t0))*R*ff(mu), t0, t1, 'ArrayValued',true));
end