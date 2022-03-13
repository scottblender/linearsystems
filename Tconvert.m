function out_T = Tconvert(in_T, flag)
%------------------------------
%| out_T = Tconvert(in_T)
%| converts in_T (F) to C
%|
%| out_T = Tconver(in_T, flag)
%| converts in_T (F) to C if flag=='f2c'
%|               (C) to F if flag=='c2f'

if nargin < 2
    out_T = (in_T -32)*5/9;
    return 
end
if lower(flag(1)) == 'c' && lower(flag(end)) == 'f'
    out_T = in_T*9/5 + 32;
elseif lower(flag(1)) == 'f' && lower(flag(end)) == 'c'
    out_T = (in_T -32)*5/9;
else 
    error('unrecognized conversion')
end


