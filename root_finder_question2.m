function my_roots = root_finder_question2(f, g, N)
%==============================================
% my_roots = root_finder(f, g, N)
% f, g = function handles
% N = number of roots to find
% my_roots returned will return the first unique N roots of f(x)=g(x) for 0 < x
%===============================================
%num_roots_to_find = 0;
h = @(x) f(x) - g(x);
my_roots = zeros(N, 1);
num = 1; i=1; x = linspace(0, 50, 51);
while (num < N + 1 && i <= 50)
    x0 = x(num);
    root = round(fzero(h, x0), 4);
    if ~ismember(my_roots, root)
        my_roots(num) = root;
        num = num + 1;
    end 
    x = x+1;
    if x0 == 51
        disp('Cannot find roots on this interval')
    end 
end
disp(my_roots(my_roots~=0))
end