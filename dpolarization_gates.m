%% symetric case
X = [0,1;1,0];
Z = [1,0;0,-1];
Y = [0, -1i;1i, 0];
I = eye(2);
gates = cell(4);
gates{1} = X;
gates{2} = Z;
gates{3} = Y;
gates{4} = I;
phi_plus = zeros(4,1);
phi_plus(1) = 1;
phi_plus(4) = 1;
phi_plus = phi_plus./sqrt(2);

total_error = zeros(4,4);

for i = 1:4
    for j = 1:4

        total_error = total_error + kron(gates{i},gates{j})*(phi_plus*phi_plus')*kron(gates{i},gates{j})';
    end
end


%%
total_error = zeros(4,4);
for i = 1:4
    
        total_error = total_error + kron(I,gates{i})*(phi_plus*phi_plus')*kron(I,gates{i})';
        kron(I,gates{i})*(phi_plus*phi_plus')*kron(I,gates{i})'
end
total_error./4;