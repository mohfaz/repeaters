function [output] = memory_decoh(t,t_coh)
% this fucntion returns the affect of memory decoherence on qubits fidelity
% output = 1;
output = exp(-t/t_coh);
end

