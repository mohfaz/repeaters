function [prob, fidelity_new] = P_thru(f_0,f_1,epoch_length,t_coh,T_1,T_2,first_epoch)
prob = 1;
if first_epoch % if this is the first epoch then we have to consider the initializiation to.

     f_0 = f_0*memory_decoh(T_2, t_coh); % propagation delay effect 
     f_1 = f_1*memory_decoh(T_2, t_coh); % propagation delay effect 
    prob = prob * prob_of_success(f_0, f_1); % Probability of success
    f_1 = fidelity(f_0,f_1); % fidelity output
    
    for step = 2:epoch_length
        f_1 = f_1 *memory_decoh(T_1, t_coh); % effect of waiting time due to the rate of bell pair generation
        prob = prob * prob_of_success(f_0, f_1); % Probability of success
        f_1 = fidelity(f_0,f_1);
    end
    fidelity_new = f_1 * memory_decoh(T_2, t_coh); % classical communication effect on fidelity 
    
else % If this is is not the first epoch then we are in the mid section
    
     f_0 = f_0 * memory_decoh(T_2, t_coh); % effect of propagation delay on the auxulary pair
    
    for step = 1:epoch_length
        f_1 = f_1 * memory_decoh(T_1, t_coh);
        prob = prob * prob_of_success(f_0, f_1); % Probability of success
        f_1 = fidelity(f_0,f_1);     % new fidelity   
    end
    fidelity_new = f_1 * memory_decoh(T_2, t_coh);% classical communication effect on fidelity 
end
% function [prob] = P_thru(f_0,k1,k2)
% prob = 1;
% f_temp = f_0;
% 
% 
% if k1 == 0
%     
%     for step = 1:k2
%         
%         prob =  prob * prob_of_success(f_0, f_temp);
%         f_temp = fidelity(f_0, f_temp);
%         
%     end
%     
% else  
%     for step = 1:k1
%         f_temp = fidelity(f_0, f_temp);
%     end
%     
%     for step = k1+1:k2
%         
%         prob =  prob * prob_of_success(f_0, f_temp);
%         f_temp = fidelity(f_0, f_temp);
%         
%         
%     end
%     
%     
% end
end