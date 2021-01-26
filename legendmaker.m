function [output] = legendmaker(string, interval)
% This 
% 
output = {};

for i = 1:numel(interval)
    
    output{i} = strcat(string,": ",num2str(interval(i)));


end

end