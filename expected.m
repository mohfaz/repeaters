function [output] = expected(t)
output = ((32/200 * exp( 2 * t) + exp( 99 * t ) /200 + 167/200*exp(-t))^(10^6))/(exp(10000*t));
end

