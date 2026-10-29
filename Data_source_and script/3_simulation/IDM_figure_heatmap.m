label_name = {'0%','10%','20%','30%','40%','50%','60%','70%','80%','90%','100%'};
xlabel_name = label_name;
ylabel_name = label_name;

% ttc
for i = 1:11
    for j = 1:11
        if IDM_ttc(i,j) == 0
            IDM_ttc(i,j) = NaN;
        end
    end
end
figure
h_IDM_ttc = heatmap(xlabel_name,ylabel_name,IDM_ttc);
h_IDM_ttc.XLabel = 'Proportion of Aggressive driving style';
h_IDM_ttc.YLabel = 'Proportion of Mild driving style';



% MTTC
for i = 1:11
    for j = 1:11
        if IDM_MTTC(i,j) == 0
            IDM_MTTC(i,j) = NaN;
        else
            IDM_MTTC(i,j) = IDM_MTTC(i,j)/2;
        end
    end
end
figure
h_IDM_MTTC = heatmap(xlabel_name,ylabel_name,IDM_MTTC);
h_IDM_MTTC.XLabel = 'Proportion of Aggressive driving style';
h_IDM_MTTC.YLabel = 'Proportion of Mild driving style';

% DRAC
for i = 1:11
    for j = 1:11
        if IDM_DRAC(i,j) == 0
            IDM_DRAC(i,j) = NaN;
        end
    end
end
figure
h_IDM_DRAC = heatmap(xlabel_name,ylabel_name,IDM_DRAC);
h_IDM_DRAC.XLabel = 'Proportion of Aggressive driving style';
h_IDM_DRAC.YLabel = 'Proportion of Mild driving style';


% VSP
for i = 1:11
    for j = 1:11
        if IDM_VSP(i,j) == 0
            IDM_VSP(i,j) = NaN;
        else
            IDM_VSP(i,j) = IDM_VSP(i,j);
        end
    end
end
figure
h_IDM_VSP = heatmap(xlabel_name,ylabel_name,IDM_VSP);
h_IDM_VSP.XLabel = 'Proportion of Aggressive driving style';
h_IDM_VSP.YLabel = 'Proportion of Mild driving style';

% CO2 
for i = 1:11
    for j = 1:11
        if IDM_CO2(i,j) == 0
            IDM_CO2(i,j) = NaN;
        end
    end
end
figure
h_IDM_CO2 = heatmap(xlabel_name,ylabel_name,IDM_CO2);
h_IDM_CO2.XLabel = 'Proportion of Aggressive driving style';
h_IDM_CO2.YLabel = 'Proportion of Mild driving style';

% NOX
for i = 1:11
    for j = 1:11
        if IDM_NOX(i,j) == 0
            IDM_NOX(i,j) = NaN;
        else 
            IDM_NOX(i,j) = IDM_NOX(i,j);
        end
    end
end
figure
h_IDM_NOX = heatmap(xlabel_name,ylabel_name,IDM_NOX);
h_IDM_NOX.XLabel = 'Proportion of Aggressive driving style';
h_IDM_NOX.YLabel = 'Proportion of Mild driving style';

% VTCPFM
for i = 1:11
    for j = 1:11
        if IDM_VTCPFM(i,j) == 0
            IDM_VTCPFM(i,j) = NaN;
        end
    end
end
figure
h_IDM_VTCPFM = heatmap(xlabel_name,ylabel_name,IDM_VTCPFM);
h_IDM_VTCPFM.XLabel = 'Proportion of Aggressive driving style';
h_IDM_VTCPFM.YLabel = 'Proportion of Mild driving style';