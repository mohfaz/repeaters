function [F_th] = Tthereshold(noise,f_th)
   F_th = 1./(2*log(noise)).*log(4*f_th/3-1/3);

end
