%% simulation_CPMMT parameter setup
T_simulation = 0; % Initialize simulation time
V_mean = 15; % Set average speed to 15 m/s
% T is estimated based on the farthest initial location of the fleet divided by average speed + 20s buffer
% T = ceil(AP(end,3)/V_mean) + 100; % ceil is a round-up function, T is the total simulation time
T = 300;
j_simulation = 1; % Step counter for storing values in later simulation

%% Simulation loop
while T_simulation < T  % First-level loop: ensures the simulation runs until target time is reached
    T_simulation = T_simulation + t; % Increase simulation time by timestep t
    j_simulation = j_simulation + 1;

    %% Check each vehicle's type
    for i_simulation = 1:size(AP,1) % Loop through every vehicle in the traffic stream
        % Update each vehicle in order based on position at previous time step
        target_veh = AP(i_simulation,1); % Select the target vehicle
        ID = AP(target_veh,1); % Get the ID of the vehicle
        HV_Heterogenous = AP(target_veh,2); % Get heterogeneity type

        if ID == 1 % Leading vehicle uses free-flow IDM strategy
            FL = AP(target_veh,3); % Current location
            FV = AP(target_veh,4); % Current speed
            sigma = 4; % Acceleration exponent
            LL = NaN; % No leader ahead
            LV = NaN; % No leader speed

            % Aggressive vehicle parameters
            if HV_Heterogenous == 1
                tau = T_a;
                Le = Le_a;
                DS = DS_a;
                a = a_a;
                b = b_a;
                Q = Q_a;

            % Mild vehicle parameters
            elseif HV_Heterogenous == 2
                tau = T_m;
                Le = Le_m;
                DS = DS_m;
                a = a_m;
                b = b_m;
                Q = Q_m;

            % Normal vehicle parameters
            elseif HV_Heterogenous == 3
                tau = T_n;
                Le = Le_n;
                DS = DS_n;
                a = a_n;
                b = b_n;
                Q = Q_n;
            end

            % Update state using IDM
            state_new_IDM = HV_CF_IDM(ID, LL, FL, Le, tau, DS, LV, FV, LA, a, b, t, sigma, Q);
            LL = AP(target_veh,3); % Update LL for next vehicle
            LV = AP(target_veh,4); % Update LV for next vehicle
            AP(target_veh,3:5) = state_new_IDM; % Update AP matrix

        else % Follower vehicle uses car-following IDM strategy
            FL = AP(target_veh,3); % Current location
            FV = AP(target_veh,4); % Current speed
            sigma = 4;

            if HV_Heterogenous == 1
                tau = T_a;
                Le = Le_a;
                DS = DS_a;
                a = a_a;
                b = b_a;
                Q = Q_a;

            elseif HV_Heterogenous == 2
                tau = T_m;
                Le = Le_m;
                DS = DS_m;
                a = a_m;
                b = b_m;
                Q = Q_m;

            elseif HV_Heterogenous == 3
                tau = T_n;
                Le = Le_n;
                DS = DS_n;
                a = a_n;
                b = b_n;
                Q = Q_n;
            end

            % Update state using IDM
            state_new_IDM = HV_CF_IDM(ID, LL, FL, Le, tau, DS, LV, FV, LA, a, b, t, sigma, Q);
            LL = AP(target_veh,3); % Update LL for next vehicle
            LV = AP(target_veh,4); % Update LV for next vehicle
            AP(target_veh,3:5) = state_new_IDM; % Update AP matrix
        end

        vehicle_trajectory{i_simulation,j_simulation} = AP(i_simulation,:); % Store current vehicle state into cell array
    end
end
