%% Initialize vehicle trajectories (use AP matrix as cell array to reduce computational cost)
vehicle_trajectory = {}; 
for i = 1:size(AP,1)
    veh_no = AP(i,1); % Create cell array in the same order as vehicle ID
    vehicle_trajectory{veh_no,1} = AP(i,:); % Store vehicle data in cell array
end
