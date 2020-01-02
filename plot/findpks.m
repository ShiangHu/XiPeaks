clean;
load vctspt;
spt = spt.hm.csd(17,:)';
spt = spt./max(spt);

[pks,pkslocs,w,p] = findpeaks(spt,freq,'minpeakwidth',1,'minpeakheight',0.01);
findpeaks(spt,freq,'minpeakwidth',1,'minpeakheight',0.01); hold on

[vlys,vlylocs,w,p] = findpeaks(-spt,freq,'minpeakwidth',1,'minpeakheight',-0.2,'minpeakprominence',0.01);
% findpeaks(-spt,freq,'minpeakwidth',1,'minpeakheight',-0.2,'minpeakprominence',0.01);

plot(vlylocs,-vlys,'r*','linewidth',2)