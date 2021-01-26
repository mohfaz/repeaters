function f_step = G(f_not,steps)
% G function of paper, i.e., this function returns the final fidelity of
% purification after steps of bennett et al scheme.
f_step = f_not;
for step = 1:steps
    f_step = fidelity(f_step,f_not);
    
end

end