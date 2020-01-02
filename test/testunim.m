% visualize the results of EM unim

clean;
load Unitest4;
ank = size(sigIt.sdo,2);
maxIt = size(sigIt.sdo,3);
psd_real = spt;

idx = 1:2:10;
lgd = {'Real','EM it1', 'EM it 3', 'EM it 5', 'EM it 7', 'EM it 9'};
tl = {'Xi','C1','C2','C3','C4','C5'};

% plot the imcomplete loglikelihood
% figure, plot(1:maxIt, lh, 'linewidth', 2), title('Incomplete logL'); xlabel('EM iterations'); ylabel('-logL'); set(gca,'fontsize',12);

% plot the general fitting and individual components
figure,plot(freq,[psd_real,sigIt.K(:,:,end),sum(sigIt.K(:,:,end),2)],'linewidth',2);
legend({'Spt','Xi','Theta','Alpla1','Alpha2','Beta1','Beta2', 'Fit'});
xlabel('Frequencies'); ylabel('Power');set(gca,'fontsize',14);grid on

% Check fitting
psd_ftd = squeeze(sum(sigIt.K(:,:,[1 2 6 maxIt+1]),2)); 
figure, plot(freq, [psd_real,psd_ftd], 'linewidth', 2), legend({'Spt', 'Fit initial', 'Fit EM1', 'Fit EM5', 'Fit EM10'});
xlabel('Frequencies'), ylabel('Power'), set(gca,'fontsize',14); grid on;
sigIt.K (:,:,1) =[]; sigIt.E (:,:,1) =[]; 
 
% check for the Variations in EM
sdo = permute(sigIt.sdo,[1,3,2]); sig = permute(sigIt.K,[1,3,2]);

% Fitting error
figure,plot(rms(sum(sig,3)-repmat(psd_real,[1,maxIt])),'linewidth',2); xlabel('EM iterations'); ylabel('Fitting error');set(gca,'fontsize',12)

% Fitting tendency for separate components
figure, for k=1:ank, subplot(ank,1,k),plot(freq,[psd_real,sig(:,idx,k)],'linewidth',2); title(tl{k});legend(lgd);set(gca,'fontsize',12); end

% likelihood for separate components
% sdo = permute(sdo,[2,3,1]); sig = permute(sig,[2,3,1,]);
% lmd = repmat([1e3,1e-5,1e-5],[maxIt,1,nf-3]); C = diff(eye(nf),3);
% sigc = reshape(reshape(sig,[maxIt*ank,nf])*C',[maxIt,ank,nf-3]);
% lh = sum(log(sig)+sdo./sig,3) + sum(lmd.*sigc.^2,3);
% figure, for k=1:ank, subplot(ank,1,k),plot(lh(:,k),'linewidth',2); title(tl{k}); xlabel('EM iterations'); ylabel('-logL');set(gca,'fontsize',12);end