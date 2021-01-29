%%
% depolarization rate for the channel is 1e+2 for memories are 1 the
%  Photon survival probability per channel length [dB/km] is 0.1.
[0.9979999999999999,
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