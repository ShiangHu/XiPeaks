figure,plot(freq,[psd_real,sigk_ini]); legend({'Real','Xi','Alpha'})
figure,plot(freq,[psd_real,sigk_ini,sum(sigk_ini,2)]); legend({'Real','Xi','Alpha','Fit'})
xlabel('Freq'); ylabel('Power')
set(gca,'fontsize',14)
title('Sptceegl O1');