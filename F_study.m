function ss = F_study(ff, range)
%------------------------------
%| ss = F_study(f, range)
%| Plots a given function over a specified range and calculates all of the
%roots on that range.
%| ff is the function to be plotted
%| range is the range we want to plot over
%| ss returned is the plot of the function over the specified range with
%labeled roots.
xx = linspace(range(1), range(end), 201);
fvalue = ff(xx);
plot(xx, ff(xx)); grid; hold on

%--- look for roots ---
ss= zeros(1,20); Nroots = 0;
for jj=2:length(xx)
    if fvalue(jj)*fvalue(jj-1) <= 0
        %[x0, fval, exitflag] = fzero(ff, xx(jj));
        x0 = fsolve(ff, xx(jj));
        %disp(exitflag)
        if range(1) <=x0 && x0<= range(2)
            Nroots = Nroots+1;
            ss(Nroots) = x0;
            plot(x0, 0, 'o', 'MarkerFaceColor','r')
            gtext(sprintf('%0.3f', x0));
        end
    end
end
ss = ss(1:Nroots);
hold off;
end