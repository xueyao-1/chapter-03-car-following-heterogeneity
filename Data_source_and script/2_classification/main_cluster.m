%% Normalization processing
load('FVDmodel.mat');
Data = Data_normalized_suo(para_CT);
% TC = [para_TC(:,5),para_TC(:,3),para_TC(:,4),para_TC(:,2),para_TC(:,1)];
% Data = Data_normalized_suo(TC);
% Data = para_CC;
% save('data.mat');
% Reverse normalization, A1 stores normalized values, use the command A2 = mapminmax('reverse',A1,PS)
% [A1,PS] = mapminmax(A);
% load('para_CT.mat');
% Data = para_CT;

%% Clustering analysis
[U,P,Dist,Cluster_Res,Obj_Fcn,iter] = fuzzycm(Data,3,3,2,1.0e-6);

%% Add ID for each data point
load('para_CC');
ID = 1:1:1318;
para_CC = [ID',para_CC];
save('para_CC.mat');
load('para_CT');
ID = 1:1:710;
para_CT = [ID',para_CT];
save('para_CT.mat');
load('para_TC');
ID = 1:1:960;
para_TC = [ID',para_TC];
save('para_TC.mat');

%% Classify and save to file
load('Cluster_Res_TC');
load('indata_TC');
TC = Cluster_Res_TC';
TC_cluster1 = {};
TC_cluster2 = {};
TC_cluster3 = {};
x = 1;
y = 1;
z = 1;
A = indata_TC(:,2);
T = cell2mat(A);
for i = 1:size(indata_TC,1)
     if ismember(T(i,1),TC(:,1))==1 
         TC_cluster1(x,:) = indata_TC(i,:);
         x = x + 1;
     elseif ismember(T(i,1),TC(:,2))==1
         TC_cluster2(y,:) = indata_TC(i,:);
         y = y + 1;
     elseif ismember(T(i,1),TC(:,3))==1
         TC_cluster3(z,:) = indata_TC(i,:);
         z = z + 1;
     else
     end
end
save TC_cluster1.mat;
save TC_cluster2.mat;
save TC_cluster3.mat;

%% Distribution fitting and plotting
load('CC_g1_1.mat');
C1 = CC_g1_1;
life = C1;
binWidth = 0.05;
lastVal = ceil(max(life));
binEdges = 0:binWidth:lastVal+1;
h = histogram(life,binEdges);
xlabel('Time to Failure');
ylabel('Frequency');

% counts_CC_c1_Esti = histcounts(life,binEdges);
% binCtrs_CC_c1_Esti = binEdges(1:end-1) + binWidth/2;
% h.FaceColor = [1 1 1];
% hold on
% plot(binCtrs_CC_c1_Esti,counts_CC_c1_Esti,'o');
% hold off
% save('binCtrs_CC_c1_Esti.mat','binCtrs_CC_c1_Esti');
% save('counts_CC_c1_Esti.mat','counts_CC_c1_Esti');

pd1 = fitdist(life,'Gamma');
pd2 = fitdist(life,'Stable');
pd3 = fitdist(life,'Lognormal');
pd4 = fitdist(life,'LogLogistic');

h = histogram(life,binEdges,'Normalization','pdf','FaceColor','[0.2 0.8 0.67]','EdgeColor','none'); % mild [0.1 0.67 0.9]
% h = histogram(life,binEdges,'Normalization','pdf','FaceColor','none'); % normal [0.67 0.2 0.8]
% h = histogram(life,binEdges,'Normalization','pdf','FaceColor','[1 0.5 0]','EdgeColor','r'); % aggressive [0.2 0.8 0.67]

xlabel('The value of v_0');
ylabel('Frequency distribution');
ylim([0 0.15]);
xlim([0,0.5]);
title('(a3)C-C/Aggressive');

xgrid = linspace(0,0.5,100)';
pdfEst1 = pdf(pd1,xgrid);
pdfEst2 = pdf(pd2,xgrid);
pdfEst3 = pdf(pd3,xgrid);
pdfEst4 = pdf(pd4,xgrid);
% pdfEst5 = pdf(pd5,xgrid);
line(xgrid,pdfEst1,'linewidth',1,'color','r','Marker','square');
line(xgrid,pdfEst2,'linewidth',1,'color','g','Marker','x');
line(xgrid,pdfEst3,'linewidth',1,'color','b','Marker','*');
line(xgrid,pdfEst4,'linewidth',1,'color','k','Marker','.');
% line(xgrid,pdfEst5,'linewidth',1,'color','m','Marker','+');
legend('Histogram','Gamma','Stable','Lognormal','Loglogistic');  %% Legend
set(gca,'FontName','Times New Roman','FontSize',17); % Set axis font and size
% saveas(gcf, 'C-C/Normal', 'fig');
% saveas(gcf, 'C-C/Normal', 'png');

%% Parameter estimation
data = CC_para1(:,1);
phat1 = mle(data,'distribution','Burr');
phat2 = mle(data,'distribution','Stable');
phat3 = mle(data,'distribution','Lognormal');
phat4 = mle(data,'distribution','LogLogistic');

CC_v1_Y1 = random('Burr', 5.6422,3.9489,0.6232,[1,24]);
CC_v1_Y2 = random('stable', 1.2411,1.0000,1.9420,5.9205,[1,24]);
CC_v1_Y3 = random('Lognormal',1.9556,0.5459,[1,24]);
CC_v1_Y4 = random('LogLogistic',1.9326,0.3103,[1,24]);
aa = [];
aa = [aa;CC_v1_Y1;CC_v1_Y2;CC_v1_Y3;CC_v1_Y4];
CC_c1_Esti = aa';
save('CC_c1_Esti.mat','CC_c1_Esti')

%% Calculate KL divergence
X = binCtrs_CC_c1_Esti';
P1 = counts_CC_c1_Esti';
P2 = CC_c1_Esti';
KL = kldiv(X,P1,P2)
