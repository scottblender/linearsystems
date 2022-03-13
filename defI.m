function I = defI(f, range, M)
%------------------------------
%| I = defI(f, range, M)
%| Computues a definite integral over a specified range for a certain
%function
%| f is the function to be integrated
%| range is the range we want to integrate over
%| M is the number of significant digits required for accuracy
%| I returned is the value of the definite integral for the range
%specified
denominator = 1000;
dt = (range(2) - range(1))/denominator;
t = range(1):dt:range(2);
ff = f(t);
I = (dt/3)*(ff(1) + ff(end) + 4*sum(ff(2:2:end-1)) + 2*sum(ff(3:2:end-2)));
if nargin > 2
    while  denominator > 0
        denominator = denominator - 50;
        dt_new = (range(2)-range(1))/denominator;
        t_new = range(1):dt_new:range(2);
        ff_new = f(t_new);
        I_new = (dt_new/3)*(ff_new(1) + ff_new(end) + 4*sum(ff_new(2:2:end-1)) + 2*sum(ff_new(3:2:end-2)));
        rel_error = abs((I - I_new)/I);
        if rel_error < 10^-M
            I = round(I, M);
            disp("Our estimated value using Simpson's method to " + string(M) + " significant digits is: " + string(I))
            break
        else 
            I = round(I, M);
            disp("Our estimated value using Simpson's method was never calculated to be exact to " + string(M) + " significant digits, but is " + string(I))
            break
        end
    end 
end
exact_value = integral(f, range(1), range(2));
disp("Our exact value for this integral is: " + string(exact_value))



