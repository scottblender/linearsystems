function Covid_model(beta, Tend)
Z0 = [1e5;1; 0; 0; 0; 0];
A(Z0)



foo = A(z, beta)
A = zeros(6);
alpha = 1/7; gamma = 1/10; GAM = 1/14;
S = z(1); I = z(2); G = z(3); N = z(4); H = z(5); R = z(6);
if nargin==1, beta = I/sum([S I N R]);
A(1,1) = -beta; A(2,1) = beta; A(2,2) = -alpha;
A(3,2) = 0.45*alpha; A(3,3) = -gamma;
A(4,2) = 0.55*alpha; A(4,4) = -gamma; 
A(5,3) = gamma/10; A(5,5) = -GAM;
A(6,3) = 0.9*gamma; A(6,4) = gamma; A(6,5) = 0.95*GAM;
foo = A;
end