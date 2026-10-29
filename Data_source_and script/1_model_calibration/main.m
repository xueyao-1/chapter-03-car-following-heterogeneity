function main
fun = @Log_IDM
lb = [0,0,0,0,0];
ub = [10,3,3,10,10];
x0 = [3,0,1,3,3]; 

Opt = opti('fun',fun,'bounds',lb,ub,'x0',x0,'xtype',xtype,'options',opts);
[para,loglikl,exitflag,info] = solve(Opt)
end

function loglikl = Log_IDM(para)
%     global N K data
    load('CF_30.mat');
    data = CF_30{1,2};
    N = size(data,1);
    K = 5;
    pai = 3.14159;
    temps = zeros(5,5);
    temp = zeros(5,5); 
    u = [0 0 0 0 0];
    temps = 0;
    temp = 0; 
    u = 0;
    for i = 1:N
        a_new = para(1,1) * (data(i,4)^para(1,2)) * (data(i,10)-data(i,4)) / (data(i,6)^para(1,3)) + para(1,4) * (data(i,6) - para(1,5)* data(i,4))^3;           
        resi = abs(a_new - data(i,5));
%         ei = [resi,resi,resi,resi,resi];
        ei = resi;
        temp = temp + (ei-u).*(ei-u)';
        sigma = temp / N;
        sum = temps + (ei-u)'.* inv(sigma).*(ei-u);
    end
    loglikl = 0.5*K*N*log(2*pai)+0.5*N*log(det(sigma))+ sum;
end