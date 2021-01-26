%% Comparsion between Duetch et al. and Benet et al. plot 3d
number_of_steps = 10;
initial_fidelity = [0.5:0.1:1];
fidelity_output = zeros(length(initial_fidelity), length(number_of_steps));
fidelity_output_bennet = zeros(length(initial_fidelity), length(number_of_steps));
for i = 1:length(initial_fidelity)
    A = initial_fidelity(i);
    B = (1-A)/3;
    C = B;
    D = C;
    sum([A,B,C,D])
    f = initial_fidelity(i);
    
    for j = 1 : number_of_steps
        [A,B,C,D] = Deutch(A,B,C,D);
        f= fidelity(f,f);
        fidelity_output(i,j) = A;   
        fidelity_output_bennet(i,j) = f;
        
    end
    
end
%%
subplot(1,2,1)
surf([1:number_of_steps],initial_fidelity,fidelity_output)
zlim([0.5,1]);
title("Deutsch et al.")
xlabel('Step')
ylabel('Input Fidelity')
zlabel('Output Fidelity')
subplot(1,2,2)
colorbar
surf([1:number_of_steps],initial_fidelity,fidelity_output_bennet);
title("Bennett et al.")
zlim([0.5,1]);
xlabel('Step')
ylabel('Input Fidelity')
zlabel('Output Fidelity')
colorbar
% subplot(1,3,3)
% surf([1:number_of_steps],initial_fidelity,fidelity_output-fidelity_output_bennet)
% title("The difference")

%%

%% Plot the amount of increase in duetch et al. scheme
initial_fidelity = 0.5:0.001:1;
fidelity_increase = zeros(size(initial_fidelity));

for i = 1:length(initial_fidelity)
    
    A = initial_fidelity(i);
    B = (1-A)/3;
    C = B;
    D = C;
%     B = 2*(1-A)/3;
%     C = (1-A)/6;
%     D = C;
    sum([A,B,C,D])
    fidelity_increase(i) = Deutch(A,B,C,D) - A;
end
% plot
figure
plot(initial_fidelity,fidelity_increase,'Color',[0.4940 0.1840 0.5560],'LineWidth',3.5)
grid on

% set legend

% set xlabel.
xlabel("F_1 = F_2",'FontSize',20,'FontWeight','bold');

% set ylabel and the change the position to make i t more readable
yy = ylabel({"Increase", "in", "fidelity"},'FontSize',20,'FontWeight','bold');
pos=get(yy,'Position');
pos1=pos-[0.01,0,0];
set(yy,'Position',pos1);
% Set the rotation.
yy.Rotation = 0;
% change the font and style in the axis.
ax = gca;
ax.FontSize = 13; 
ax.FontWeight = 'bold';
%%
fidelity_output = 0;
A = 0.6;
fidelity_b = A;
B = 2*(1-0.6)/3;
C = (1-0.6)/6;
D = (1-0.6)/6;
fidelities = A;
fidelities_bs = A;
for i = 1:10
   [A,B,C,D] = Deutch(A,B,C,D);
   fidelities = [fidelities, A];
   fidelity_b = fidelity(fidelity_b,fidelity_b);
   fidelities_bs =[fidelities_bs, fidelity_b];
end
    
plot(1:11,fidelities)
hold on;
plot(1:11,fidelities_bs)
title('The comparsion between Duetch et al and the Bennet et al.');
ylabel('Fidelity after purification');
xlabel('Number of purifica,tion');
legend('Deutch et al. schem','Bennet et al.','Location','southeast');
opt = gca;
opt.FontSize = 15;
%% Best case for Duetch et al. using scheme C. for the best case where the 
F = [0.5:0.01:0.99];
steps = [1,2,5,10,15,30,45];
max_fidelity = zeros(numel(F),numel(steps));
prob_of_success_ = max_fidelity;
bennete_et_al_max_fidelity = max_fidelity;
bennete_et_al_prob_of_success = max_fidelity;
for step = steps
    
    for f = F
        fid_in = f;
        fid_out = f;
        A_temp = f;
        A_out = f;
        B_temp = 0;
        B_out = 0;
        C_temp = 0;
        C_out = 0;
        D_temp = 1-f;
        D_out = 1-f;
        fid_store = [];
        prob = 1;
        prob_bennete = 1;
        for i = 1:step
           prob_bennete  = prob_bennete* prob_of_success(fid_in,fid_out);
           fid_out = fidelity(fid_in,fid_out);
           [A_out,B_out,C_out,D_out,N] = Deutch([A_temp,A_out],[B_temp,B_out],[C_temp,C_out],[D_temp,D_out]);
           
           prob = prob * N;
            
        end
        max_fidelity(F == f, steps == step) = A_out;
        prob_of_success_(F == f, steps == step) = prob;
        bennete_et_al_prob_of_success(F == f, steps == step) = prob_bennete;
        bennete_et_al_max_fidelity(F == f, steps == step) = fid_out;
    end
    
end
%%
text = 'Deutch et al: step ';
text2 = 'Bennete et al: step ';
legen_text = {};
for step = 1:numel(steps)
   legen_text{step} = strcat(text, num2str(steps(step)));
   legen_text{step + numel(steps)} = strcat(text2, num2str(steps(step)));
end
%%
figure
hold on
plot(F,max_fidelity,'-','LineWidth',3)
plot(F,bennete_et_al_max_fidelity,'--','LineWidth',3)
plot(F,F,'black')
ax = gca;
ax.FontSize = 16; 
ax.XLabel.FontSize = 30;
legend(legen_text,"FontSize",12)
xlabel("Initial fidelity",'FontWeight','bold');
ylabel("Output fidelity","FontSize",24,'FontWeight','bold');
xlim([0.5,0.99]);
title('The comparision between Bennett et al. and Deutsch et al.',"FontSize",24,'FontWeight','bold')
grid on
%%
figure 
hold on
plot(F,prob_of_success_,'-','LineWidth',3)
plot(F,bennete_et_al_prob_of_success,'--','LineWidth',3)
ax = gca;
ax.FontSize = 16; 
legend(legen_text,"FontSize",14)
xlabel("Initial fidelity","FontSize",24,'FontWeight','bold');
ylabel("Probability of success","FontSize",24,'FontWeight','bold');
xlim([0.5,0.99]);
title('The comparision between Bennett et al. and Deutsch et al. in terms of probability of success',"FontSize",24,'FontWeight','bold')

grid on
legend
%%
%% Try to duplicate the results for deutch et al.
disp("optimistic approach for deuetch et al");
consumed_total = zeros(5,3);
F = [0.8,0.85,0.90,0.95];
classical_steps_total = consumed_total;
max_step = 40;
steps_set = [1,5,10,20,30,40];
for fid = F
    fid
    for k = steps_set
        
        consumed = 0;
        delay = 0;
        for i = 1 : 1000
            %             fid_out = fid;
            not_succed = 1; %initialize the flag of success
           
            fid_in = fid; %make duetch et al matrix.
            fid_out = fid;
            A_temp = fid;
            A_out = fid;
            B_temp = 0;
            B_out = 0;
            C_temp = 0;
            C_out = 0;
            D_temp = 1-fid;
            D_out = 1-fid;
            fid_store = [];
            
            while(not_succed)
                for step  = 1: max_step
                    
                    [A_out,B_out,C_out,D_out,N] = Deutch([A_temp,A_out],[B_temp,B_out],[C_temp,C_out],[D_temp,D_out]);
                    r = rand;
                    if r >= N
                        
                        consumed = consumed + step + 1 +  meet(k,step,max_step);
                        delay = delay + ceil(step/k);
                        break;
                        
                    end
                    
                end
                if(step == 40)
                    consumed = consumed + max_step + 1;
                    not_succed = 0;
                    delay = delay + ceil(step/k);
                end
            end
            
            
        end
        
        consumed = consumed/1000;
        classical_steps_total(k == steps_set,fid == F) = delay/1000;
        consumed_total(k == steps_set,fid == F) = consumed;
        
    end
end
%%
%% "Average number of classical communication" VS "Average consumed bell pairs"
figure
hold on
for i = 1 : numel(F)
    plot((consumed_total(:,i)),(classical_steps_total(:,i)),'-O','LineWidth',4)
    
end

legend_text = {'Initial Fidelity = 0.8', 'Initial Fidelity = 0.85','Initial Fidelity = 0.9','Initial Fidelity = 0.95'};
hold on;
grid on
h = gca; % Get axis to modify
h.XAxis.MinorTick = 'on'; % M

[~, hobj, ~, ~] = legend(legend_text,"FontSize",14,"LineWidth",4);
hl = findobj(hobj,'type','line');
set(hl,'LineWidth',4);
ylabel("The log of the average number of classical communication","FontSize",14);
xlabel("The log of the average consumed bell pairs","FontSize",14);
title("Effect of optimistic approach in Deutsch et al.");
%%  "optimistic for k = 1 : 10" VS "Average consumed bell pairs"
figure
hold on
for i = 1: numel(F)
    plot(steps_set,(consumed_total(:,i)),'-O','LineWidth',4)
    
end

legend_text = {'Initial Fidelity = 0.8', 'Initial Fidelity = 0.85','Initial Fidelity = 0.9','Initial Fidelity = 0.95'};
hold on;
grid on
h = gca; % Get axis to modify
h.XAxis.MinorTick = 'on'; % M

[~, hobj, ~, ~] = legend(legend_text,"FontSize",14,"LineWidth",4);
hl = findobj(hobj,'type','line');
set(hl,'LineWidth',4);
ylabel("The log of average number of consumed bell pairs","FontSize",14);
xlabel("Index of step which we check the purification result","FontSize",14);
title("Effect of optimistic approach on the log of the average number of consumed bell pairs");
%%  "Average number of classical communication" VS "Average consumed bell pairs"
figure
hold on
for i = 1: numel(F)
    plot(steps_set,(classical_steps_total(:,i)),'-O','LineWidth',4)
    
end

legend_text = {'Initial Fidelity = 0.8', 'Initial Fidelity = 0.85','Initial Fidelity = 0.9','Initial Fidelity = 0.95'};
hold on;
grid on
h = gca; % Get axis to modify
h.XAxis.MinorTick = 'on'; % M

[~, hobj, ~, ~] = legend(legend_text,"FontSize",14,"LineWidth",4);
hl = findobj(hobj,'type','line');
set(hl,'LineWidth',4);
ylabel("The log of average number of classical communication","FontSize",14);
xlabel("Index of step which we check the purification result","FontSize",14);
title("Effect of optimistic approach on the log of the average number of classical communication for different number of steps");