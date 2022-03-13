function aN = mysequence(a1, a2, N)
aN = zeros(1, N);
aN(1) = a1;
aN(2) = a2;
for jj=2:N+2
    aN(jj+1) = (aN(jj)+aN(jj-1))/(1-(aN(jj)*(aN(jj-1))));
end
aN = aN(1:N);
tt = linspace(min(aN), max(aN), length(aN));
plot(tt, aN)
grid;
hold on
plot(tt(aN == min(aN)), min(aN), 'or', tt(aN == max(aN)), max(aN),'ob')
gtext(sprintf("%0.3f", min(aN)))
gtext(sprintf("%0.3f", max(aN)))