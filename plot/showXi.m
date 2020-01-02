clean;
idx=[45 53 87 88 108 109 112];
load psdf;
load pcgyruspsd; 

psdall=psd;

figure, for i=1:7, subplot(4,2,i), plot(freq,psdall(:,idx(i)),'linewidth',2); title(num2str(idx(i))); end


load Xitest
figure, subplot(211),plot(freq,sdo); title('pseudo'); subplot(212),plot(freq,sig); title('t curve');
figure, for i=1:9, subplot(3,3,i),plot(freq,sdo(:,i),freq,sig(:,i)); legend({'pseudo','t curve'}); title(num2str(i)); end
figure, for i=11:18, subplot(3,3,i-9),plot(freq,sdo(:,i),freq,sig(:,i)); legend({'pseudo','t curve'}); title(num2str(i)); end
figure, for i=10:18, subplot(3,3,i-9),plot(freq,sdo(:,i),freq,sig(:,i)); legend({'pseudo','t curve'}); title(num2str(i)); end
figure, for i=1:9, subplot(3,3,i),plot(freq,sdo(:,i),freq,sig(:,i)); legend({'pseudo','t curve'}); title(num2str(i)); end


% psd=psd_real; 
% psd(setdiff(1:204,[1 39])) = psd(setdiff(1:204,[1 39]),1) + 0.1*abs(randn(202,1));
% figure,plot(freq,[psd_real,psd])
% psd([38 40]) = psd_real([38 40]);
% figure,plot(freq,[psd_real,psd])
% psd_real = psd;


logXi = log(sigk_ini(:,1));

logXi1 = logXi;
logXi1(75:end) = linspace(-2.512,-1,130);
figure,plot([logXi,logXi1]);
psd_real = sigk_ini(:,2) + exp(logXi1);

psd_uni= fmincon(@(x)sum(log(x)+psd_real./x),psd_ftd,diff(eye(204)),zeros(203,1),[],[],lb0,ub0,[],options);
figure,plot(freq,[psd_real,psd_ftd,psd_uni],'linewidth',2); legend({'Real','Heuristic','Monotonic'});set(gca,'fontsize',12)