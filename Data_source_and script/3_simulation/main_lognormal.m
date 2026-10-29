clc;clear
close all;


% Random variable Q (e.g., acceleration noise)
x_Label_aggressive_6 = [];
number_graph = 50;

% Fit lognormal distribution to the dataset
% Estimate lognormal parameters using Maximum Likelihood Estimation (MLE)
phat_Label_aggressive_6 = mle(x_Label_aggressive_6,'distribution','LogNormal');
muHat_Label_aggressive_6 = phat_Label_aggressive_6(1); % Get the MLE for the mean and standard deviation of the log-values
sigmaHat_Label_aggressive_6 = phat_Label_aggressive_6(2); % 

Generate histogram and fitted lognormal curve
figure
nf_Label_aggressive_6 = histfit(x_Label_aggressive_6,number_graph,'lognormal'); % 
npd_Label_aggressive_6 = fitdist(x_Label_aggressive_6,'lognormal'); %Fit the distribution using MATLAB's fitdist function (must be column vector)
title('Aggressive a lognormal distribution')
legend('Observed Samples','Fitted Distribution')

MLE-based parameter for aggressive drivers
% aggressive
para_IDM_lognormal_MLE = exp(muHat_Label_aggressive_6);

fitdist-based parameter for aggressive drivers
% aggressive
para_IDM_lognormal_fitdist = (exp(npd_Label_aggressive_6.mu));