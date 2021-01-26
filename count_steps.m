function [steps,prob_of_success_] = count_steps(f_in,f_out)

if f_in == f_out
    steps = 0;
    prob_of_success_ = 0;
    return;
end
if(f_out  < f_in)
    steps = 0;
    prob_of_success_ = 0;
    return;
end
steps = 1;
prob_of_success_ = 1;
while abs(f_in - f_out) > 1e-6 && f_out > f_in
        prob_of_success_ = prob_of_success_ * prob_of_success(f_in,f_in);

    f_in = fidelity(f_in,f_in);
    f_in;
    f_out;
    steps = steps +1;
end

end

