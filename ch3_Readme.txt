1. Model calibration
Input data: CF_30.mat
Calibration: Main.m, Log_IDM.m
Output: Para_IDM.mat, IDM_cali_params_list.csv

2. Classification
Input data: DS_IDM.mat
Classification: main_cluster.m, FSmethod.ipynb, lap_score.ipynb, linear_assignment_.ipynb, unsupervised_evaluation.ipynb
Output: classification_results.xlsx, WCF_3.mat

3. Simulation
data_extract.m: loads vehicle trajectory plots from .fig files, extracts and smooths data from aggressive, normal, and mild vehicles, and visualization. 

heterogeneous_graph.m: extracts position, speed, and acceleration from heterogeneous vehicle trajectory data and assess traffic dynamics.

generate_para_IDM.m: generates randomized IDM (Intelligent Driver Model) parameters for aggressive, normal, and mild drivers by sampling from fitted lognormal distributions with controlled variability.

IDM_RBF_lognormal.m: fits lognormal distributions for five IDM parameters across aggressive, normal, and mild driving styles, visualizes them, and saves the estimated parameters.

main.m: fits a lognormal distribution to a sample set for aggressive driver parameter estimation using MLE and fitdist.

Seedengine_PI.m: generates a heterogeneous vehicle stream with arrival times based on a negative exponential distribution and assigns each vehicle type, location, speed, and acceleration.

HV_CF_IDM.m: implements the Intelligent Driver Model (IDM) to update the position, speed, and acceleration of a human-driven vehicle based on car-following dynamics and stochastic noise.

Assessment_IDM.m: evaluates vehicle trajectories for traffic safety, fuel consumption, and emissions by calculating indicators including TTC, MTTC, DRAC, VSP, CO₂, NOₓ, and VT-CPFM.

IDM_figure_heatmap.m: visualization of traffic safety, fuel consumption, and emissions.

simulation_sigma_4.m: runs a time-step-based traffic simulation using the IDM model for heterogeneous vehicles with different driving styles (aggressive, mild, normal).

traj_trajectory.m: initializes the vehicle trajectory cell array using the AP matrix to reduce computational cost.


