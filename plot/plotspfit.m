function plotspfit(freq,psd,psd_det,i,maxpsd)
% Plot seprate fiting
% Input
%        freq --- frequencies
%         psd --- current remained spectrum curve
% psd_det --- current fitted component
%              i --- i=1:ank, index for components
% maxpsd --- maximum of raw spectrum
% See also plotextrem

% Shiang Hu, Jul. 2018

subplot(4,4,i),
plot(freq,[psd,psd_det]);
xlabel('Frequency (Hz)'), ylabel('PSD (uv^2/Hz)');
ylim([-0.2 1]*maxpsd);


if isempty(psd_det)
    title('Final fitting error');
else
    title(strcat(num2str(i),' fit'));
    legend({'Remained','Fitted'});
end