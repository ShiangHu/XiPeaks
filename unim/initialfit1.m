function [x0, sigk_ini] = initialfit1(psd,freq,plotflag)
% Initialize the starting point and bounds for fmincon
% Input
%        psd --- power spectrum density in natural scale
%        freq --- frequency bins
%        plotflag --- [1 1], plot initialized separate components & picked extremes; ~1, not plot
% Ouput
%        x0 --- starting point
%        lb/ub --- lower/upper bounds
%        ank --- actual number of components
% See also FMINCON, PKEXTREM

% Shiang Hu, Jul. 2018

if nargin==2
    plotflag = [];
end

npsd = psd./max(psd);

% find peaks
[pks,fma,fw] = findpeaks(npsd,freq,'minpeakwidth',0.15,'minpeakheight',0.01,'minpeakprominence',0.02);

findpeaks(npsd,freq,'minpeakwidth',0.15,'minpeakheight',0.01,'minpeakprominence',0.02); hold on

% find valleys
[vlys,fmi] = findpeaks(-psd./max(psd),freq,'minpeakwidth',0.15,'minpeakheight',-inf,'minpeakprominence',0.02,'npeaks',length(pks));

plot(fmi,-vlys,'r^','linewidth',2,'markerfacecolor','r'); 
xlabel('Frequency'), ylabel('Power'),legend({'Spt','Pks','Vlys'});
set(gca,'fontsize',14);ylim([0 1.0785])

% paras
nk = 1 + length(pks); % max # of components
mp = max(psd);
x0 = zeros(4,nk);
x0(1:2,1) = [psd(1);freq(1)];
x0(1:3,2:end) = [pks';fma';fw';];
fmas = x0(2,:);

% vis
if plotflag(1)==1,    f1=figure; end % show components
if plotflag(2)==1,    f2=figure; end % show extremes

% roughly estimate the paras separately
for i=1:nk
    % pick the extremes
    if i==1
        [extrem, fm] = pkextrem1(psd,freq,fmas,fmi,i);
    else
        extrem.fma = fma(i-1);
        extrem.fmi = fmi(i-1);
    end
    
%     if isempty(fm)
%         if plotflag(1)==1, figure(f1), plotspfit(freq,psd,[],i,mp); end
%         break;
%     end
    
    % fit component
    x0(:,i) = tp(psd, freq, extrem);
    psd_fit =  stc(x0(:,i),freq);
    
    if plotflag(1)==1, figure(f1), plotspfit(freq, psd, psd_fit, i, mp); end
%     if plotflag(2)==1, figure(f2), plotextrem(freq, psd, extrem, i, mp);  end
    
    % remaining
    psd = psd - psd_fit;
end

sigk_ini = stc(x0,freq);
end