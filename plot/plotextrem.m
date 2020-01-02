function plotextrem(freq, psd, extrem, i, mp)
% Visualize the picked extremes
% Input
%         freq --- frequencies
%          psd --- current remained spectrum
%          fma --- frequency location of maximum spectrum
%          fmi --- frequency location of minimum spectrum
%          ppspline --- piecewise polynomial spline function
%          p --- smoothing parameter
%          mp --- max spect
% See also CSAPS, PPVAL

% Shiang Hu, Jul. 2018

ppspline = extrem.ppspline;
fma = extrem.fma;
fmi = extrem.fmi;
p = extrem.p;

subplot(4,4,i);

s_smooth = csaps(freq,psd,p,freq);

if isrow(s_smooth)
    s_smooth = s_smooth';
end

plot(freq,[s_smooth,psd]); hold on;
plot(fma,ppval(ppspline,fma),'r*','linewidth',2);
plot(fmi,ppval(ppspline,fmi),'gs','linewidth',2);
set(gca,'fontsize',12);
xlabel('Freq'); ylabel('PSD'); ylim([-0.2 1]*mp); 
legend({'CSSP Fit','Remained','Pks','Tfs'}); 
title(strcat(num2str(i),' fit'));
end