function loglikl = Log_IDM(para,data,N,K)
%     global N K data
    pai = 3.14159;
    temps = zeros(K,K);
    temp = zeros(K,K); 
    u = [0 0 0 0 0];
    temps = 0;
    temp = 0; 
    u = 0;
    for i = 1:N
%         a_new = para(1,1).*( 1-(data(i,4)./para(1,2)).^para(1,3) -((para(1,4)+data(i,4).*para(1,5)+(data(i,4).*(data(i,10)-data(i,4))./(2*sqrt(para(1,1).*para(1,6)))))./data(i,6)).^2 );
%         resi = abs(a_new - data(i,5));
%         %ei = [resi,resi,resi,resi,resi];
        a_new = para(1,1).*( 1-(data(i,4)./para(1,2)).^para(1,3) -((para(1,4)+data(i,4).*1 +(data(i,4).*(data(i,10)-data(i,4))./(2*sqrt(para(1,1).*para(1,5)))))./data(i,6)).^2 );
        resi = abs(a_new - data(i,5));
        ei = resi;
        temp = temp + (ei-u).*(ei-u)';
        sigma = temp / N;
        sum = temps + (ei-u)'.* inv(sigma).*(ei-u);
    end
    loglikl = 0.5*K*N*log(2*pai)+0.5*N*log(det(sigma))+ sum;
end
