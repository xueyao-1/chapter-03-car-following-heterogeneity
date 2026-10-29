clc;clear
close all;

%% 100agg
% Speed
% Load figure data
fig_handle = openfig('100agg_V.fig');

% Find all curve lines in the figure
all_curve_handles = findobj(fig_handle,'Type','line');

% Loop through each curve and extract data
all_curve_data = cell(length(all_curve_handles),2);

for i =1:length(all_curve_handles)
    x_data = get(all_curve_handles(i),'XData');
    y_data = get(all_curve_handles(i),'YData');
    all_curve_data{i,1} = x_data;
    all_curve_data{i,2} = y_data;
end
value = [];

for i = 1:30
    value = [value;all_curve_data{i,2}(:)'];
end

minValues = min(value,[],1);
maxValues = max(value,[],1);

smoothdatamin = movmean(minValues,10);
smoothdatamax = movmean(maxValues,10);

% Create a new figure window
figure;

% Use fill function to show range between min and max
fill([all_curve_data{1,1} fliplr(all_curve_data{1,1})], [smoothdatamax fliplr(smoothdatamin)], 'b', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
hold on;

legend('Aggressive','Location','southeast');
xlabel('The number of the time step/0.1s');
ylabel('Speed (m/s)');
xlim([0,3000]);

% acceleration
% Load figure data
fig_handle = openfig('100agg_A.fig');

all_curve_handles = findobj(fig_handle,'Type','line');

%  Loop through each curve and extract data
all_curve_data = cell(length(all_curve_handles),2);

for i =1:length(all_curve_handles)
    x_data = get(all_curve_handles(i),'XData');
    y_data = get(all_curve_handles(i),'YData');
    all_curve_data{i,1} = x_data;
    all_curve_data{i,2} = y_data;
end
value = [];

for i = 1:30
    value = [value;all_curve_data{i,2}(:)'];
end

minValues = min(value,[],1);
maxValues = max(value,[],1);

smoothdatamin = movmean(minValues,10);
smoothdatamax = movmean(maxValues,10);

figure;

fill([all_curve_data{1,1} fliplr(all_curve_data{1,1})], [smoothdatamax fliplr(smoothdatamin)], 'b', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
hold on;

legend('Acceleration range of all aggressive vehicles','Location','southeast');
xlabel('The number of the time step/0.1s');
ylabel('Acceleration (m/s2)');
xlim([0,3000]);


% Create a new figure window
figure;

...

%% 60% Aggressive, 40% Normal
...

%% 40% Aggressive, 60% Normal
...

%% 20% Aggressive, 80% Normal
...

%% 100% Normal Vehicles
% Speed
% Load figure data
...

% Create a new figure window
...

% Acceleration
% Load figure data
...

% Create a new figure window
...

%% 80% Mild, 20% Normal
...

%% 60% Mild, 40% Normal
...

%% 40% Mild, 60% Normal
...

%% 20% Mild, 80% Normal
...

%% 100% Mild Vehicles
...


%% 30agg30mil40nor
%speed
fig_handle = openfig('30agg_30mil_40nor_V.fig');
all_curve_handles = findobj(fig_handle,'Type','line');
all_curve_data = cell(length(all_curve_handles),2);

for i =1:length(all_curve_handles)
    x_data = get(all_curve_handles(i),'XData');
    y_data = get(all_curve_handles(i),'YData');
    all_curve_data{i,1} = x_data;
    all_curve_data{i,2} = y_data;
end


% Blocked_Aggressive
value = [];

for i = [3,6,15,16,19,20,23,24,27,28,30] 
    value = [value;all_curve_data{i,2}(:)'];
end

minValues = min(value,[],1);
maxValues = max(value,[],1);

smoothdatamin = movmean(minValues,10);
smoothdatamax = movmean(maxValues,10);


% Normal
value_normal = [];
for i = [1,2,7,8,10,11,13,17,18,25,26,29]
    value_normal = [value_normal;all_curve_data{i,2}(:)'];
end

minValues_normal = min(value_normal,[],1);
maxValues_normal = max(value_normal,[],1);

smoothdatamin_normal = movmean(minValues_normal,10);
smoothdatamax_normal = movmean(maxValues_normal,10);


% Mild
value_mild = [];
for i = [4,5,9,12,14,21,22]
    value_mild = [value_mild;all_curve_data{i,2}(:)'];
end

minValues_mild = min(value_mild,[],1);
maxValues_mild = max(value_mild,[],1);

smoothdatamin_mild = movmean(minValues_mild,10);
smoothdatamax_mild = movmean(maxValues_mild,10);

figure;

fill([all_curve_data{1,1} fliplr(all_curve_data{1,1})], [smoothdatamax fliplr(smoothdatamin)], 'b', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
hold on;

fill([all_curve_data{1,1} fliplr(all_curve_data{1,1})], [smoothdatamax_normal fliplr(smoothdatamin_normal)], 'r', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
hold on;

fill([all_curve_data{1,1} fliplr(all_curve_data{1,1})], [smoothdatamax_mild fliplr(smoothdatamin_mild)], 'g', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
hold on;

plot(all_curve_data{1,1}, all_curve_data{30,2}, 'b', 'LineWidth', 1); % 
plot(all_curve_data{1,1}, all_curve_data{29,2}, 'r', 'LineWidth', 1); % 
plot(all_curve_data{1,1}, all_curve_data{22,2}, 'g', 'LineWidth', 1); % 

xlim([0,3000]);
legend('Speed range of selected aggressive vehicle','Speed range of selected normal vehicle','Speed range of all mild vehicle','Sample of aggressive vehicle','Sample of normal vehicle','Sample of mild vehicle','location','southeast');
xlabel('The number of the time step/0.1s');
ylabel('Speed (m/s)');


% acceleration
fig_handle = openfig('30agg_30mil_40nor_A.fig');
all_curve_handles = findobj(fig_handle,'Type','line');
all_curve_data = cell(length(all_curve_handles),2);

for i =1:length(all_curve_handles)
    x_data = get(all_curve_handles(i),'XData');
    y_data = get(all_curve_handles(i),'YData');
    all_curve_data{i,1} = x_data;
    all_curve_data{i,2} = y_data;
end

% Blocked_Aggressive
value = [];

for i = [3,6,15,16,19,20,23,24,27,28,30] 
    value = [value;all_curve_data{i,2}(:)'];
end

minValues = min(value,[],1);
maxValues = max(value,[],1);

smoothdatamin = movmean(minValues,10);
smoothdatamax = movmean(maxValues,10);


% Normal
value_normal = [];
for i = [1,2,7,8,10,11,13,17,18,25,26,29]
    value_normal = [value_normal;all_curve_data{i,2}(:)'];
end

minValues_normal = min(value_normal,[],1);
maxValues_normal = max(value_normal,[],1);

smoothdatamin_normal = movmean(minValues_normal,10);
smoothdatamax_normal = movmean(maxValues_normal,10);


% Mild
value_mild = [];
for i = [4,5,9,12,14,21,22]
    value_mild = [value_mild;all_curve_data{i,2}(:)'];
end

minValues_mild = min(value_mild,[],1);
maxValues_mild = max(value_mild,[],1);

smoothdatamin_mild = movmean(minValues_mild,10);
smoothdatamax_mild = movmean(maxValues_mild,10);


smoothdataagg = movmean(all_curve_data{30,2},10);
smoothdatanor = movmean(all_curve_data{29,2},10);
smoothdatamil = movmean(all_curve_data{22,2},10);

figure;
fill([all_curve_data{1,1} fliplr(all_curve_data{1,1})], [smoothdatamax fliplr(smoothdatamin)], 'b', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
hold on;
fill([all_curve_data{1,1} fliplr(all_curve_data{1,1})], [smoothdatamax_normal fliplr(smoothdatamin_normal)], 'r', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
hold on;
fill([all_curve_data{1,1} fliplr(all_curve_data{1,1})], [smoothdatamax_mild fliplr(smoothdatamin_mild)], 'g', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
hold on;
plot(all_curve_data{1,1}, smoothdataagg, 'b', 'LineWidth', 1.5); % 
plot(all_curve_data{1,1}, smoothdatanor, 'r', 'LineWidth', 1.5); % 
plot(all_curve_data{1,1}, smoothdatamil, 'g', 'LineWidth', 1.5); %

xlim([0,3000]);
legend('Acceleration range of all aggressive vehicles','Acceleration range of all normal vehicles','Acceleration range of all mild vehicles','Sample of aggressive vehicle','Sample of normal vehicle','Sample of mild vehicle','location','southeast');
xlabel('The number of the time step/0.1s');
ylabel('Acceleration (m/s2)');





