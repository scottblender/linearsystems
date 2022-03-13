function gauss = gauss_solver(A,b)
if abs(det(A))<1e-3, error('A is singular'); end 
aa = [ A b];
[N, M] = size(aa); 
%----- forwards pass ----
for icol=1:(N-1)
    %first look for the row with the largest value in this col
    maxid = icol;
    for jj=icol+1:N
        if abs(aa(jj, icol))>abs(aa(maxid, icol)), maxid = jj;
        end
    end
    %--- swap the rows if needed ---%
    if maxid ~= icol
        swap = aa(maxid,:); aa(maxid,:)=aa(icol,:); aa(icol,:)=swap;
    end
    %-- zero out the column -----
    for jrow = icol+1:N
        aa(jrow,:) = aa(jrow, :) - aa(jrow, icol)/aa(icol, icol)*aa(icol,:);
    end
end
%disp(aa)
%---- back-substitution pass ----
gauss = zeros(N, 1); %column vector
for irow = N:-1:1
    gauss(irow) = (aa(irow, end) - aa(irow, irow+1:N)*gauss(irow+1:N))/aa(irow,irow);
end
%disp(x)