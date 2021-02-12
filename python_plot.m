%%
% depolarization rate for the channel is 1e+2 for memories are 1 the
%  Photon survival probability per channel length [dB/km] is 0.1.
fidelity=[0.9979999999999999,
 0.9939999999999999,
 0.9709999999999999,
 0.9569999999999999,
 0.8999999999999999,
 0.8009999999999999,
 0.6169999999999999,
 0.30399999999999994,
 0.08799999999999998];

distance = [0.1, 0.5, 1, 2, 5, 10, 20, 50, 100];

plot(distance, fidelity, 'LineWidth',4)
xlabel('Distance in km','FontSize',14);
ylabel('f_0','FontSize',14);
title('The effect of distance on initial fidelity','FontSize',16)
grid on;
%%
% depolarization rate for the channel is 1e+3 for memories are 1e+2 the
%  Photon survival probability per channel length [dB/km].
fidelity = [0.9939999999999999,
 0.9819999999999999,
 0.9549999999999998,
 0.9329999999999999,
 0.8179999999999998,
 0.7089999999999999,
 0.4779999999999999]
distances = [1, 5, 10, 20, 50, 100,200];
plot(distances, fidelity, 'LineWidth',4)
xlabel('Distance in km','FontSize',14);
ylabel('f_0','FontSize',14);
title('The effect of distance on initial fidelity','FontSize',16)
grid on;
%%
hold on
distances = [1, 5, 10, 20, 50, 100,200];
probs = exp(-distances./200000.*1000).*exp(-distances./200000.*100);
plot(distances,probs)
%%
eta = @(L) 10^(-0.1*0.2*L) 
%%
p = @(L) 0.1*eta(L) 
%% The alone processor with sync depolarization error model

fidelity_list = [0.9998999999999998,
 0.9987999999999998,
 0.9965999999999998,
 0.9849999999999998,
 0.8639999999999998,
 0.7437999999999999,
 0.35179999999999995,
 0.25149999999999995];

waiting = [1,1e+3,2e+3,1e+4,1e+5,2e+5,1e+6,1e+9].*1e-9;

plot(waiting(1:7), fidelity_list(1:7), 'LineWidth',4)
xlabel('Time ','FontSize',14);
ylabel('f_0','FontSize',14);
title('The effect of memory depilarization on fidelity','FontSize',16)
grid on;
hold on
analytical_fidelity = zeros(1,8);

for i = 1:8
    prob = 1-exp(-waiting(i)/1e-3);
    
    analytical_fidelity(i) = (1-prob*3/4)^2+3*(prob/4)^2;
end

plot(waiting(1:7),analytical_fidelity(1:7),'-*', 'LineWidth',4)
% plot(waiting(1:7),analytical_fidelity(1:7)' - fidelity_list(1:7),'-*')
plot(waiting(1:7),exp(-waiting(1:7)/1e-3))
legend({'simulated asyng error','analytical async error', 'analytical sync error'},'FontSize',14)
%% plot for the puyrify.py for different distances for only filtering
%  number of experiments is 1e+5
fidelity_list = [0.919945, 0.909385, 0.88037, 0.75431, 0.68326, 0.62268, 0.573045];
    distances = [1,2,5,20,30,40,50]; % in km
    plot(distances,fidelity_list,'-O','LineWidth',4)
    title('Purifying with filtring')
    grid on
%% plot for the puyrify.py for different distance adding several memories
% for filtering and distilation
%  number of experiments is 1e+5
fidelity_list_distilation =[0.988, 0.978, 0.95, 0.811, 0.726, 0.659, 0.608];
fidelity_list_filtering = [0.991, 0.98, 0.942, 0.801, 0.726, 0.632, 0.595];
distances = [1,2,5,20,30,40,50]; % in km
plot(distances,fidelity_list_distilation,'-O','LineWidth',4)
hold on
plot(distances,fidelity_list_filtering,'--*','LineWidth',4)
title('Purifying with filtring and distilation')
grid on
xlabel('Time ','FontSize',14);
ylabel('f_0','FontSize',14);
legend({'Distilation','Local Filtering'},'FontSize',14)

    
