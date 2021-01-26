function [x] = returnx(f)
% REUTRNX this function return the maximum distance for given fidelity f
% the f should be between 0.5 and 1
x = (8*f^3 - 14*f^2 + 7*f - 1)/(8*f^2 - 12*f + 1);
end

