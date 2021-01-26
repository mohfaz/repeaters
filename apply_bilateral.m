function[psi_m_,psi_p_,phi_p_,phi_m_] = apply_bilateral(bx,by,bz,psi_minus_coef,psi_plus_coef,phi_plus_coef,phi_minus_coef)
psi_m = cell(1,12);
psi_p = cell(1,12);
phi_p = cell(1,12);
phi_m = cell(1,12);

matrics = cell(1,12);

matrics{1} = bx*bx;
matrics{2} = by*by;
matrics{3} = bz*bz;
matrics{4} = bx*by;
matrics{5} = by*bz;
matrics{6} = bz*bx;
matrics{7} = by*bx;
matrics{8} = bx*by*bx*by;
matrics{9} = by*bz*by*bz;
matrics{10} = bz*bx*bz*bx;
matrics{11} = by*bx*by*bx;
matrics{12} = eye(4);
for i = 1:12
    psi_m{i} = (matrics{i}')*psi_minus_coef*matrics{i};
    psi_p{i} = (matrics{i}')*psi_plus_coef*matrics{i};
    phi_p{i} = (matrics{i}')*phi_plus_coef*matrics{i};
    phi_m{i} = (matrics{i}')*phi_minus_coef*matrics{i};
end

psi_m_ = zeros(4,4);
phi_m_ = zeros(4,4);
phi_p_ = zeros(4,4);
psi_p_ = zeros(4,4);

for i = 1: 12
    psi_m_ = psi_m_ + psi_m{i};
    phi_p_ = phi_p_ + phi_p{i};
    psi_p_ = psi_p_ + psi_p{i};
    phi_m_ = phi_m_ + phi_m{i};
end
psi_m_ = psi_m_./12;
psi_p_ = psi_p_./12;
phi_p_ = phi_p_./12;
phi_m_ = phi_m_./12;
end

