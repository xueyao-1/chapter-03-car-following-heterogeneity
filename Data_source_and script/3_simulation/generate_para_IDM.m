% generate parameters
% load('para_IDM_lognormal_fitdist.mat');
load('para_IDM_lognormal_fitdist_HighD.mat')
n = 1;
% aggressive
A11 = para_IDM_lognormal_fitdist(1,1)*0.9 + para_IDM_lognormal_fitdist(1,1)*0.2 * rand(100,1);
a_a = A11(randperm(numel(A11),n));
a_a = sort(a_a);

A12 = para_IDM_lognormal_fitdist(1,2)*0.9 + para_IDM_lognormal_fitdist(1,2)*0.2 * rand(100,1);
DS_a = A12(randperm(numel(A12),n));
DS_a = sort(DS_a);

A13 = para_IDM_lognormal_fitdist(1,3)*0.9 + para_IDM_lognormal_fitdist(1,3)*0.2 * rand(100,1);
sigma_a = A13(randperm(numel(A13),n));
sigma_a = sort(sigma_a);

A14 = para_IDM_lognormal_fitdist(1,4)*0.9 + para_IDM_lognormal_fitdist(1,4)*0.2 * rand(100,1);
Le_a = A14(randperm(numel(A14),n));
Le_a = sort(Le_a);

A15 = para_IDM_lognormal_fitdist(1,5)*0.9 + para_IDM_lognormal_fitdist(1,5)*0.2 * rand(100,1);
T_a = A15(randperm(numel(A15),n));
T_a = sort(T_a);

A16 = para_IDM_lognormal_fitdist(1,6)*0.9 + para_IDM_lognormal_fitdist(1,6)*0.2 * rand(100,1);
b_a = A16(randperm(numel(A16),n));
b_a = sort(b_a);

% normal
% maximum acceleration
A21 = para_IDM_lognormal_fitdist(2,1)*0.9 + para_IDM_lognormal_fitdist(2,1)*0.2 * rand(100,1);
a_n = A21(randperm(numel(A21),n));
a_n = sort(a_n);

% desired speed
A22 = para_IDM_lognormal_fitdist(2,2)*0.9 + para_IDM_lognormal_fitdist(2,2)*0.2 * rand(100,1);
DS_n = A22(randperm(numel(A22),n));
DS_n = sort(DS_n);

% 
A23 = para_IDM_lognormal_fitdist(2,3)*0.9 + para_IDM_lognormal_fitdist(2,3)*0.2 * rand(100,1);
sigma_n = A23(randperm(numel(A23),n));
sigma_n = sort(sigma_n);

% safe gap distance
A24 = para_IDM_lognormal_fitdist(2,4)*0.9 + para_IDM_lognormal_fitdist(2,4)*0.2 * rand(100,1);
Le_n = A24(randperm(numel(A24),n));
Le_n = sort(Le_n);

% safe headway time
A25= para_IDM_lognormal_fitdist(2,5)*0.9 + para_IDM_lognormal_fitdist(2,5)*0.2 * rand(100,1);
T_n = A25(randperm(numel(A25),n));
T_n = sort(T_n);

% desired deceleration
A26= para_IDM_lognormal_fitdist(2,6)*0.9 + para_IDM_lognormal_fitdist(2,6)*0.2 * rand(100,1);
b_n = A26(randperm(numel(A26),n));
b_n = sort(b_n);

% mild
A31 = para_IDM_lognormal_fitdist(3,1)*0.9 + para_IDM_lognormal_fitdist(3,1)*0.2 * rand(100,1);
a_m = A31(randperm(numel(A31),n));
a_m = sort(a_m);

A32 = para_IDM_lognormal_fitdist(3,2)*0.9 + para_IDM_lognormal_fitdist(3,2)*0.2 * rand(100,1);
DS_m = A32(randperm(numel(A32),n));
DS_m = sort(DS_m);

A33 = para_IDM_lognormal_fitdist(3,3)*0.9 + para_IDM_lognormal_fitdist(3,3)*0.2 * rand(100,1);
sigma_m = A33(randperm(numel(A33),n));
sigma_m = sort(sigma_m);

A34 = para_IDM_lognormal_fitdist(3,4)*0.9 + para_IDM_lognormal_fitdist(3,4)*0.2 * rand(100,1);
Le_m = A34(randperm(numel(A34),n));
Le_m = sort(Le_m);

A35 = para_IDM_lognormal_fitdist(3,5)*0.9 + para_IDM_lognormal_fitdist(3,5)*0.2 * rand(100,1);
T_m = A35(randperm(numel(A35),n));
T_m = sort(T_m);

A36 = para_IDM_lognormal_fitdist(3,6)*0.9 + para_IDM_lognormal_fitdist(3,6)*0.2 * rand(100,1);
b_m = A36(randperm(numel(A36),n));
b_m = sort(b_m);