function output = meet(k,step,max_step)




output = 0; 
for index = step:max_step
    if mod(index,k) == 0
        output = index - step;
        return;
    end
    
end

output = max_step - step;


end