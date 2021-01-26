function [A_,B_,C_,D_,N] = Deutch(A,B,C,D)

% This function calculates Deutch et al.
% purification scheme. coefs and the probability of success.

    if length(A) ==2
        N = (A(1) + B(1)) * (A(2) + B(2)) ...
            +...
            (C(1) + D(1)) * (C(2)+D(2));
        A_ = (A(1) * A(2) + B(1) * B(2)) /N;
        B_ = (C(2) * D(1) + C(1) * D(2)) /N;
        C_ = (C(1) * C(2) + D(1) * D(2)) /N;
        D_ = (A(1) * B(2) + A(2) * B(1)) /N;
        
        
    else
        N = (A+B)^2 + (C+D)^2;
        A_ = (A^2+B^2)/N;
        B_ = (2*C*D)/N;
        C_ = (C^2+D^2)/N;
        D_ = 2*A*B/N;
    end


end

