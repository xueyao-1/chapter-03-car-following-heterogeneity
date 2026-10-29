%% Evaluate traffic performance metrics including safety, emissions, and fuel consumption based on vehicle trajectory data

indi = zeros(r_graph,7); % [ttc, MTTC, DRAC, VSP, CO2, NOX, VTCPFM]

for i = 1:r_graph
    % Get all trajectory data for a single vehicle

    % Traffic safety
    ttc_num = 0;
    MTTC_num = 0;
    DRAC_num = 0;

    % Traffic energy/emissions
    VSP = 0;
    E_CO2 = 0;
    E_NOX = 0;
    VTCPFM = 0;

    for j = 1:c_graph - 1
        % Average TTC (Time to Collision)
        if vehicle_trajectory{i,j}(4) >= vehicle_trajectory{i,j+1}(4)
            ttc = 3;
        else
            ttc = (abs(vehicle_trajectory{i,j}(3) - vehicle_trajectory{i,j+1}(3)) - LA) / abs(vehicle_trajectory{i,j}(4) - vehicle_trajectory{i,j+1}(4));
        end

        if ttc < 2
            ttc_num = ttc_num + 1;
        end

        % Average MTTC (Modified Time to Collision)
        MTTC_deltav = vehicle_trajectory{i,j}(4) - vehicle_trajectory{i,j+1}(4);
        MTTC_deltaa = vehicle_trajectory{i,j}(5) - vehicle_trajectory{i,j+1}(5);
        MTTC_S = abs(vehicle_trajectory{i,j}(3) - vehicle_trajectory{i,j+1}(3)) - LA;
        MTTC_1 = (MTTC_deltav + sqrt(MTTC_deltav^2 + 2 * MTTC_deltaa * MTTC_S)) / MTTC_deltaa;
        MTTC_2 = (MTTC_deltav - sqrt(MTTC_deltav^2 + 2 * MTTC_deltaa * MTTC_S)) / MTTC_deltaa;

        if MTTC_1 >= 0 && MTTC_2 >= 0
            MTTC = min(MTTC_1, MTTC_2);
        elseif MTTC_1 >= 0 && MTTC_2 < 0
            MTTC = MTTC_1;
        elseif MTTC_1 < 0 && MTTC_2 >= 0
            MTTC = MTTC_2;
        end

        if MTTC < 1.5
            MTTC_num = MTTC_num + 1;
        end

        % Average DRAC (Deceleration Rate to Avoid Collision)
        DRAC = ((vehicle_trajectory{i,j}(4) - vehicle_trajectory{i,j+1}(4))^2) / (abs(vehicle_trajectory{i,j}(3) - vehicle_trajectory{i,j+1}(3)) - LA);

        if DRAC > 3.4
            DRAC_num = DRAC_num + 1;
        end

        % VSP (Vehicle Specific Power) accumulation
        VSP = VSP + 0.132 * vehicle_trajectory{i,j}(4) + 1.1 * vehicle_trajectory{i,j}(4) * abs(vehicle_trajectory{i,j}(5)) + 0.0003202 * vehicle_trajectory{i,j}(4)^3;

        % CO2 emission estimation
        f1_CO2 = 5.53e-01;
        f2_CO2 = 1.61e-01;
        f3_CO2 = -2.89e-03;
        f4_CO2 = 2.66e-01;
        f5_CO2 = 5.11e-01;
        f6_CO2 = 1.83e-01;
        CO2_V = vehicle_trajectory{i,j}(4);
        CO2_A = vehicle_trajectory{i,j}(5);

        E_CO2 = E_CO2 + max(0, f1_CO2 + f2_CO2 * CO2_V * t + f3_CO2 * (CO2_V^2) * t^2 + f4_CO2 * CO2_A * t^2 + f5_CO2 * (CO2_A^2) * t^4 + f6_CO2 * CO2_V * CO2_A * t^3);

        % NOX emission estimation (two cases based on acceleration sign)
        NOX_V = vehicle_trajectory{i,j}(4);
        NOX_A = vehicle_trajectory{i,j}(5);

        if NOX_A >= -0.5
            f1_NOX = 6.19e-04;
            f2_NOX = 8.00e-05;
            f3_NOX = -4.03e-06;
            f4_NOX = -4.13e-04;
            f5_NOX = 3.80e-04;
            f6_NOX = 1.77e-04;
        else
            f1_NOX = 2.17e-04;
            f2_NOX = 0;
            f3_NOX = 0;
            f4_NOX = 0;
            f5_NOX = 0;
            f6_NOX = 0;
        end

        E_NOX = E_NOX + max(0, f1_NOX + f2_NOX * NOX_V * t + f3_NOX * (NOX_V^2) * t^2 + f4_NOX * NOX_A * t^2 + f5_NOX * (NOX_A^2) * t^4 + f6_NOX * NOX_V * NOX_A * t^3);

        % VT-CPFM (Vehicle Total Cycle Performance Fuel Model)
        VT_M = 1500;        % Vehicle mass in kg
        VT_C_A = 0.4;       % Aerodynamic drag coefficient in kg/m
        VT_g = 9.8;         % Gravitational acceleration
        VT_f = 0.015;       % Rolling resistance coefficient
        VT_Eta = 0.8;       % Driveline mechanical efficiency

        VT_P = ((VT_M * vehicle_trajectory{i,j}(5) * t^2 + VT_C_A * (vehicle_trajectory{i,j}(4)^2 * t^2) + VT_M * VT_g * VT_f) * vehicle_trajectory{i,j}(4) * t) / VT_Eta;

        if VT_P >= 0
            VTCPFM = VTCPFM + 0.54 + 0.06 * VT_P + 0.00017 * VT_P^2;
        else
            VTCPFM = VTCPFM + 0.54;
        end
    end

    indi(i,1) = ttc_num;
    indi(i,2) = MTTC_num;
    indi(i,3) = DRAC_num;

    indi(i,4) = VSP;
    indi(i,5) = E_CO2 / T;
    indi(i,6) = E_NOX / T;
    indi(i,7) = VTCPFM / T;
end

% Calculate average traffic safety and energy/emission indicators
ttc_avg = mean(indi(:,1));
MTTC_avg = mean(indi(:,2));
DRAC_avg = mean(indi(:,3));

VSP_sum = sum(indi(:,4));
CO2_avg = mean(indi(:,5));
NOX_avg = mean(indi(:,6));
VTCPFM_avg = mean(indi(:,7));

IDM_assess = [ttc_avg, MTTC_avg, DRAC_avg, VSP_sum, CO2_avg, NOX_avg, VTCPFM_avg];
