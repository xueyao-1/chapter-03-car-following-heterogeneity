%% Generate the probabilities from a negative exponential distribution
problist = zeros(201,1); % 201 should match the number of time intervals
problist_1 = 0; % Counter for indexing problist during loop
for time_a = 0:0.1:20 % 20 seconds with 0.1s interval
    problist_1 = problist_1 + 1;
    problist(problist_1,1) = 1 - exp(-lambda1 * time_a); % Probability that a vehicle arrives within time_a
end
% Ensure a vehicle definitely arrives within 20s
problist(end) = 1;
% Set arrival probability to 1 if it's greater than 0.99
for prob_all = 1:size(problist,1)
    if problist(prob_all,1) >= 0.99
        problist(prob_all,1) = 1;
    end
end

%% Store vehicle information matrix
% Column 1: Vehicle ID
% Column 2: HV Heterogeneity (1 = aggressive, 2 = mild, 3 = normal)
% Column 3: Initial Location
% Column 4: Initial Speed
% Column 5: Initial Acceleration

AP = []; 
time = 0; % Total modeling time
Initial_loc = 0; % Initial vehicle position
ID = 0; % Vehicle counter

while ID < MP
    ID = ID + 1; % Increment vehicle ID
    
    %% Determine vehicle arrival time
    prob1 = rand; % Random number [0,1] to determine arrival time
    for s = 1:size(problist,1) - 1
        if prob1 > problist(s,1) && prob1 <= problist(s+1,1)
            interval1 = s / 10; % Arrival happens within s/10 seconds
            break
        end
    end

    % Adjust vehicle generation interval (commented out logic skipped)
    interval_1 = interval1;

    %% Assign vehicle type
    prob2 = rand; % Random number for assigning vehicle type
    order = cumsum([PHa, PHm, PHn]); % Cumulative probability of types
    Initial_Acceleration = 0; % Set initial acceleration to zero
    
    if prob2 <= order(1)
        HV_Heterogenous = 1; % Aggressive
        DS = DS_a; % Desired speed
    elseif prob2 <= order(2)
        HV_Heterogenous = 2; % Mild
        DS = DS_m;
    else
        HV_Heterogenous = 3; % Normal
        DS = DS_n;
    end

    % Compute vehicle's initial location
    Initial_loc = Initial_loc + DS * interval_1;

    % Add vehicle data: ID, type, location, normally-distributed speed, acceleration
    AP = [AP; ID HV_Heterogenous Initial_loc normrnd(mu, sigma) Initial_Acceleration];

    % Update total time
    time = time + interval_1;
end
