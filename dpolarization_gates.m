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
total_error./4
%%
phi_plus = zeros(4,1);
phi_plus(1) = 1;
phi_plus(4) = 1;
phi_plus = phi_plus./sqrt(2);

phi_minus = zeros(4,1);
phi_minus(1) = 1;
phi_minus(4) = -1;
phi_minus = phi_minus./sqrt(2);

psi_plus = zeros(4,1);
psi_plus(2) = 1;
psi_plus(3) = 1;
psi_plus = psi_plus./sqrt(2);

psi_minus = zeros(4,1);
psi_minus(2) = 1;
psi_minus(3) = -1;
psi_minus = psi_minus./sqrt(2);
%%
alice = [1, -1j; -1j, 1];
bob =  [1 1j; 1j 1];
cnot = zeros(4,4);
cnot(1,1) = 1;
cnot(2,2) = 1;
cnot(3,4) = 1;
cnot(4,3) = 1;
syms A1 A2 B1 B2 C1 C2 D1 D2
control_pair = A1*(phi_plus*phi_plus') + B1*(psi_minus*psi_minus')...
    + C1*(psi_plus*psi_plus') +D1*(phi_minus*phi_minus');

target_pair = A2*(phi_plus*phi_plus') + B2*(psi_minus*psi_minus')...
    + C2*(psi_plus*psi_plus') +D2*(phi_minus*phi_minus');

% control_pair = kron(alice,bob)*control_pair*kron(alice,bob)'; % first step of the deutch et al purifciation
% target_pair =  kron(alice,bob)*target_pair*kron(alice,bob)'; % first step of the deutch et al purifciation

%%
% Bob's CNOT:

bob_cnot = zeros(16,16);
for i  = 1:4
    bob_cnot(i,i) = 1;
end
bob_cnot(5,6) = 1;
bob_cnot(6,5) = 1;
bob_cnot(7,8) = 1;
bob_cnot(8,7) = 1;
for i  = 9:12
    bob_cnot(i,i) = 1;
end
bob_cnot(13,14) = 1;
bob_cnot(14,13) = 1;
bob_cnot(15,16) = 1;
bob_cnot(16,15) = 1;

%% Bob is applying rotation and CNOT

whole_system = kron(control_pair,target_pair);
Bob_rotation = kron(kron(eye(2),bob),kron(eye(2),bob));
whole_system = Bob_rotation * whole_system * Bob_rotation'
%% applying cnot
whole_system  = bob_cnot*whole_system*bob_cnot'
%% measuring the target qbit of bob
m_1 = [0,0;0,1];
m_0 = [1,0;0,0];
whole_system_0  = (kron(eye(4),kron(eye(2),m_0))*whole_system*kron(eye(4),kron(eye(2),m_0))')./(sqrt(trace(whole_system*kron(eye(4),kron(eye(2),m_0))'*kron(eye(4),kron(eye(2),m_0)))));
whole_system_1  = (kron(eye(4),kron(eye(2),m_1))*whole_system*kron(eye(4),kron(eye(2),m_1))')./(sqrt(trace(whole_system*kron(eye(4),kron(eye(2),m_1))'*kron(eye(4),kron(eye(2),m_1)))));
%% calculating the fidelity of phi+ after measurement
measure_0 = zeros(16,1);
measure_0(1) = 1/sqrt(2);
measure_0(13) = 1/sqrt(2);
A = measure_0'*whole_system_0*measure_0
%%
measure_1 = zeros(16,1);
measure_1(4) = 1/sqrt(2);
measure_1(16) = 1/sqrt(2);
A = measure_1'*whole_system_1*measure_1
%% scratch

phi_plus_dens = phi_plus * phi_plus';
m_0 = [0,0;0,1];
eye(2);

kron(eye(2))*phi_plus_dens*kron(m_0,eye(2))'
%%
