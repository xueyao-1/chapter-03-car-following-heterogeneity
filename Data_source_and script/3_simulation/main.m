%% IDM Simulation Parameters
clear; clc;
close all;

% Simulation runs approximately 200s
% Simulation 2 runs approximately 300s

%% Related Parameters
% CF model
t = 0.1; % Time step
LA = 5; % Vehicle length
Le = 2; % Safe gap distance at a standstill, in meters
a_max = 3; % Maximum acceleration assumed

% Seedengine parameter setup
% Traffic flow
q = 1600; % Traffic flow in veh/hour
% Arrival rate
lambda1 = q / 3600; % Vehicle arrival rate per second
% Modeling period, in seconds
MP = 30;

% Load car-following parameters (random values)
% run generate_para_IDM

% Load car-following parameters (mu values obtained from lognormal fitting)
run generate_para_IDM_fixed

%% Plot trajectories, velocities, and accelerations for different ratios
% PHa = 0; % Penetration rate of aggressive drivers
% PHm = 0.2; % Penetration rate of mild drivers
% PHn = 1 - PHa - PHm; % Penetration rate of normal drivers

% Generate initial vehicle speed, position, and corresponding features
% 1 veh_ID;
% 2 HV_Heterogenous (aggressive = 1, mild = 2, normal = 3);
% 3 Initial Location; 4 Initial Speed; 5 Initial Acceleration;

% mu = 8; % m/s standard mean value
% sigma = 1; % m/s standard deviation
% run Seedengine_PI

% Generate initial vehicle trajectory cell array to store trajectory at every 0.1s
% run traj_trajectory

% Simulate trajectory over time steps without optimization for each vehicle (fixed sigma = 4)
% run simulation_sigma_4

% Plot trajectories and accelerations (optional, may be slow)
% run heterogeneous_graph

% run Assessment_IDM

% Safety metrics
IDM_ttc = zeros(11,11);
IDM_MTTC = zeros(11,11);
IDM_DRAC = zeros(11,11);

% Emission metrics
IDM_VSP = zeros(11,11);
IDM_CO2 = zeros(11,11);
IDM_NOX = zeros(11,11);
IDM_VTCPFM = zeros(11,11);

%% Generate heatmaps
for item = 1:100
    for i_1 = 0:0.1:1
        for j_1 = 0:0.1:1
            if i_1 + j_1 <= 1
                PHa = j_1; % Penetration rate of aggressive drivers
                PHm = i_1; % Penetration rate of mild drivers
                PHn = 1 - PHa - PHm; % Penetration rate of normal drivers

                % Generate initial vehicle speed, position, and features
                mu = 8; % m/s
                sigma = 1; % m/s
                run Seedengine_PI

                % Generate initial vehicle trajectory cell array
                run traj_trajectory

                % Simulate vehicle trajectories over time
                run simulation_sigma_4

                % Plot (optional, may be slow)
                run heterogeneous_graph

                % Run assessment module
                run Assessment_IDM

                m = fix(i_1 * 10 + 1);
                n = fix(j_1 * 10 + 1);

                % Record assessment values
                IDM_ttc(m,n) = IDM_ttc(m,n) + IDM_assess(1,1);
                IDM_MTTC(m,n) = IDM_MTTC(m,n) + IDM_assess(1,2);
                IDM_DRAC(m,n) = IDM_DRAC(m,n) + IDM_assess(1,3);

                IDM_VSP(m,n) = IDM_VSP(m,n) + IDM_assess(1,4);
                IDM_CO2(m,n) = IDM_CO2(m,n) + IDM_assess(1,5);
                IDM_NOX(m,n) = IDM_NOX(m,n) + IDM_assess(1,6);
                IDM_VTCPFM(m,n) = IDM_VTCPFM(m,n) + IDM_assess(1,7);
            else
                break;
            end
        end
    end
    disp(item)
end

% Compute mean values over 100 iterations
for i_1 = 0:0.1:1
    for j_1 = 0:0.1:1
        if i_1 + j_1 <= 1
            m = fix(i_1 * 10 + 1);
            n = fix(j_1 * 10 + 1);

            IDM_ttc(m,n) = IDM_ttc(m,n) / 100;
            IDM_MTTC(m,n) = IDM_MTTC(m,n) / 100;
            IDM_DRAC(m,n) = IDM_DRAC(m,n) / 100;

            IDM_VSP(m,n) = IDM_VSP(m,n) / 100;
            IDM_CO2(m,n) = IDM_CO2(m,n) / 100;
            IDM_NOX(m,n) = IDM_NOX(m,n) / 100;
            IDM_VTCPFM(m,n) = IDM_VTCPFM(m,n) / 100;
        else
            break;
        end
    end
end

% Generate heatmap figures
run IDM_figure_heatmap

% Save result files (already saved in Excel)
% save('IDM_ttc.mat')
% save('IDM_MTTC.mat')
% save('IDM_DRAC.mat')
% save('IDM_VSP.mat')
% save('IDM_CO2.mat')
% save('IDM_NOX.mat')
% save('IDM_VTCPFM.mat')
