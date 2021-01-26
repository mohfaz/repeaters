function [output] = hw(n)
    n
    if n <=1 
        output = 1;
        return;

    end
output = sqrt(2*n)*hw(sqrt(2*n)) + sqrt(n);
end

