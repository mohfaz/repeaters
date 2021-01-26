%% Plot properties
xlabel_fontsize = 24;

%% plot fidelity F = (f1,f2) in 3d;
syms f1
syms f2
f = (f1*f2 + 1/9*(1-f1)*(1-f2))/(f1*f2+1/3*f1*(1-f2)+1/3*f2*(1-f1)+5/9*(1-f1)*(1-f2));
fig = figure,
fsurf(f,[0.5,1])

xlabel("F_1");
ylabel("F_2");
zlabel("Fidelity");
title("Fidelity after performing purification on f_1 and f_2")
savefig(fig)
%% plot hitmap of fidelity
f1 = [0:0.01:1];
f2 = [0:0.01:1];
output = zeros([length(f1),length(f1)]);
for i = 1:numel(f1)
    for j = 1:numel(f1)
        if(i>=j)
            output(numel(f1)-i+1,j) = fidelity(f1(i),f2(j));
        else
            %          output(numel(f1)-i+1,j) = prob_of_success(f1(i),f2(j));
            output(numel(f1)-i+1,j) = fidelity(f1(i),f2(j));
            
        end
    end
end

clf


p1 = heatmap(f1,flip(f2),output);
snapnow
colormap jet
snapnow
xlabel("F_1")
ylabel("F_2")
title("Heatmap for fidelity")
hs = gcf
savefig(hs,"fidelity_heatmap.fig")
%%
%% plot contour for fidelity and the probability of success
f1 = [0:0.01:1];
f2 = [0:0.01:1];
output = zeros([length(f1),length(f1)]);
for i = 1:numel(f1)
    for j = 1:numel(f1)
        if(i>=j)
            output(numel(f1)-i+1,j) = fidelity(f1(i),f2(j));
        else
            output(numel(f1)-i+1,j) = prob_of_success(f1(i),f2(j));
            %          output(numel(f1)-i+1,j) = fidelity(f1(i),f2(j));
            
        end
    end
end

clf


p1 = heatmap(f1,flip(f2),output);
snapnow
colormap jet
snapnow
xlabel("F_1")
ylabel("F_2")
title("Heatmap for fidelity of purification results for F_1 and F_2 (only one step)")
hs = gcf
savefig(hs,"fidelity_prob_of_success_heatmap.fig")

%%
figure
contourf(f1,f2,flip(output))
colorbar;
colormap jet
xlabel("F_1")
ylabel("F_2")
title("Contour plot for fidelity and the prob. of success");
grid on
%% plot x(i.e. the distance) v.s. given Fidelity.
syms f
x = (8*f^3 - 14*f^2 + 7*f - 1)/(8*f^2 - 12*f + 1);

fig = figure,
fplot(x,[0.5,1])
legend("Distance")
xlabel("Fidelity");
ylabel("F");
title("Plot of the distance for fidelity")
savefig(fig)
saveas(fig,'Plot_of_the_distance_for_fidelity.jpg','jpg');
%% Plot increase vs in the input fidelity
interval =   [0.5:0.001:1];
fidelity_max = [];
for i = 1:length(interval)
    fidelity_max = [fidelity_max,fidelity(interval(i),interval(i))-interval(i)];
end

% initialize the figure and full screen the fig.
fig = figure('units','normalized','outerposition',[0 0 1 1]);

% plot
plot(interval,fidelity_max,'Color',[0.4940 0.1840 0.5560],'LineWidth',3.5)
grid on

% set legend

% set xlabel.
xlabel("F_1 = F_2",'FontSize',20,'FontWeight','bold');

% set ylabel and the change the position to make i t more readable
yy = ylabel({"Increase", "in", "fidelity"},'FontSize',20,'FontWeight','bold');
pos=get(yy,'Position');
pos1=pos-[0.02,0,0];
set(yy,'Position',pos1);
% Set the rotation.
yy.Rotation = 0;
% change the font and style in the axis.
ax = gca;
ax.FontSize = 13;
ax.FontWeight = 'bold';
datacursormode on
hold on;

% set the title
title("Increase in amount of fidelity after performing one step purification",'FontSize',24,'FontWeight','bold')

[maximum,max_index] = max(fidelity_max);
xline(interval(max_index),'-.','Fidelity for maximum gain = 0.7710','LabelVerticalAlignment','middle')
yline(fidelity_max(max_index),'r--','Maximum gain = 0.0388')
% save the figure.
legend("Increase in fidelity",...
    'location','South','FontSize',20,'FontWeight','bold')

savefig(fig)
saveas(fig,'Plot_of_increase_in_fidelity.jpg','jpg');
%%
%%
f1 = [0.5:0.001:1];
f2 = [0.5:0.001:1];
fidelity_output = zeros([length(f1),length(f1)]);
prob_of_success_data = zeros([length(f1),length(f1)]);
for i = 1:numel(f1)
    for j = 1:numel(f1)
        if(i>=(j))
            fidelity_output(numel(f1)-i+1,j) =  fidelity(f1(i),f2(j)) - max(f1(i),f2(j));
        elseif i<(j)
            prob_of_success_data(numel(f1)-i+1,j) = prob_of_success(f1(i),f2(j));
            %          output(numel(f1)-i+1,j) = fidelity(f1(i),f2(j));
            
        end
        %  output(numel(f1)-i+1,j) =  fidelity(f1(i),f2(j)) - max(f1(i),f2(j));
    end
end
% define the figure and fullscreen the size of figure
fidelity_output(fidelity_output<=0) = -10;
%
fig = figure('Units','normalized','OuterPosition',[0,0,1,1]);

[X,Y] = meshgrid(f1,f2);
% define level for the increase.
levels = [0,0.01, 0.02, 0.03, 0.04];



nMdls = 2;
Axes = zeros(nMdls);
Axes(1) = axes;
hold 'on'

%plot above of diag ,
[c,p1] = contourf(Axes(1),f1,f2,flip(fidelity_output), levels);
clabel(c,p1,'FontSize',15,'Color','b','FontName','Courier')
colorbar('Location','northoutside')
colormap jet
xlabel("F_1",'FontSize',20,'FontWeight','bold')
ylabel("F_2",'FontSize',20,'FontWeight','bold')
% change the font and style in the axis.
ax = gca;
ax.FontSize = 13;
ax.FontWeight = 'bold';

grid on
% plot down of of dia
pause
Axes(2) = axes;
levels = [0.1:0.1:0.9];
[c,p1] = contourf(Axes(2),f1,f2,flip(prob_of_success_data), levels, 'ShowText', 'on');
clabel(c,p1,'FontSize',15,'Color',	'black','FontName','Courier')
% separate
hold on
x = linspace(0.5,1);
plot(x,x,'LineWidth',5,'Color','black');
%

colorbar('Location','southoutside')

linkaxes(Axes)
set(Axes(2), 'visible', 'off');
set(Axes(2), 'XTick', []);
set(Axes(2), 'YTick', []);



% savefig(fig)
% saveas(fig,'plot_test.jpg','jpg');
%% useless code
% nMdls = 2;
% Axes = zeros(nMdls);
% Axes(1) = axes;
% %%Create the first axis and plot the contours
% [x,y,z] = peaks;
% hold 'on'
% for i = 1:2:10
%     contour(Axes(1),x,y,z, [i, i],'r', 'ShowText', 'on')
% end
% %%Create the second axis and plot the contours
% Axes(2) = axes;
% z2 = z * 1000; %Change the order of magnitude of the orignal z-data
% hold 'on'
% for i = 2000:2000:10000
%     contour(Axes(2),x,y,z2, [i, i],'b', 'ShowText', 'on');
% end
% linkaxes(Axes)
% %%Hide the top axes
% % set(Axes(2), 'visible', 'off');
% % set(Axes(2), 'XTick', []);
% % set(Axes(2), 'YTick', []);
%% counter  fidelity prob of success with labels
f1 = [0.5:0.001:1];
f2 = [0.5:0.001:1];
fidelity_output = zeros([length(f1),length(f1)]);
prob_of_success_data = zeros([length(f1),length(f1)]);
for i = 1:numel(f1)
    for j = 1:numel(f1)
        if(i>=(j))
            fidelity_output(numel(f1)-i+1,j) =  fidelity(f1(i),f2(j));
        elseif i<(j)
            prob_of_success_data(numel(f1)-i+1,j) = prob_of_success(f1(i),f2(j));
            %          output(numel(f1)-i+1,j) = fidelity(f1(i),f2(j));
            
        end
        %  output(numel(f1)-i+1,j) =  fidelity(f1(i),f2(j)) - max(f1(i),f2(j));
    end
end
% define the figure and fullscreen the size of figure
max(max(fidelity_output))
min(min(fidelity_output))

%%
fig = figure('Units','normalized','OuterPosition',[0,0,1,1]);

% define level for the increase.
levels = [0.1:0.1:1];
nMdls = 2;
Axes = zeros(nMdls);
Axes(1) = axes;
hold 'on'

%plot above of diag ,
[c,p1] = contourf(Axes(1),f1,f2,flip(fidelity_output), levels);
clabel(c,p1,'FontSize',15,'Color','b','FontName','Courier')
colorbar('Location','northoutside')
colormap jet

% plot down of of dia
pause
Axes(2) = axes;
levels = [0.1:0.1:1];
[c,p1] = contourf(Axes(2),f1,f2,flip(prob_of_success_data), levels, 'ShowText', 'on');
clabel(c,p1,'FontSize',15,'Color',	'b','FontName','Courier')
colorbar('Location','southoutside')
hold on
% separate

% colorbar('Location','southoutside')
%
linkaxes(Axes)
set(Axes(2), 'visible', 'off');
set(Axes(2), 'XTick', []);
set(Axes(2), 'YTick', []);


xlabel("F_1",'FontSize',20,'FontWeight','bold')
ylabel("F_2",'FontSize',20,'FontWeight','bold')
% change the font and style in the axis.
ax = gca;
ax.FontSize = 13;
ax.FontWeight = 'bold';
x = linspace(0.5,1);
plot(x,x,'LineWidth',9,'Color','black');


grid on
% savefig(fig)
% saveas(fig,'plot_test.jpg','jpg');
%% Plot the fidelity required steps and
f_in = [0.9 : 0.01 : 0.99];
fid = zeros(size(f_in));
steps = zeros([length(f_in), length(f_in)]);
out_put = cell(2,length(f_in));

for i = 1: length(f_in)
    
    prev_step = f_in(i);
    counter = 0;
    steps = [];
    f_out = [];
    temp = -inf;
    steps = [counter, steps];
    f_out = [f_out, prev_step];
    while prev_step < 1-1e-6
        
        counter = counter + 1;
        steps = [steps,counter];
        temp = prev_step;
        prev_step = fidelity(prev_step,prev_step);
        f_out = [f_out, prev_step];
        
    end
    
    out_put{1,i} = f_out;
    out_put{2,i} = steps;
    
end
%%
max_size = 31;
f_out = zeros(max_size,length(f_in));
steps = f_out;

for i = 1:length(f_in)
    f_out_temp =  out_put{1,i};
    f_out_temp = [f_out_temp,ones(1,max_size - length(f_out_temp))];
    f_out(:,i) = f_out_temp';
    
    steps_temp = out_put{2,i};
    steps_temp  = [steps_temp, ones(1, max_size - length(steps_temp))*max(steps_temp)];
    steps(:,i) = steps_temp';
    
end
%% plot # of steps to reach a certian fidelity  and the probability for that.
f_in = [0.9 : 0.005 : 1];
f_out = [0.9 : 0.005 : 1];
steps = zeros(length(f_in), length(f_out));
probs = zeros(length(f_in), length(f_out));
for i  = 1:length(f_in)
    for j= 1:length(f_out)
        if(f_in(i) == 0.9 && f_out(j) == 1)
            [steps(i,j), probs(j,i)] =  count_steps(f_in(i),f_out(j));
        end
        [steps(i,j), probs(j,i)] =  count_steps(f_in(i),f_out(j));
        
    end
    
    
end
%%
steps = steps + probs;
%%
steps = fliplr(steps);
%%
figure,
levels = [0,1,2,4,6,8,16,20,25,30];
[c,p1] = contourf(f_in,f_out,flip(steps),levels);
colorbar('Location','northoutside')
xlabel("F_{in}/F_{out}",'FontSize',15);
ylabel("F_{out}/F_{in}",'FontSize',15);
title("Number of steps",'FontSize',15);
clabel(c,p1,'FontSize',15,'Color',	[220,20,60]./255,'FontName','Courier')
ax = gca;
ax.FontSize = 12;
%%

probs = fliplr(probs);
probs = flip(probs);
%%
figure

levels = [0.7:0.05:0.9];
[c,p1] = contourf(f_in,f_out,probs,levels)
colorbar('Location','southoutside');
xlabel("F_{in}",'FontSize',15);
ylabel("F_{out}",'FontSize',15);
title("Steps of steps",'FontSize',15);
clabel(c,p1,'FontSize',15,'Color',	[220,20,60]./255,'FontName','Courier')
ax = gca;
ax.FontSize = 12;

%% Adding memory to the model. [stephanie's paper]
% plot F vs T
figure,
p = [0.8,0.85,0.9,0.95,.99];
time = [1:100];
hold on
for p_ = p
    fidel = memory_fidelity(p_,time);
    plot(time,fidel,'LineWidth',8);
    
end
grid on
xlabel("Time Steps",'FontSize',15)
ylabel("Fidelity",'FontSize',15)
title("Fidelipty after t time step storage ",'FontSize',15)
legend({'Noise factor = 0.8', 'Noise factor = 0.85','Noise factor = 0.9','Noise factor = 0.95','Noise factor = 0.99'},'FontSize',15)
%% Adding memory to the model. [stephanie's paper]
%plot f_th vs T_th
p = [0.8,0.85,0.9,0.95,.99];
T_th = floor(Tthereshold(p,0.5));
plot(p,T_th,'LineWidth',3)
grid on
ylabel("Maximum Time steps",'FontSize',15)
xlabel("Given Noise",'FontSize',15)
title("",'FontSize',15)
%% (SCHEME C) pumping model with memory depolarization and also bennet et
%al purification scheme the original paper (BDCZ) suggested to use deutch
%et al for purification for now we use bennete et. al
F = [0.9:0.001:0.99];
p =[1,0.99,0.98,0.97]; % 1 - p is the depolarization power
total_gain = cell(size(p));
total_steps = total_gain;
for noise = p
    noise
    gain = zeros(numel(F),numel(F));
    steps_ = gain;
    prob_of_success_output = gain;
    for pair_swaped = F
        
        for auxulary_pair = F
            if pair_swaped < auxulary_pair || pair_swaped - auxulary_pair > returnx(pair_swaped)
                continue
            end
            F_output = pair_swaped;
            F_prev_step = -inf;
            steps = 0;
            probofsuccess = 1;
            %         if(pair_swaped == F(5))
            %             1 + 1
            %         end
            while(F_output ~=F_prev_step &&  F_output > F_prev_step )
                F_prev_step = F_output ;
                
                F_temp = fidelity(F_output,auxulary_pair);
                F_temp = F_temp * noise + (1 - noise)/4;
                
                if(F_temp <= F_output)
                    if steps == 0
                        probofsuccess  = 0;
                    end
                    continue
                end
                F_output = F_temp;
                probofsuccess = probofsuccess * prob_of_success(F_output,auxulary_pair);
                
                steps = steps + 1;
                
            end
            prob_of_success_output(F == pair_swaped,F == auxulary_pair) = probofsuccess;
            gain(F == pair_swaped,F == auxulary_pair) = F_output - pair_swaped;
            steps_(F == pair_swaped,F == auxulary_pair) = steps;
        end
        
    end
    
    gain(gain == 0) = NaN;
    total_gain{p == noise} = gain;
    steps_(steps_ == 0) = NaN;
    total_steps{p == noise} = steps_;
end

%% now plot gain in fidelity
figure
hold on
for i = 1: 3
    surf(F,F,total_gain{i})
    colorbar;
    colormap jet
    
end

xlabel("F_1")
ylabel("F_2")
title("Contour plot for fidelity and the prob. of success");
grid on
view(3)
%% plot steps
figure
hold on
view(3)

for i = 3: 3
    surf(F,F,total_steps{i})
    pause
    colorbar;
    colormap jet
    
end


xlabel("F_1")
ylabel("F_2")
title("Contour plot for fidelity and the prob. of success");
grid on


%% OPTIMISTIC (SCHEME C) pumping model with memory depolarization and also bennet et
%al purification scheme the original paper (BDCZ) suggested to use deutch
%et al for purification for now we use bennete et. al
F = [0.9:0.001:0.99];
p =[0.99]; % 1 - p is the depolarization power
noise = p;
k = [1,2,3,4,5,6,7,8];
total_gain = cell(size(k));
total_steps = total_gain;

for check_step = k
    check_step
    
    gain = zeros(numel(F),numel(F));
    steps_ = gain;
    prob_of_success_output = gain;
    for pair_swaped = F
        
        for auxulary_pair = F
            if pair_swaped < auxulary_pair || pair_swaped - auxulary_pair > returnx(pair_swaped)
                continue
            end
            F_output = pair_swaped;
            F_prev_step = -inf;
            steps = 0;
            probofsuccess = 1;
            %         if(pair_swaped == F(5))
            %             1 + 1
            %         end
            while(F_output ~=F_prev_step &&  F_output > F_prev_step )
                F_prev_step = F_output ;
                
                F_temp = fidelity(F_output,auxulary_pair);
                steps = steps + 1;
                if(rem(steps,check_step) == 0 )
                    F_temp = F_temp * noise + (1 - noise)/4;
                end
                if(F_temp <= F_output)
                    if steps == 0
                        probofsuccess  = 0;
                    end
                    continue
                end
                F_output = F_temp;
                probofsuccess = probofsuccess * prob_of_success(F_output,auxulary_pair);
                
                
                
            end
            prob_of_success_output(F == pair_swaped,F == auxulary_pair) = probofsuccess;
            gain(F == pair_swaped,F == auxulary_pair) = F_output - pair_swaped;
            steps_(F == pair_swaped,F == auxulary_pair) = steps;
        end
        
    end
    
    gain(gain == 0) = NaN;
    total_gain{k == check_step} = gain;
    steps_(steps_ == 0) = NaN;
    total_steps{k == check_step} = steps_;
end
%%
figure
hold on
view(3)
grid on
for i = 1: numel(total_gain)
    
    colorbar;
    colormap jet
    pause
end

xlabel("F_1")
ylabel("F_2")
title("Contour plot for fidelity and the prob. of success");
%%
%figure
% hold on
max_fidel = [];
for i = 1 : numel(total_gain)
    
    max_fidel = [max_fidel, max(max( total_gain{i}))];
end
plot(k,max_fidel,"LineWidth",3)


%%
% %%
% F = [0.9:0.01:0.99];
% main_gain = {};
% depolarization_power = [0,0.98,0.99,1];
% for p = depolarization_power % 1 - p is the depolarization power
%
%     gain = zeros(numel(F),1);
%     prob_of_success_output = gain;
%     steps = 0;
%     for pair = F
%
%         F_output = pair;
%         F_prev_step = -inf;
%
%         while(F_output ~= F_prev_step &&  F_output >= F_prev_step )
%             F_prev_step = F_output ;
%
%             F_temp = fidelity(F_output,F_output);
%             F_temp = F_temp * p + (1-p)/4;
%
%             if(F_temp <= F_output)
%                 if steps == 0
%                     probofsuccess  = 0;
%                 end
%                 continue
%             end
%             F_output = F_temp;
%             probofsuccess = probofsuccess * prob_of_success(F_output,F_output);
%
%             steps = steps + 1;
%
%         end
%         % prob_of_success_output(F == pair_swaped,F == auxulary_pair) = probofsuccess;
%         gain(F == pair) = F_output - pair;
%
%
%     end
%     % gain(gain == 0) = NaN;
%
%     main_gain{depolarization_power == p } = gain;
% end
%
% %% now plot
% % figure
% % contourf(F,F,gain)
% % colorbar;
% % colormap jet
% % xlabel("F_1")
% % ylabel("F_2")
% % title("Contour plot for fidelity and the prob. of success");
% % grid on
% %%
% figure
% hold on
% for gain = main_gain
%     gain = cell2mat(gain)
%     scatter(F,gain,80 ,'filled')
% end
% lgd = legend('Depolarization power = 1','Depolarization power = 0.02','Depolarization power = 0.01','Depolarization power = 0')
% lgd.FontSize = 14;
% grid on;
% xlabel("Fidelity",'FontSize',14)
% ylabel("Increase of Fidelity",'FontSize',14)
% title("Increase of Fidelity in parallel method",'FontSize',14)
%% Scheme (C) using getting maximum without noise memory
F = [0.5:0.001:1];
F_accum = [];
for fid = F
    F_output = fid;
    F_prev = -inf;
    while( abs(F_prev - F_output) > 1e-13)
        F_prev = F_output;
        F_output = fidelity(fid,F_output);
        
    end
    F_accum = [F_accum, F_output];
end
plot(F,F,'black',"LineWidth",3)
hold on
grid on
p1 = gca; % Get axis to modify
p1.XAxis.MinorTick = 'on'; % M
plot(F,F_accum,"LineWidth",3)
legend("fixed point","Reachable Fidelity")
xlabel("Initial Fidelity",'FontSize',15)
ylabel("Reachable Fidelity","FontSize",15)
%%
%% Scheme (C) using getting maximum without noise memory
F = [0.5:0.001:1];
steps = [1,2,3,4,5,10,40];
F_output = [];

for step = steps
    f_rep = [];
    for fid = F
        
        
        fidelity_in = fid;
        f_out = fidelity_in;
        for i = 1 : step
            f_out = fidelity(f_out,fidelity_in);
        end
        f_rep = [f_rep; f_out];
    end
    F_output =[F_output,f_rep];
end
figure
plot(F,F_output,'LineWidth',4,'LineStyle','--');
hold on;
grid on
p1 = gca; % Get axis to modify
p1.XAxis.MinorTick = 'on'; % M
plot(F,F,'LineWidth',3,'Color',[0,0,0]);
legend_text = {};
for  i  = 1: numel(steps)
    legend_text{i} = strcat('Steps: ', num2str(steps(i)));
    
end
[~, hobj, ~, ~] = legend(legend_text,"FontSize",14,"LineWidth",4);
hl = findobj(hobj,'type','line');
set(hl,'LineWidth',4);
xlabel("Input Fidelity","FontSize",14);
ylabel("Achievable Fidelity","FontSize",14);
%% Plot the delay vs number of missing bell pairs
consumed_total = zeros(5,3);
F = [0.8,0.85,0.90,0.95];
classical_steps_total = consumed_total;
max_step = 10;
for fid = F
    fid
    for k = 1:10
        
        consumed = 0;
        delay_temp = 0;
        for i = 1 : 1000000
            fid_out = fid;
            not_succed = 1;
            while(not_succed)
                for step  = 1: max_step
                    prob = prob_of_success(fid_out,fid);
                    r = rand;
                    if r < prob
                        fid_out = fidelity(fid_out,fid);
                    else
                        
                        consumed = consumed + step + 1 +  meet(k,step,max_step);
                        delay_temp = delay_temp + ceil(step/k);
                        break;
                    end
                    
                end
                if(step == 10)
                    consumed = consumed + max_step + 1;
                    not_succed = 0;
                    delay_temp = delay_temp + ceil(step/k);
                end
            end
            
            
        end
        
        consumed = consumed/1000000;
        classical_steps_total(k,fid == F) = delay_temp/1000000;
        consumed_total(k,fid == F) = consumed;
        
    end
end
%% "Average number of classical communication" VS "Average consumed bell pairs"
figure
hold on
for i = 1: 4
    plot(consumed_total(:,i),classical_steps_total(:,i),'-O','LineWidth',4)
    
end

legend_text = {'Initial Fidelity = 0.8', 'Initial Fidelity = 0.85','Initial Fidelity = 0.9','Initial Fidelity = 0.95'};
hold on;
grid on
p1 = gca; % Get axis to modify
p1.XAxis.MinorTick = 'on'; % M

[~, hobj, ~, ~] = legend(legend_text,"FontSize",14,"LineWidth",4);
hl = findobj(hobj,'type','line');
set(hl,'LineWidth',4);
ylabel("Average number of classical communication","FontSize",14);
xlabel("Average consumed bell pairs","FontSize",14);
title("Effect of optimistic approach, k is 1 to 10 ");
%%  "optimistic for k = 1 : 10" VS "Average consumed bell pairs"
figure
hold on
for i = 1: 4
    plot(1:10,consumed_total(:,i),'-O','LineWidth',4)
    
end

legend_text = {'Initial Fidelity = 0.8', 'Initial Fidelity = 0.85','Initial Fidelity = 0.9','Initial Fidelity = 0.95'};
hold on;
grid on
p1 = gca; % Get axis to modify
p1.XAxis.MinorTick = 'on'; % M

[~, hobj, ~, ~] = legend(legend_text,"FontSize",14,"LineWidth",4);
hl = findobj(hobj,'type','line');
set(hl,'LineWidth',4);
ylabel("Average number of consumed bell pairs","FontSize",14);
xlabel("Index of step which we check the purification result","FontSize",14);
title("Effect of optimistic approach on average number of consumed bell pairs, k is 1 to 10 ");
%%  "Average number of classical communication" VS "Average consumed bell pairs"
figure
hold on
for i = [1: 4]
    plot(1:10,classical_steps_total(:,i),'-O','LineWidth',4)
    
end

legend_text = {'Initial Fidelity = 0.8', 'Initial Fidelity = 0.85','Initial Fidelity = 0.9','Initial Fidelity = 0.95'};
hold on;
grid on
p1 = gca; % Get axis to modify
p1.XAxis.MinorTick = 'on'; % M

[~, hobj, ~, ~] = legend(legend_text,"FontSize",14,"LineWidth",4);
hl = findobj(hobj,'type','line');
set(hl,'LineWidth',4);
ylabel("Average number of classical communication","FontSize",14);
xlabel("Index of step which we check the purification result","FontSize",14);
title("Effect of optimistic approach on average number of classical communication , k is 1 to 10 ");
%% plot the fraction of times
total_usage_link = classical_steps_total + consumed_total;
fraction_classical = classical_steps_total./total_usage_link;
figure
hold on
for i = [1, 4]
    plot(1:10,fraction_classical(:,i),'-O','LineWidth',4)
    
end





hold on;
grid on
p1 = gca; % Get axis to modify
p1.XAxis.MinorTick = 'on'; % M

%
hl = findobj(hobj,'type','line');
set(hl,'LineWidth',4);
ylabel("Average fraction of link used by classical communication","FontSize",14);
xlabel("Index of step which we check the purification result","FontSize",14);
title("Effect of optimistic approach on average number of classical communication link fraction , k is 1 to 10, p is 1");



total_usage_link = classical_steps_total + consumed_total./0.7;
fraction_classical = classical_steps_total./total_usage_link;

for i = [1, 4]
    plot(1:10,fraction_classical(:,i),'-O','LineWidth',4)
    
end

total_usage_link = classical_steps_total + consumed_total./0.5;
fraction_classical = classical_steps_total./total_usage_link;

for i = [1, 4]
    plot(1:10,fraction_classical(:,i),'-O','LineWidth',4)
    
end

legend_text = {'Initial Fidelity = 0.8, p = 1', 'Initial Fidelity = 0.95, p = 1',...
    'Initial Fidelity = 0.8, p = .7', 'Initial Fidelity = 0.95, p = .7',...
    'Initial Fidelity = 0.8, p = .5', 'Initial Fidelity = 0.95, p = .5'};
[~, hobj, ~, ~] = legend(legend_text,"FontSize",14,"LineWidth",4);
%%
total_usage_link = classical_steps_total + consumed_total;
figure
hold on
for i = [1: 4]
    plot(1:10,total_usage_link(:,i),'-O','LineWidth',4)
    
end





hold on;
grid on
p1 = gca; % Get axis to modify
p1.XAxis.MinorTick = 'on'; % M

%
hl = findobj(hobj,'type','line');
set(hl,'LineWidth',4);
ylabel("Average total number of communication usage","FontSize",14);
xlabel("Index of step which we check the purification result","FontSize",14);
title("Effect of optimistic approach on communication link , k is 1 to 10");
%%


total_usage_link = classical_steps_total + consumed_total./0.7;

for i = [1, 4]
    plot(1:10,total_usage_link (:,i),'-O','LineWidth',4)
    
end

total_usage_link = classical_steps_total + consumed_total./0.5;

for i = [1, 4]
    plot(1:10,total_usage_link(:,i),'-O','LineWidth',4)
    
end

legend_text = {'Initial Fidelity = 0.8, p = 1', 'Initial Fidelity = 0.95, p = 1',...
    'Initial Fidelity = 0.8, p = .7', 'Initial Fidelity = 0.95, p = .7',...
    'Initial Fidelity = 0.8, p = .5', 'Initial Fidelity = 0.95, p = .5'};
[~, hobj, ~, ~] = legend(legend_text,"FontSize",14,"LineWidth",4);
%% simulating for gayane's approach
F = [0.8,0.85,0.90,0.95];
max_step = 10;
consumed_total = zeros(max_step,numel(F));

classical_steps_total = consumed_total;
bell_pair_time = classical_steps_total;

probability_of_generating_bellpairs = 0.8;
for fid = F
    fid
    for k = 1:10
        
        consumed = 0;
        delay_temp = 0;
        
        t1 = 1;
        for i = 1 : 1000000
            fid_out = fid;
            not_succed = 1;
            while(not_succed)
                for step  = 1: max_step
                    prob = prob_of_success(fid_out,fid);
                    r = rand;
                    if r < prob % if the purification is successfull
                        fid_out = fidelity(fid_out,fid);
                        if step == max_step
                            continue
                        end
                    else
                        
                        consumed = consumed + step + 1 +  meet(k,step,max_step);
                        delay_temp = delay_temp + ceil(step/k);
                        break;
                    end
                    
                    bell_pair_generated = 0;
                    while(~bell_pair_generated) % generaing bell pair
                        if rand < probability_of_generating_bellpairs
                            t1 = t1 + 1;
                            delay_temp = delay_temp + 1;
                            bell_pair_generated = 1;
                        else
                            t1 = t1 + 1;
                            delay_temp = delay_temp + 1;
                        end
                    end
                    
                end
                if(step == 10)
                    consumed = consumed + max_step + 1;
                    not_succed = 0;
                    delay_temp = delay_temp + ceil(step/k);
                end
            end
            
            
        end
        
        bell_pair_time(k,fid == F) = t1/1000000;
        consumed = consumed/1000000;
        classical_steps_total(k,fid == F) = delay_temp/1000000;
        consumed_total(k,fid == F) = consumed;
        
    end
end
%%
%% "Average number of classical communication" VS "Average consumed bell pairs"
figure
hold on
for i = 1: 4
    plot(consumed_total(:,i),classical_steps_total(:,i),'-O','LineWidth',4)
    
end

legend_text = {'Initial Fidelity = 0.8', 'Initial Fidelity = 0.85','Initial Fidelity = 0.9','Initial Fidelity = 0.95'};
hold on;
grid on
p1 = gca; % Get axis to modify
p1.XAxis.MinorTick = 'on'; % M

[~, hobj, ~, ~] = legend(legend_text,"FontSize",14,"LineWidth",4);
hl = findobj(hobj,'type','line');
set(hl,'LineWidth',4);
ylabel("Average number of classical communication","FontSize",14);
xlabel("Average consumed bell pairs","FontSize",14);
title("Effect of optimistic approach, k is 1 to 10 ");
%%  "optimistic for k = 1 : 10" VS "Average consumed bell pairs"
figure
hold on
for i = 1: 4
    plot(1:10,consumed_total(:,i),'-O','LineWidth',4)
    
end

legend_text = {'Initial Fidelity = 0.8', 'Initial Fidelity = 0.85','Initial Fidelity = 0.9','Initial Fidelity = 0.95'};
hold on;
grid on
p1 = gca; % Get axis to modify
p1.XAxis.MinorTick = 'on'; % M

[~, hobj, ~, ~] = legend(legend_text,"FontSize",14,"LineWidth",4);
hl = findobj(hobj,'type','line');
set(hl,'LineWidth',4);
ylabel("Average number of consumed bell pairs","FontSize",14);
xlabel("Index of step which we check the purification result","FontSize",14);
title("Effect of optimistic approach on average number of consumed bell pairs, k is 1 to 10 ");
%%  "Average number of classical communication" VS "Average consumed bell pairs"
figure
hold on
for i = [1: 4]
    plot(1:10,classical_steps_total(:,i) + bell_pair_time(:,i),'-O','LineWidth',4)
    
end

legend_text = {'Initial Fidelity = 0.8', 'Initial Fidelity = 0.85','Initial Fidelity = 0.9','Initial Fidelity = 0.95'};
hold on;
grid on
p1 = gca; % Get axis to modify
p1.XAxis.MinorTick = 'on'; % M

[~, hobj, ~, ~] = legend(legend_text,"FontSize",14,"LineWidth",4);
hl = findobj(hobj,'type','line');
set(hl,'LineWidth',4);
ylabel("Average number of classical communication","FontSize",14);
xlabel("Index of step which we check the purification result","FontSize",14);
title("Effect of optimistic approach on average number of classical communication , k is 1 to 10 ");
%%
F = [0.9,0.91,0.93,0.94];
expected_ebits = zeros(10,numel(F));
probability_of_generating_bellpairs = 0.8;

for fid_in = F
    
    for fid_out = 0.94345
        max_step = calculate_max_step(fid_in,fid_out);
        if isnan(max_step) || max_step   == 0
            expected_ebits(F == fid_in, F == fid_out, :) = nan;
            continue;
        end
        
        for k = 1:max_step
            
            consumed = 0;
            delay_temp = 0;
            
            t1 = 1;
            fid_out_temp = fid_out;
            for i = 1 : 1000000
                not_succed = 1;
                while(not_succed)
                    for step  = 1: max_step
                        prob = prob_of_success(fid_out_temp ,fid_in);
                        r = rand;
                        if r < prob % if the purification is successfull
                            fid_out_temp  = fidelity(fid_out_temp ,fid_in);
                            if step == max_step
                                continue
                            end
                        else
                            
                            consumed = consumed + step + 1 +  meet(k,step,max_step);
                            delay_temp = delay_temp + ceil(step/k);
                            break;
                        end
                        
                        bell_pair_generated = 0;
                        while(~bell_pair_generated) % generaing bell pair
                            if rand < probability_of_generating_bellpairs
                                t1 = t1 + 1;
                                delay_temp = delay_temp + 1; %classical communication.
                                bell_pair_generated = 1;
                            else
                                t1 = t1 + 1;
                                delay_temp = delay_temp + 1;
                            end
                        end
                        
                    end
                    
                    if(step == max_step)
                        
                        consumed = consumed + max_step + 1;
                        not_succed = 0;
                        delay_temp = delay_temp + ceil(step/k);
                        
                    end
                    
                end
                
                
            end
            
            bell_pair_time(k,fid_in == F) = t1/1000000;
            consumed = consumed/1000000;
            classical_steps_total(k,fid_in == F) = delay_temp/1000000;
            consumed_total(k,fid_in == F) = consumed;
            expected_ebits(k,fid_in == F)=delay_temp/1000000;
            
        end
        
        
        
    end
    
end
%%
figure,
plot(1:10,expected_ebits)
title("The expected time based on simulation for output fidelity equals to 0.94345")
xlim([1,10])
xlabel("The step we check the purification time")
ylabel("The expected time")
legend({"F_{in} - 0.90","F_{in} - 0.91","F_{in} - 0.93","F_{in} - 0.94"})
%% The  implementation of numerical approach for maximum k steps using bennett et al. scheme
F = [0.8,0.85,0.90,0.95];

max_step = 10;

steps_required_expectation = zeros(max_step,numel(F));

for f_0 = F % pick an initial fidelity
    
    for epoch_length = 1:10% pick the step which we want to check the
        % purification result
        %E_N_temp = step_check/(1-P_thru(f_0,0,step_check));
        E_N_temp = 0;
        for purification_step = epoch_length:epoch_length:max_step
            E_N_temp = 1/(P_thru(f_0,purification_step - epoch_length ,purification_step)) ...
                * ( epoch_length + E_N_temp);
            
            
        end
        
        if purification_step ~= max_step
            E_N_temp = 1/(P_thru(f_0, purification_step, max_step)) ...
                * ( max_step - purification_step + E_N_temp);
            
        end
        steps_required_expectation(epoch_length ,f_0 == F) = E_N_temp;
    end
    
    
end
steps_required_expectation
%%
figure,
plot(1:10, steps_required_expectation)
grid on;
hold on
xlabel("The step we check purification result")
ylabel("Expected value of steps")
title("The numerical approach")
xlim([1,10])
legend({"F_{in} - 0.8","F_{in} - 0.85","F_{in} - 0.9","F_{in} - 0.95"})
%% simulating

F = [0.8,0.85,0.90,0.95];
max_step = 10;
total_step = zeros(max_step, numel(F));

number_of_experiments = 1e+6;

for fid = F
    fid
    for k = 1:10
        
        consumed = 0;
        delay_temp = 0;
        total_step_temp = 0;
        
        for i = 1 : number_of_experiments
            not_succeed = 1;
            while(not_succeed)
                
                fid_out = fid;
                
                for step  = 1: max_step
                    total_step_temp = total_step_temp + 1;
                    
                    prob = prob_of_success(fid_out,fid);
                    r = rand;
                    if r < prob
                        
                        fid_out = fidelity(fid_out,fid);
                        
                    else
                        total_step_temp = total_step_temp + meet(k,step,max_step);
                        break;
                        
                    end
                    
                end
                
                if(step == max_step && r < prob)
                    not_succeed = 0;
                    
                end
            end
            
            
        end
        
        total_step(k, fid == F) = total_step_temp/number_of_experiments;
    end
    
end
total_step
%%
figure,
plot(1:10, steps_required_expectation,'LineWidth',3)

ax = gca;
ax.FontSize = 13;
ax.FontWeight = 'bold';
grid on;
hold on
plot(1:10, total_step,"--",'LineWidth',3)
legend({"Numerical: F_{in} - 0.8","Numerical: F_{in} - 0.85","Numerical: F_{in} - 0.9","Numerical: F_{in} - 0.95","Simulation: F_{in} - 0.8","Simulation: F_{in} - 0.85","Simulation: F_{in} - 0.9","Simulation: F_{in} - 0.95"})

xlabel("The step we check purification result","FontSize",23)
ylabel("Expected value of required steps","FontSize",23)
title("The numerical approach and simulation","FontSize",23)
xlim([1,10])

%%
% simulating

F = [0.8,0.85,0.90,0.95];
F = 0.8
max_step = 10;
consumed_total = zeros(max_step,numel(F));
classical_steps_total = consumed_total;
total_step = classical_steps_total;
number_of_experiments = 1e+6;

for fid = F
    fid;
    for k = 1
        
        consumed = 0;
        delay_temp = 0;
        total_step_temp = 0;
        
        for i = 1 : number_of_experiments
            
            fid_out = fid;
            not_succed = 1;
            while(not_succed)
                succeed = 1;
                for step  = 1: max_step
                    prob = prob_of_success(fid_out,fid);
                    r = rand;
                    if r < prob
                        
                        fid_out = fidelity(fid_out,fid);
                        total_step_temp = total_step_temp + 1.0;
                        if step == max_step
                            not_succed = 0;
                        end
                    else
                        total_step_temp = total_step_temp + 1.0;
                        break;
                        
                    end
                    
                end
                
            end
            
            
        end
        
        
        total_step(k, fid == F) = total_step_temp/number_of_experiments;
    end
end
total_step


%% test numerical with k = 1
F = 0.8;
max_step = 2;
step_temp = 0;
fid_temp = F;

for step = 1 : max_step
    
    prob_temp = prob_of_success(fid_temp,F);
    step_temp = (step_temp + 1)*1/(prob_temp);
    fid_temp = fidelity(fid_temp,F);
end
step_temp
%%
F = 0.8;
max_step = 2;
total_step = 0;

number_of_experiments = 1e+6;
for j = 1:number_of_experiments
    
    not_succeed = 1;
    while(not_succeed)
        fid_temp = F;
        for i = 1:max_step
            total_step = total_step + 1;
            prob_temp = prob_of_success(fid_temp,F);
            
            r = rand;
            if(r < prob_temp)
                fid_temp = fidelity(fid_temp,F);
                
            else
                
                break;
                
            end
            
            if(r < prob_temp && i == max_step)
                not_succeed = 0;
            end
            
            
            
        end
        
        
        
        
    end
    
    
    
end

total_step/number_of_experiments

%% The  implementation of numerical approach for "delay" maximum k steps using bennett et al. scheme
F = [0.8,0.85,0.90,0.95];
c = physconst('LightSpeed');
max_step = 10;
l= 10*1000;

T_2 = l/c; %classical communication
T_1 = 3e-9 + 2*T_2; % generating a Bell pair according 3ns + 2 classical communication
T_0 = T_1*2;
expected_delay = zeros(max_step,numel(T_1),numel(F));

P_B = 0.98;
for t_e = T_1
    for f_0 = F % pick an initial fidelity
        
        for epoch_length = 1:10% pick the step which we want to check the
            % purification result, (k in our notes)
            %E_N_temp = step_check/(1-P_thru(f_0,0,step_check));
            
            for purification_step = epoch_length:epoch_length:max_step   %iteration overcheckpoints
                if(purification_step == epoch_length)
                    E_E_temp = ((2*t_e)/P_B^2 + (epoch_length - 1) * t_e/P_B + T_2)/P_thru(f_0, purification_step - epoch_length, purification_step);
                    continue;
                end
                
                E_E_temp = 1/(P_thru(f_0, purification_step - epoch_length, purification_step)) ...
                    * ( epoch_length * t_e/P_B + T_2 + E_E_temp);
                
                
            end
            
            if  purification_step ~= max_step
                
                
                E_E_temp = 1/(P_thru(f_0, purification_step, max_step)) ...
                    * ( (max_step - purification_step)* t_e/P_B + T_2 + E_E_temp);
                
            end
            expected_delay(epoch_length ,t_e == T_1,f_0 == F) = E_E_temp;
        end
        
        
    end
    
end

expected_delay
%%
% % subplot(2,1,2)
figure,
hold on
for initial_fidelity = 1:numel(F)
    
    %plot([1:10]', (expected_delay(:,1,initial_fidelity)),'LineWidth',3)
    
    plot([1:10]', (expected_delay(:,1,initial_fidelity))...
        ./(expected_delay(1,1,initial_fidelity)),'LineWidth',3)
    
    
end



ax = gca;
ax.FontSize = 13;
ax.FontWeight = 'bold';
grid on;
%plot(1:10, delay,"--",'LineWidth',3)
legend({"Numerical: F_{in} - 0.8","Numerical: F_{in} - 0.85","Numerical: F_{in} - 0.9","Numerical: F_{in} - 0.95","Simulation: F_{in} - 0.8","Simulation: F_{in} - 0.85","Simulation: F_{in} - 0.9","Simulation: F_{in} - 0.95"})
% legend({"Numerical: F_{in} - 0.8","Numerical: F_{in} - 0.85","Numerical: F_{in} - 0.9","Numerical: F_{in} - 0.95"})

xlabel("The step we check purification result","FontSize",20)
ylabel("Expected value of Delay (s)","FontSize",20)
% title("The numerical approach","FontSize",20)
xlim([1,10])
%% Simulating the Delay

F = [0.8, 0.85, 0.90, 0.95];
max_step = 10;
delay = zeros(max_step, numel(F));

number_of_experiments = 1e+6;
% T_0 = 2;
% T_1 = 1;
% T_2 = 1;
% P_B = 0.8;
for fid = F
    fid
    for k = 1:10
        
        delay_temp = 0;
        for i = 1 : number_of_experiments
            
            not_succeed = 1; %set the flag for successfull experiment.
            while(not_succeed)
                
                fid_out = fid;
                while(rand > P_B^2) % generating Bell pairs at the beginning.
                    delay_temp = delay_temp + T_0;
                end
                delay_temp = delay_temp + T_0;
                
                for step  = 1: max_step % step of purificiation
                    if step ~= 1
                        while(rand > P_B) % % generating auxulary pair
                            delay_temp = delay_temp + T_1;
                        end
                        delay_temp = delay_temp + T_1;
                    end
                    prob = prob_of_success(fid_out,fid);
                    r = rand;
                    if r < prob
                        
                        fid_out = fidelity(fid_out,fid);
                        if rem(step,k) == 0
                            delay_temp = delay_temp + T_2;  % check the results.
                        end
                    else
                        times = meet(k,step,max_step);
                        for index = 1:times
                            
                            while(rand > P_B)
                                
                                delay_temp  = delay_temp + T_1;
                                
                            end
                            delay_temp  = delay_temp + T_1;
                        end
                        delay_temp = delay_temp + T_2; % failure and generating auxulary pair
                        break;
                        
                    end
                    
                end
                
                if(step == max_step && r < prob)
                    if(rem(max_step,k)~=0)
                        delay_temp = delay_temp + T_2;
                    end
                    not_succeed = 0;
                    
                end
            end
            
            
        end
        
        delay(k, fid == F) = delay_temp/number_of_experiments
    end
    
end
delay
%%
figure,
plot(1:10, expected_delay,'LineWidth',3)

ax = gca;
ax.FontSize = 13;
ax.FontWeight = 'bold';
grid on;
hold on
%plot(1:10, delay,"--",'LineWidth',3)
%legend({"Numerical: F_{in} - 0.8","Numerical: F_{in} - 0.85","Numerical: F_{in} - 0.9","Numerical: F_{in} - 0.95","Simulation: F_{in} - 0.8","Simulation: F_{in} - 0.85","Simulation: F_{in} - 0.9","Simulation: F_{in} - 0.95"})
legend({"Numerical: F_{in} - 0.8","Numerical: F_{in} - 0.85","Numerical: F_{in} - 0.9","Numerical: F_{in} - 0.95"})

xlabel("The step we check purification result","FontSize",23)
ylabel("Expected value of Delay (s)","FontSize",23)
title("The numerical approach and simulation, when Bell pair generation rate is 0.91","FontSize",23)
xlim([1,10])
%%
%% The  implementation of numerical approach for "delay" maximum k steps using bennett et al. scheme
F = [0.8,0.85,0.90,0.95];


f_0 = 0.90; %initial fidelity
c = physconst('LightSpeed');
max_step = 10;

l= [ 10,30,40,50,100,500] * 1000;

local_gate_delay = [3e-9,50e-9,100e-9,500e-9,1e-6];
% local_gate_delay = 3e-9
expected_delay = zeros(numel(l), numel(local_gate_delay), max_step);

P_B = 0.5;
for distance = l
    
    T_2 = distance/c; %classical communication for checking purification results
    for local_delay = local_gate_delay % for different properties of local gates
        
        t_e = local_delay + 2*distance/c ;  % time for generating one BPR pair.
        
        
        for epoch_length = [1:10]% pick the step which we want to check the
            
            epoch_length
            for purification_step = epoch_length:epoch_length:max_step   %iteration overcheckpoints
                if(purification_step == epoch_length)
                    E_E_temp = ((2*t_e)/P_B^2 + (epoch_length - 1) * t_e/P_B + T_2)/P_thru(f_0, purification_step - epoch_length, purification_step);
                    continue;
                end
                
                E_E_temp = 1/(P_thru(f_0, purification_step - epoch_length, purification_step)) ...
                    * ( epoch_length * t_e/P_B + T_2 + E_E_temp);
                
                
            end
            
            if  purification_step ~= max_step
                
                
                E_E_temp = 1/(P_thru(f_0, purification_step, max_step)) ...
                    * ( (max_step - purification_step)* t_e/P_B + T_2 + E_E_temp);
                
            end
            expected_delay(distance == l, local_delay == local_gate_delay, epoch_length) = E_E_temp;
        end
        
    end
    
    
end
%%

for j = [2:10]
    
    expected_delay(:,:,j) = expected_delay(:,:,j)./expected_delay(:,:,1);
end
%%

%%
figure
hold on
view(3)
ylabel("Distance in Km")
xlabel("Generating bell pair rate based on local gates")
grid on
for i = [2:10]
    surf(local_gate_delay,l/1000,expected_delay(:,:,i))
    colorbar;
    colormap jet
    pause
end

legend({"k=2","k=3","k=4","k=5","k=6","k=7","k=8","k=9","k=10"})
%title("Contour plot for fidelity and the prob. of success");
%%
l = 2
m = 1;
%% numerical approach for "delay" maximum k steps using bennett et al. scheme
% effect of different entanglement genearting rate on waiting time
% T_0 = T_1
F = [0.8,0.85,0.90,0.95];


f_0 = 0.90; %initial fidelity
c = physconst('LightSpeed');
max_step = 10;

l= [10] * 1000;
T_1 = [1*10^-9,1*10^-6,10^-5,30*10^-6,60*10^-6,100*10^-6];
% local_gate_delay = 3e-9
expected_delay = zeros(numel(T_1),max_step);

P_B = 0.5;
for t_1 = T_1
    t_0 = t_1;
    t_2 = l/c; %classical communication for checking purification results
    
    t_e = t_1 ;  % time for generating one BPR pair.
    
    
    for epoch_length = [1:10]% pick the step which we want to check the
        
        epoch_length
        for purification_step = epoch_length:epoch_length:max_step   %iteration overcheckpoints
            if(purification_step == epoch_length)
                E_E_temp = (t_0 + (epoch_length - 1) * t_1 + t_2)/P_thru(f_0, purification_step - epoch_length, purification_step);
                continue;
            end
            
            E_E_temp = 1/(P_thru(f_0, purification_step - epoch_length, purification_step)) ...
                * ( epoch_length * t_1 + t_2 + E_E_temp);
            
            
        end
        
        if  purification_step ~= max_step
            
            
            E_E_temp = 1/(P_thru(f_0, purification_step, max_step)) ...
                *((max_step - purification_step)*t_1 + t_2 + E_E_temp);
            
        end
        E_E_temp
        
        expected_delay(T_1 == t_1, epoch_length) = E_E_temp;
    end
    
end
%%
figure
hold on
for i = 1 : numel(T_1)
    
    plot(1:10,1./(expected_delay(i,:)./expected_delay(i,1)))
    %       plot(1:10,(expected_delay(i,:)))
    pause;
end
grid on

%% numerical approach for "delay" maximum k steps using bennett et al. scheme
% effect of different distance on the waiting time
% T_0 = T_1

f_0 = 0.90; %initial fidelity
c = physconst('LightSpeed');
max_step = 10;

L_0 = 10*10^3;
% L = [10:200].*10^3;
L = L_0
T_1 = [3*10^-9]
% for T_1 = [3*10^-9:(10^-1-3*10^-9)/100:10^-1]
% local_gate_delay = 3e-9
expected_delay = zeros(numel(L),max_step);

for l = L
    p_l = exp(-l/L_0);
    
    t_1 = T_1/p_l;
    t_0 = t_1;
    
    t_2 = l/c; %classical communication for checking purification results
    
    %         t_e = t_1 ;  % time for generating one BPR pair.
    
    
    for epoch_length = [3]% pick the step which we want to check the
        
        epoch_length;
        for purification_step = epoch_length:epoch_length:max_step   %iteration overcheckpoints
            if(purification_step == epoch_length)
                E_E_temp = (t_0 + (epoch_length - 1) * t_1 + t_2)/P_thru(f_0, purification_step - epoch_length, purification_step);
                continue;
            end
            
            E_E_temp = 1/(P_thru(f_0, purification_step - epoch_length, purification_step)) ...
                * ( epoch_length * t_1 + t_2 + E_E_temp);
            
            
        end
        
        if  purification_step ~= max_step
            
            
            E_E_temp = 1/(P_thru(f_0, purification_step, max_step)) ...
                *((max_step - purification_step)*t_1 + t_2 + E_E_temp);
            
        end
        E_E_temp;
        
        expected_delay(L == l, epoch_length) = E_E_temp;
    end
    
    %         expected_delay(L == l,:) = expected_delay(L == l,1)./expected_delay(L == l,:);
    
    
end

% if(expected_delay <=1)
%    T_1
% end
% end

%% animated figure,
f = figure;
hold on
grid on
ylim([0.0,7])
xlabel("Epoch length", "FontSize", 18)
ylabel("The ratio of nonoptimistic expected waiting time to optimistic expected waiting time","FontSize", 14)
pause
for i = 1 : numel(L)
    
    p1 = plot(1:10,expected_delay(i,1)./expected_delay(i,:),"LineWidth",3,"Color",[217,109,76]./255);
    dim = [.2 .5 .3 .3];
    str = 'Distance (km) : ';
    t = annotation('textbox',dim,'String',strcat(str,num2str(L(i)./10^3)),'FitBoxToText','on',"FontSize",14);
    
    
    
    pause(0.05)
    delete(t)
    %     delete(h)
    
end

plot(1:10,expected_delay(i,1)./expected_delay(i,:),"LineWidth",3);
annotation('textbox',dim,'String',strcat(str,num2str(L(i)./10^3)),'FitBoxToText','on',"FontSize",14)
%%
f = figure;
hold on
grid on
ylim([0.0,7])
xlabel("Epoch length", "FontSize", 18)
ylabel("The ratio of optimistic expected waiting time to nonoptimistic expected waiting time","FontSize", 18)

for i = [1,50,90,120,191]
    
    p1 = plot(1:10,expected_delay(i,1)./expected_delay(i,:),"LineWidth",3);
    
    
    
end

legend(legendmaker("Distance (km): ",L([1,50,90,120,191])./1000), "FontSize",15)
%% display the effect of memory decoherence on fidelity (incorrect version)
T_coh = 10^-1; % 100 milliseconds

coefs = exp(-expected_delay([1,50,90,120,191],:)./T_coh);

f_0 = 0.9;
final_fidelity = G(f_0,10);

fidelity_decohered =  final_fidelity.*coefs;
plot(fidelity_decohered',"LineWidth",3)
hold on
grid on
plot([1:10],ones(1,10)*final_fidelity,"--","color","black","LineWidth",1)
text = legendmaker("Distance (km): ",L([1,50,90,120,191])./1000);
text{6} = " Maximum achievable fidelity";
legend(text, "FontSize",15)
xlabel("Epoch length", "FontSize", 18)
ylabel("Fidelity", "FontSize", 18);
%% Relation between L_0 and the T_1 (without memory decoherence)


f_0 = 0.90; %initial fidelity
c = physconst('LightSpeed');
max_step = 10;

L_0 = [10:10:200]*10^3;

L = [10:200].*10^3;

T_1 = [1*10^-9:(10^-1-1*10^-9)/1000:10^-1];
T_1_most = zeros(1,numel(L_0));
% for T_1 = [3*10^-9:(10^-1-3*10^-9)/100:10^-1]
% local_gate_delay = 3e-9

for l0 = L_0
    for t1_index =1:numel( T_1)
        p_l = exp(-l0/l0);
        
        t_1 = T_1(t1_index)/p_l;
        t_0 = t_1;
        
        t_2 = l0/c; %classical communication for checking purification results
        
        %         t_e = t_1 ;  % time for generating one BPR pair.
        
        expected_delay = zeros(1,10);
        
        for epoch_length = [1:10]% pick the step which we want to check the
            
            epoch_length;
            for purification_step = epoch_length:epoch_length:max_step   %iteration overcheckpoints
                if(purification_step == epoch_length)
                    E_E_temp = (t_0 + (epoch_length - 1) * t_1 + t_2)/P_thru(f_0, purification_step - epoch_length, purification_step);
                    continue;
                end
                
                E_E_temp = 1/(P_thru(f_0, purification_step - epoch_length, purification_step)) ...
                    * ( epoch_length * t_1 + t_2 + E_E_temp);
                
                
            end
            
            if  purification_step ~= max_step
                
                
                E_E_temp = 1/(P_thru(f_0, purification_step, max_step)) ...
                    *((max_step - purification_step)*t_1 + t_2 + E_E_temp);
                
            end
            E_E_temp;
            
            expected_delay(epoch_length) = E_E_temp;
        end
        if(expected_delay(1)./expected_delay(2:end) <=1)
            T_1_most(L_0 == l0) = T_1(t1_index-1);
            break;
        end
        
    end
end
%%
figure
plot(L_0./1000,T_1_most,"LineWidth",3)
xlabel("L_0 distance (km)","FontSize",14)
ylabel("Maximum amount of T_1 (s)","FontSize",14)
grid on
xlim([10,200])

%% Effect of distance on the  (including memory decoherence)

f_0 = 0.90; %initial fidelity
c = physconst('LightSpeed');
max_step = 10;
T_coh = [100,10^(-3),100 * 10^(-6),100 * 10^(-9)];

% L_0 = [10:10:200]*10^3;
L_0 = 10*10^3;
L = [10:200].*10^3;

T_1 = [3*10e-9];
output = cell(1,numel(T_coh));

for t_coh = T_coh
    expected_ebits = zeros(numel(L), max_step);
    
    
    for l = 1:numel(L)
        p_l = exp(-L(l)/L_0);
        
        t_1 = T_1/p_l;
        t_0 = t_1;
        
        t_2 = L(l)/c; %classical communication for checking purification results
        
        %         t_e = t_1 ;  % time for generating one BPR pair.
        for epoch_length = [1:10]% pick the step which we want to check the
            
            f_0 = f_0;
            fidelity_new = f_0;
            for purification_step = epoch_length:epoch_length:max_step   %iteration overcheckpoints
                if(purification_step == epoch_length) % Initial step.
                    [prob_of_success, fidelity_new] = P_thru(f_0,fidelity_new,epoch_length,t_coh,t_1,t_2,1);
                    E_E_temp = (t_0 + (epoch_length - 1) * t_1 + t_2)/prob_of_success;
                    continue;
                end
                [prob_of_success, fidelity_new] = P_thru(f_0,fidelity_new,epoch_length,t_coh,t_1,t_2,0);
                
                E_E_temp = 1/prob_of_success * ( epoch_length * t_1 + t_2 + E_E_temp);
                
                
            end
            
            if  purification_step ~= max_step
                
                [prob_of_success, fidelity_new] = P_thru(f_0,fidelity_new,max_step - purification_step,t_coh,t_1,t_2,0);
                E_E_temp = ((max_step - purification_step)*t_1 + t_2 + E_E_temp)/prob_of_success;
                
            end
            E_E_temp;
            
            expected_delay(l ,epoch_length) = E_E_temp;
        end
        
    end
    output{T_coh == t_coh} = expected_delay;
end
%%
% f = figure;
% hold on
% grid on
%
% xlabel("Epoch length", "FontSize", 18)
% ylabel("The ratio of nonoptimistic expected waiting time to optimistic expected waiting time","FontSize", 14)
% xlim([1,10])
% pause
e_d_1 = output{1};
e_d_2 = output{2};
e_d_3 = output{3};
e_d_4 = output{4};
f = figure;
hold on
pause
for i = 1 : numel(L)
    
    
    subplot(2,2,1)
    p1 = plot(1:10,e_d_1(i,1)./e_d_1(i,:),"LineWidth",3,"Color",[217,109,76]./255);
    xlabel("Epoch length", "FontSize", 18)
    ylabel("The ratio of nonoptimistic to optimistic","FontSize", 11)
    title("T_{coh} = 100 seconds", "FontSize", 18)
    ylim([0.0,15])
    grid on
    subplot(2,2,2)
    p2 = plot(1:10,e_d_2(i,1)./e_d_2(i,:),"LineWidth",3,"Color",[217,109,76]./255);
    xlabel("Epoch length", "FontSize", 18)
    ylabel("The ratio of nonoptimistic to optimistic","FontSize", 11)
    ylim([0.0,15])
    title("T_{coh} = 1 miliseconds", "FontSize", 18)
    grid on
    subplot(2,2,3)
    p3 = plot(1:10,e_d_3(i,1)./e_d_3(i,:),"LineWidth",3,"Color",[217,109,76]./255);
    xlabel("Epoch length", "FontSize", 18)
    ylabel("The ratio of nonoptimistic to optimistic","FontSize", 11)
    ylim([0.0,15])
    xlim([1,10])
    title("T_{coh} = 100 microseconds", "FontSize", 18)
    grid on
    subplot(2,2,4)
    p4 = plot(1:10,e_d_4(i,1)./e_d_4(i,:),"LineWidth",3,"Color",[217,109,76]./255);
    xlabel("Epoch length", "FontSize", 18)
    ylabel("The ratio of nonoptimistic to optimistic","FontSize", 11)
    ylim([0.0,15])
    title("T_{coh} = 100 nanoseconds", "FontSize", 18)
    grid on
    
    dim = [.2 .5 .3 .3];
    str = 'Distance (km) : ';
    t = annotation('textbox',dim,'String',strcat(str,num2str(L(i)./10^3)),'FitBoxToText','on',"FontSize",14);
    
    if i == 1
        pause
    end
    
    pause(0.05)
    if i ~= numel(L)
        delete(t)
        delete(p1)
        delete(p2)
        delete(p3)
        delete(p4)
    end
end

% plot(1:10,expected_delay(i,1)./expected_delay(i,:),"LineWidth",3);
% annotation('textbox',dim,'String',strcat(str,num2str(L(i)./10^3)),'FitBoxToText','on',"FontSize",14)
%% Investigating t_coh = 1 miliseconds.

f_0 = 0.90; %initial fidelity
c = physconst('LightSpeed');
max_step = 10;
t_coh = 0.1;

% L_0 = [10:10:200]*10^3;
L_0 = 10*10^3;
L = [10:100].*10^3;
% L = 70.*10^3;
T_1 = [3*10e-9];


final_fidelity = zeros(numel(L), max_step);
expected_ebits = zeros(numel(L), max_step);


for l = 1:numel(L)
    p_l = exp(-L(l)/L_0);
    
    t_1 = T_1/p_l;
    t_0 = t_1;
    
    t_2 = L(l)/c; %classical communication for checking purification results
    
    %         t_e = t_1 ;  % time for generating one BPR pair.
    for epoch_length = [1:10]% pick the step which we want to check the
        
        f_0 = f_0;
        fidelity_new = f_0;
        for purification_step = epoch_length:epoch_length:max_step   %iteration overcheckpoints
            if(purification_step == epoch_length) % Initial step.
                [prob_of_success, fidelity_new] = P_thru(f_0,fidelity_new,epoch_length,t_coh,t_1,t_2,1);
                E_E_temp = (t_0 + (epoch_length - 1) * t_1 + t_2)/prob_of_success;
                continue;
            end
            [prob_of_success, fidelity_new] = P_thru(f_0,fidelity_new,epoch_length,t_coh,t_1,t_2,0);
            
            E_E_temp = 1/prob_of_success * ( epoch_length * t_1 + t_2 + E_E_temp);
            
            
        end
        
        if  purification_step ~= max_step
            
            [prob_of_success, fidelity_new] = P_thru(f_0,fidelity_new,max_step - purification_step,t_coh,t_1,t_2,0);
            E_E_temp = ((max_step - purification_step)*t_1 + t_2 + E_E_temp)/prob_of_success;
            
        end
        E_E_temp;
        final_fidelity(l, epoch_length) = fidelity_new;
        expected_delay(l ,epoch_length) = E_E_temp;
    end
    
end
%%
f = figure;
hold on
for i = 1:1:numel(L)
    if  final_fidelity(i,:) <= f_0
        break
    end
    subplot(2,1,1)
    p1 = plot(1:10,expected_delay(i,1)./expected_delay(i,:),"LineWidth",3,"Color",[217,109,76]./255);
    %     p1 = plot(1:10,expected_delay(i,1)./expected_delay(i,:),"LineWidth",3);
    xlabel("Epoch length", "FontSize", 18)
    ylabel("The ratio of nonoptimistic to optimistic","FontSize", 11)
    title("T_{coh} = 5 miliseconds", "FontSize", 18)
    ylim([0.0,10])
    grid on
    subplot(2,1,2)
    hold on
    p2 = plot(1:10,final_fidelity(i,:),"LineWidth",3,"Color",[100,100,255]./255);
    xlabel("Epoch length", "FontSize", 18)
    ylabel("Final fidelity","FontSize", 11)
    ylim([0.7,1])
    title("T_{coh} = 5 miliseconds", "FontSize", 18)
    grid on
    dim = [.2 .5 .3 .3];
    str = 'Distance (km) : ';
    t = annotation('textbox',dim,'String',strcat(str,num2str(L(i)./10^3)),'FitBoxToText','on',"FontSize",14);
    
    if i == 1
        pause;
    end
    if i ~= numel(L)
        pause(0.05)
        
        delete (t)
        delete (p1)
        delete (p2)
    end
    
end
subplot(2,1,1)
p1 = plot(1:10,expected_delay(i,1)./expected_delay(i,:),"LineWidth",3,"Color",[217,109,76]./255);
%     p1 = plot(1:10,expected_delay(i,1)./expected_delay(i,:),"LineWidth",3);
xlabel("Epoch length", "FontSize", 18)
ylabel("The ratio of nonoptimistic to optimistic","FontSize", 11)
title("T_{coh} = 5 miliseconds", "FontSize", 18)
ylim([0.0,10])
grid on
subplot(2,1,2)
hold on
p2 = plot(1:10,final_fidelity(i,:),"LineWidth",3,"Color",[100,100,255]./255);
xlabel("Epoch length", "FontSize", 18)
ylabel("Final fidelity","FontSize", 11)
ylim([0.7,1])
title("T_{coh} = 5 miliseconds", "FontSize", 18)
grid on
dim = [.2 .5 .3 .3];
str = 'Distance (km) : ';
t = annotation('textbox',dim,'String',strcat(str,num2str(L(i)./10^3)),'FitBoxToText','on',"FontSize",14);
%% Multivariables considering F_0 T_coh L_0

F_0 = [0.6:0.1:0.9];
% F_0 = 0.9
% T_coh = [0.005,0.010,0.050,0.1];
T_coh = [0.0001,0.1]
% T_coh = 0.1;
L_0 = 10*10^3;
L = [10:100]*10^3;
c = physconst('LightSpeed');
max_step = 10;

L = [10:100].*10^3;
T_1 = [3*10e-9];


final_fidelity = zeros(numel(L), max_step, numel(F_0), numel(T_coh));
expected_ebits = zeros( numel(L), max_step, numel(F_0), numel(T_coh));
for f_0 = F_0
    for t_coh = T_coh
        for l = 1:numel(L)
            p_l = exp(-L(l)/L_0);
            
            t_1 = T_1/p_l;
            t_0 = t_1;
            
            t_2 = L(l)/c; %classical communication for checking purification results
            
            %         t_e = t_1 ;  % time for generating one BPR pair.
            for epoch_length = [1:10]% pick the step which we want to check the
                
                f_0 = f_0;
                fidelity_new = f_0;
                for purification_step = epoch_length:epoch_length:max_step   %iteration overcheckpoints
                    if(purification_step == epoch_length) % Initial step.
                        [prob_of_success, fidelity_new] = P_thru(f_0,fidelity_new,epoch_length,t_coh,t_1,t_2,1);
                        E_E_temp = (t_0 + (epoch_length - 1) * t_1 + t_2)/prob_of_success;
                        continue;
                    end
                    [prob_of_success, fidelity_new] = P_thru(f_0,fidelity_new,epoch_length,t_coh,t_1,t_2,0);
                    
                    E_E_temp = 1/prob_of_success * ( epoch_length * t_1 + t_2 + E_E_temp);
                    
                    
                end
                
                if  purification_step ~= max_step
                    
                    [prob_of_success, fidelity_new] = P_thru(f_0,fidelity_new,max_step - purification_step,t_coh,t_1,t_2,0);
                    E_E_temp = ((max_step - purification_step)*t_1 + t_2 + E_E_temp)/prob_of_success;
                    
                end
                E_E_temp;
                final_fidelity(l, epoch_length, F_0 == f_0, T_coh == t_coh) = fidelity_new;
                expected_delay(l , epoch_length, F_0 == f_0, T_coh == t_coh) = E_E_temp;
            end
            
        end
    end
end
%%
figure,
view(3)
for T_coh_index = 1: numel(T_coh)
   subplot(1, 2, T_coh_index)
   hold on
   grid on
      view(3)

   for fidelity_index = 1: numel(F_0)
       surf(1:max_step, L/1000, 1./(expected_delay(:,:,fidelity_index, T_coh_index)./expected_delay(:,1,fidelity_index, T_coh_index)))  
       pause
   end
   xlabel("Epoch length", "FontSize", 14)
   zlabel("The ratio of nonoptimistic to optimistic","FontSize", 11)
   ylabel("Distance (km)")
   title("T_{coh} = " + T_coh(T_coh_index) + "second", "FontSize", 13)
%    legend(legendmaker("F_0 = ",F_0));
   colorbar
end
%% figure for the fidelities
figure,

view(3)
for T_coh_index = 1: numel(T_coh)
   subplot(1, 2, T_coh_index)
   hold on
   grid on
      view(3)

   for fidelity_index = 1: numel(F_0)
       surf(1:max_step, L/1000, final_fidelity(:,:,fidelity_index, T_coh_index)-F_0(fidelity_index))  
%        pause
   end
   xlabel("Epoch length", "FontSize", 14)
   zlabel("The difference of final fidelity and F_0","FontSize", 11)
   ylabel("Distance (km)")
   title("T_{coh} = " + T_coh(T_coh_index) + "second", "FontSize", 13)
%     legend(legendmaker("F_0 = ",F_0));
   colorbar
end
%% Multivariable for number of ebits.

F_0 = [0.6:0.1:0.9];
% F_0 = [0.8,0.9];
% T_coh = [0.005,0.010,0.050,0.1];
T_coh = [0.0001,0.1]

% T_coh = 0.1;
L_0 = 10*10^3;
L = [10:100]*10^3;
c = physconst('LightSpeed');
max_step = 10;

L = [10:100].*10^3;
T_1 = [3*10e-9];


expected_ebits = zeros( numel(L), max_step, numel(F_0), numel(T_coh));
for f_0 = F_0
    for t_coh = T_coh
        for l = 1:numel(L)
            p_l = exp(-L(l)/L_0);
            
            t_1 = T_1/p_l;
            t_0 = t_1;
            
            t_2 = L(l)/c; %classical communication for checking purification results
            
            %         t_e = t_1 ;  % time for generating one BPR pair.
            for epoch_length = [1:10]% pick the step which we want to check the
                
                f_0 = f_0;
                fidelity_new = f_0;
                for purification_step = epoch_length:epoch_length:max_step   %iteration overcheckpoints
                    if(purification_step == epoch_length) % Initial step.
                        [prob_of_success, fidelity_new] = P_thru(f_0,fidelity_new,epoch_length,t_coh,t_1,t_2,1);
                        E_E_temp = (epoch_length + 1)/prob_of_success;
                        continue;
                    end
                    [prob_of_success, fidelity_new] = P_thru(f_0,fidelity_new,epoch_length,t_coh,t_1,t_2,0);
                    
                    E_E_temp = 1/prob_of_success * ( epoch_length + E_E_temp);
                    
                    
                end
                
                if  purification_step ~= max_step
                    
                    [prob_of_success, fidelity_new] = P_thru(f_0,fidelity_new,max_step - purification_step,t_coh,t_1,t_2,0);
                    E_E_temp = ((max_step - purification_step) + E_E_temp)/prob_of_success;
                    
                end
                E_E_temp;
                expected_ebits(l , epoch_length, F_0 == f_0, T_coh == t_coh) = E_E_temp;
            end
            
        end
    end
end
%%
figure,
view(3)
for T_coh_index = 1: numel(T_coh)
   subplot(1, 2, T_coh_index)
   hold on
   grid on
      view(3)

   for fidelity_index = 1: numel(F_0)
       surf(1:max_step, L/1000, 1./(expected_ebits(:,:,fidelity_index, T_coh_index)./expected_ebits(:,1,fidelity_index, T_coh_index)))  
%         surf(1:max_step, L/1000, expected_ebits(:,:,fidelity_index, T_coh_index))
       pause
   end
   xlabel("Epoch length", "FontSize", 14)
   zlabel("The ratio of ebits","FontSize", 11)
   ylabel("Distance (km)")
   title("T_{coh} = " + T_coh(T_coh_index) + "second", "FontSize", 13)
%    legend(legendmaker("F_0 = ",F_0));
   colorbar
end

