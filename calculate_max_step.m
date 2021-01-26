function [max_step] = calculate_max_step(fid_in,fid_out)

if fid_in == fid_out
    max_step = 0;
    return;
end
if fid_out < fid_in
    max_step = nan;
    return
end
fid_temp = fid_in
for k = 1:10
   fid_temp = fidelity(fid_in,fid_temp)
   if (fid_temp >= fid_out)
       max_step = k;
       return
   end
    
end
max_step = nan;
end