function [output] = memory_fidelity(noise,times)

output = 1/4.+3/4.*noise.^(2.*times);


end