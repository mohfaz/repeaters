function [prob] = prob_of_success(f1,f2)
%PROB_OF_SUCCESS This function returns the probability success of the
%purification in Bennette et al. scheme
% f1 : first fidelity
% f2 : second fidelity
prob = (f1*f2+1/3*f1*(1-f2)+1/3*f2*(1-f1)+5/9*(1-f1)*(1-f2));
end

