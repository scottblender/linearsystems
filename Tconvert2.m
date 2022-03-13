function out_T = Tconvert2(in_T, flag)
%------------------------------
%| out_T = Tconvert(in_T, flag)
%| converts in_T in either C, F, R, or K to conversion in C, F, R, or K
%| in_T is the input temperature
%| flag is the type of temperature (C, F, R, or K)
%| out_T returned is a vector of converted temperatures organized as
%follows: [out_T in C, out_T in F, out_T in R, out_T in K].
if contains(flag, lower('c'))
    C = in_T;
    F = 5/9*C + 32;
    R = F + 459.67;
    K = C + 273.15;
    out_T = [C, F, R, K];
elseif contains(flag, lower('f'))
    F = in_T;
    R = F + 459.67;
    C = (F-32)*9/5;
    K = C + 273.15;
    out_T = [C, F, R, K];
elseif contains(flag, lower('r'))
    R = in_T;
    F = R - 459.67;
    C = (F-32)*9/5;
    K = C + 273.15;
    out_T = [C, F, R, K];
elseif contains(flag, lower('k'))
    K = in_T;
    C = K - 273.15;
    F = 5/9*C + 32;
    R = F + 459.67;
    out_T = [C, F, R, K];
end

    