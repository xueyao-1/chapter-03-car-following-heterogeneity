%% Create a matrix combining labels and raw data
% Get row and column sizes of the labeled dataset
% Unlabeled dataset for S3VM
[r_IDM_1,c_IDM_1] = size(data_IDM_labeldata.a);
% Unlabeled dataset for S3VM
[r_IDM_2,c_IDM_2] = size(data_IDM_newX.a);
% Get the combined size after merging
r_IDM = r_IDM_1+r_IDM_2;
c_IDM = max(c_IDM_1,c_IDM_2);
%Create the merged matrix and populate the relevant data
Label_origin = zeros(r_IDM,c_IDM);
for i = 1:r_IDM_1
    Label_origin(i,1:5) =  data_IDM_labeldata.a(i,1:5);
end

for i = 1:r_IDM_2
    Label_origin(r_IDM_1+i,1:5) =  data_IDM_newX.a(i,1:5);
end

for i = 1:r_IDM
    Label_origin(i,6) =  a_s3vm_final_labels(i,1);
end

% Extract aggressive, normal, and mild driving style samples into separate matrices
Label_aggressive = [];
Label_normal = [];
Label_mild = [];
for i = 1:r_IDM
    if Label_origin(i,6) == 1 % Label_aggressive
        Label_aggressive = [Label_aggressive;Label_origin(i,:)];
    elseif Label_origin(i,6) == 0 % Label_normal
        Label_normal = [Label_normal;Label_origin(i,:)];
    elseif Label_origin(i,6) == -1 % Label_mild
        Label_mild = [Label_mild;Label_origin(i,:)];
    end
end

number_graph = 100;

%% Analyze each column of the Aggressive driving style
%Create empty matrices for each parameter
x_Label_aggressive_1 = zeros(size(Label_aggressive,1),1);
x_Label_aggressive_2 = zeros(size(Label_aggressive,2),1);
x_Label_aggressive_3 = zeros(size(Label_aggressive,3),1);
x_Label_aggressive_4 = zeros(size(Label_aggressive,4),1);
x_Label_aggressive_5 = zeros(size(Label_aggressive,5),1);

% Fit lognormal distribution to each column
for j = 1:size(Label_aggressive,1) % Label_aggressive
    x_Label_aggressive_1(j,1) = Label_aggressive(j,1); % get x
end
% Column 1 (e.g., acceleration a): extract data and compute MLE
phat_Label_aggressive_1 = mle(x_Label_aggressive_1,'distribution','LogNormal');
muHat_Label_aggressive_1 = phat_Label_aggressive_1(1); % mean MLE
sigmaHat_Label_aggressive_1 = phat_Label_aggressive_1(2); % std MLE

% Plot histogram with fitted lognormal curve
figure
nf_Label_aggressive_1 = histfit(x_Label_aggressive_1,number_graph,'lognormal'); % number_graph
npd_Label_aggressive_1 = fitdist(x_Label_aggressive_1,'lognormal'); %
title('Aggressive a lognormal distribution')
legend('Observed Samples','Fitted Distribution')

for j = 1:size(Label_aggressive,1) % Label_aggressive
    x_Label_aggressive_2(j,1) = Label_aggressive(j,2); % 
end
% 
phat_Label_aggressive_2 = mle(x_Label_aggressive_2,'distribution','LogNormal');
muHat_Label_aggressive_2 = phat_Label_aggressive_2(1); % 
sigmaHat_Label_aggressive_2 = phat_Label_aggressive_2(2); %

% Repeat for Column 2 (e.g., deceleration b)
% Repeat for Column 3 (e.g., minimum gap S_0)
% Repeat for Column 4 (e.g., desired time headway T)
% Repeat for Column 5 (e.g., desired speed V_0)

%% Analyze each column of the Normal driving style
% Same structure as above: extract, fit, plot each parameter

%% Analyze each column of the Mild driving style
% Same structure as above: extract, fit, plot each parameter

%% Save parameter results into para_IDM_lognormal
% Create arrays to hold MLE-based and fitdist-based parameters

% For aggressive drivers (row 1): store exp(mu) for all 5 parameters
% For normal drivers (row 2)
% For mild drivers (row 3)

% Save MLE results to para_IDM_lognormal_MLE.mat
% Save fitdist results to para_IDM_lognormal_fitdist.mat

% Note: mean values from MLE and fitdist are identical (exp(mu)), 
%       but the standard deviations differ


%% save data to para_IDM_lognormal
para_IDM_lognormal_MLE = zeros(3,5);
para_IDM_lognormal_fitdist = zeros(3,5);

% MLE data
% aggressive
para_IDM_lognormal_MLE(1,1) = exp(muHat_Label_aggressive_1);
para_IDM_lognormal_MLE(1,2) = exp(muHat_Label_aggressive_2);
para_IDM_lognormal_MLE(1,3) = exp(muHat_Label_aggressive_3);
para_IDM_lognormal_MLE(1,4) = exp(muHat_Label_aggressive_4);
para_IDM_lognormal_MLE(1,5) = exp(muHat_Label_aggressive_5);

% normal
para_IDM_lognormal_MLE(2,1) = exp(muHat_Label_normal_1);
para_IDM_lognormal_MLE(2,2) = exp(muHat_Label_normal_2);
para_IDM_lognormal_MLE(2,3) = exp(muHat_Label_normal_3);
para_IDM_lognormal_MLE(2,4) = exp(muHat_Label_normal_4);
para_IDM_lognormal_MLE(2,5) = exp(muHat_Label_normal_5);

% mild
para_IDM_lognormal_MLE(3,1) = exp(muHat_Label_mild_1);
para_IDM_lognormal_MLE(3,2) = exp(muHat_Label_mild_2);
para_IDM_lognormal_MLE(3,3) = exp(muHat_Label_mild_3);
para_IDM_lognormal_MLE(3,4) = exp(muHat_Label_mild_4);
para_IDM_lognormal_MLE(3,5) = exp(muHat_Label_mild_5);

save('para_IDM_lognormal_MLE.mat')

% fitdist data
% aggressive
para_IDM_lognormal_fitdist(1,1) = (exp(npd_Label_aggressive_1.mu));
para_IDM_lognormal_fitdist(1,2) = (exp(npd_Label_aggressive_2.mu));
para_IDM_lognormal_fitdist(1,3) = (exp(npd_Label_aggressive_3.mu));
para_IDM_lognormal_fitdist(1,4) = (exp(npd_Label_aggressive_4.mu));
para_IDM_lognormal_fitdist(1,5) = (exp(npd_Label_aggressive_5.mu));

% normal
para_IDM_lognormal_fitdist(2,1) = (exp(npd_Label_normal_1.mu));
para_IDM_lognormal_fitdist(2,2) = (exp(npd_Label_normal_2.mu));
para_IDM_lognormal_fitdist(2,3) = (exp(npd_Label_normal_3.mu));
para_IDM_lognormal_fitdist(2,4) = (exp(npd_Label_normal_4.mu));
para_IDM_lognormal_fitdist(2,5) = (exp(npd_Label_normal_5.mu));

% mild
para_IDM_lognormal_fitdist(3,1) = (exp(npd_Label_mild_1.mu));
para_IDM_lognormal_fitdist(3,2) = (exp(npd_Label_mild_2.mu));
para_IDM_lognormal_fitdist(3,3) = (exp(npd_Label_mild_3.mu));
para_IDM_lognormal_fitdist(3,4) = (exp(npd_Label_mild_4.mu));
para_IDM_lognormal_fitdist(3,5) = (exp(npd_Label_mild_5.mu));

save('para_IDM_lognormal_fitdist.mat')
