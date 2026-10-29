%% heterogenous_CPMMT_graph: Generate plots of absolute position, speed, and acceleration
% Read corresponding data from vehicle_trajectory
% Get row and column vectors of the cell array
[r_graph, c_graph] = size(vehicle_trajectory);

% Create zero matrices to store absolute position, speed, and acceleration data
a_zeros = zeros(size(vehicle_trajectory)); % absolute position
b_zeros = zeros(size(vehicle_trajectory)); % speed
c_zeros = zeros(size(vehicle_trajectory)); % acceleration

for i = 1:c_graph % Outer loop over columns
    for j = 1:r_graph % Inner loop over rows
        AP_read = vehicle_trajectory{j,i}; % Read each matrix from the cell array
        a_zeros(j,i) = AP_read(1,3); % Extract absolute position
        b_zeros(j,i) = AP_read(1,4); % Extract speed
        c_zeros(j,i) = AP_read(1,5); % Extract acceleration
    end
end

% %% Position-Time Line Plot
% x = 1:c_graph; % X-axis for line plot
% 
% % Legend flags
% plt_aggressive = 0;
% plt_mild = 0;
% plt_normal = 0;

% % Speed-Time Line Plot (same logic as above)

% % Acceleration-Time Line Plot (same logic as above)

% %% Speed-Position-Time Plot
% figure;
% hold on;
% 
% % Use a colormap where blue represents low speed and red represents high speed
% colormap(jet);
% c = linspace(min(b_zeros(:)), max(b_zeros(:)), 256); % Linear color scale
% 
% for i = 1:r_graph
%     for j = 1:c_graph-1
%         % Draw line segments for each time interval
%         % Determine color based on speed
%         speedIndex = find(min(abs(c - b_zeros(i,j))) == abs(c - b_zeros(i,j)), 1);
%         lineColor = jet(256);
%         lineColor = lineColor(speedIndex, :);
%         
%         % Plot segment
%         line([x(j) x(j+1)], [a_zeros(i,j) a_zeros(i,j+1)], 'Color', lineColor, 'LineWidth', 1);
%     end
% end
% 
% % Add colorbar for speed reference
% colorbar;
% caxis([min(b_zeros(:)) max(b_zeros(:))]);

% %% Speed-Vehicle Index Heatmap
% carNumbers = 1:MP; % Vehicle index
% timePoints = 1:3000; % Time steps
% b_zeros1 = b_zeros';
% 
% figure;
% heatmap(b_zeros1);
% colormap jet;
% colorbar;
% xlabel('Vehicle index');
% ylabel('Time');

% %% Speed Standard Deviation per Vehicle
% stdSpeeds = std(b_zeros, 0, 2); % Standard deviation for each vehicle
% carNumbers = 1:MP;

% figure;
% scatter(carNumbers, stdSpeeds, 'filled');
% xlabel('Vehicle index');
% ylabel('Speed standard deviation (m/s)');
% grid on;

% % Fit an exponential decay model
% model = @(a, b, c, x) a * exp(-b * x) + c;
% fittedmodel = fit(carNumbers(:), stdSpeeds(:), model, 'StartPoint', [1, 0.1, 0]);
% fitValues = feval(fittedmodel, carNumbers);
% 
% hold on;
% plot(carNumbers, fitValues, 'r-', 'LineWidth', 2);
% legend('Data point', 'Fitting curve', 'Location', 'northwest');
