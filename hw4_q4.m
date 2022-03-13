A=5;B=3;C=2;D=9;E=5;F=9;G=5;H=1;I=9;
AA = [max(A,B) 0 8 2; I 0 G 3; max(E,H) max(C,D) 0 5;H 2 1 max(E,F)];
b = [1 2 3 4]';
disp(gauss_solver(AA,b))
disp(AA\b)
b = [ A B C; D E F; G H I; A B C];
disp(gauss_solver_matrix(AA, b)) 
disp(AA\b)