%% Declare Bell states
phi_plus = 1/sqrt(2)*[1,0,0,1]';
phi_minus = 1/sqrt(2)*[1,0,0,-1]';
psi_plus = 1/sqrt(2)*[0,1,1,0]';
psi_minus = 1/sqrt(2)*[0,1,-1,0]';

bx = [0.5, 1i/2, 1i/2, -0.5;... %bilateral pi/rotation Bx calculated with paper and pen
    1i/2, 0.5, -0.5, 1i/2;...
    1i/2, -0.5, 0.5, i/2;
    -0.5, i/2, i/2, 0.5];
I = eye(4);
%% %bilateral pi/rotation Bz calculated with Matlab. using Table 4 in https://arxiv.org/pdf/quant-ph/9604024.pdf
bz_factmatrix = [0,1,-1,0;...
               1,0,0,-1;...
               1,0,0,1;...
               0,1,1,0];
bz_firstrow_output = [0;1i;1i;0];
bz_firstrow = bz_factmatrix\bz_firstrow_output;
bz_firstrow = transpose(bz_firstrow);

bz_secondrow_output = [1,0,0,1]';
bz_secondrow = transpose(bz_factmatrix\bz_secondrow_output);

bz_thirdrow_output = [-1,0,0,1]';
bz_thirdrow = transpose(bz_factmatrix\bz_thirdrow_output);

bz_forthrow_output = [0;1i;-1i;0];
bz_forthrow = transpose(bz_factmatrix\bz_forthrow_output);
bz = [bz_firstrow; bz_secondrow; bz_thirdrow; bz_forthrow];

%% Bilateral pi/rotation Bz calculated with Matlab using Table 4 in https://arxiv.org/pdf/quant-ph/9604024.pdf
by_firstrow_output = [0;0;1;1];
by_secondrow_output = [1;-1;0;0];
by_thirdrow_output = [-1;-1;0;0];
by_forthrow_output = [0;0;1;-1];

by_firstrow = transpose(bz_factmatrix\by_firstrow_output);
by_secondrow = transpose(bz_factmatrix\by_secondrow_output);
by_thirdrow = transpose(bz_factmatrix\by_thirdrow_output);
by_forthrow = transpose(bz_factmatrix\by_forthrow_output);
by = [by_firstrow;by_secondrow;by_thirdrow;by_forthrow]
%% Check if two EPR pairs with the same fidelity become werner state after purification.
syms f %Declare symbolic variable f
F = (f^2+(1-f)^2/9) + 2*f*(1-f)/3 + 2*(1-f)^2/9 + 2*(1-f)^2/9; %Denomitor of fidelity function
psi_minus_coef = (f^2+(1-f)^2/9)/F.*psi_minus*psi_minus'; % Psi_minus after purification
psi_plus_coef = (2*f*(1-f)/3)/F.*psi_plus*psi_plus'; % Psi_plus after purification
phi_plus_coef = (2*(1-f)^2/9)/F.*phi_plus*phi_plus'; % Phi_plus after purification
phi_minus_coef = (2*(1-f)^2/9)/F.*phi_minus*phi_minus'; % Phi_minus after purification


%%
[psi_m,psi_p,phi_p,phi_m] = apply_bilateral(bx,by,bz,...
    psi_minus_coef,psi_plus_coef,phi_plus_coef,phi_minus_coef); % apply bilateral to purified EPR pairs

Output(f) = (psi_m + psi_p + phi_p + phi_m);

F_p = psi_m(2,2)*2; % The fidelity of psi minus after purification
Werner_State(f) = (1-F_p)/3.*eye(4)+(4*F_p-1)/3.*psi_minus*psi_minus'; % Werner state (eq 17 in https://arxiv.org/pdf/quant-ph/9604024.pdf)

for i = 0.5:0.01:1 % I couldn't find any function in matlab to check the equality of two symbolic matrices directly, so I checked them by entering different inputs 
    
        if(~isequal(Output(i),Werner_State(i)))
           disp("error") 
        end

end
disp("finished")
%% Check werner state for two pairs with different fidelities
syms f1 f2
F_denom = f1*f2 + 1/3*f1*(1-f2) + 1/3*f2*(1-f1) + 5/9*(1-f1)*(1-f2); %denominator of fidelity of two pairs with different fidelities after performing purification

psi_minus_coef = (f1*f2+(1-f1)/3*(1-f2)/3)/F_denom.*psi_minus*psi_minus';
psi_plus_coef = (f1*(1-f2)/3+f2*(1-f1)/3)/F_denom.*psi_plus*psi_plus';
phi_plus_coef = (2*(1-f1)*(1-f2)/9)/F_denom.*phi_plus*phi_plus';
phi_minus_coef = (2*(1-f1)*(1-f2)/9)/F_denom.*phi_minus*phi_minus';


%%
[psi_m,psi_p,phi_p,phi_m] = apply_bilateral(bx,by,bz,...
    psi_minus_coef,psi_plus_coef,phi_plus_coef,phi_minus_coef); % apply bilateral to purified pair

Output(f1,f2) = (psi_m + psi_p + phi_p + phi_m);
%%
F_p = psi_m(2,2)*2;
Werner_state(f1,f2) = (1-F_p)/3.*eye(4)+(4*F_p-1)/3.*psi_minus*psi_minus';

for i = 0.5:0.01:1 % Check equality by several inputs. if one of them is not equal then the error message will be printed.
    
    for j = 0.5:0.01:1
        if(~isequal(Output(i,j),Werner_state(i,j)))
           disp("error") 
        end
    
    end

end
disp('finished')