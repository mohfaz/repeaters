function f = fidelity(f1,f2)
% FIDELITY  calculate fidelity when we do recurrence purification given two
% two fidelities f1 and f2, for Bennette et al. scheme.
% Inputs : f1 = fidelity of first pair
%          f2 = fidelity of second pair.
if nargin <2
    
f = (f1*f1 + 1/9*(1-f1)*(1-f1))/(f1*f1+1/3*f1*(1-f1)+1/3*f1*(1-f1)+5/9*(1-f1)*(1-f1));
else
f = (f1*f2 + 1/9*(1-f1)*(1-f2))/(f1*f2+1/3*f1*(1-f2)+1/3*f2*(1-f1)+5/9*(1-f1)*(1-f2));
end
end

