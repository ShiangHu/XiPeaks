%% Spctrum Components Model OPTimized
clean;
addpath(genpath(cd));
dbstop if error;
% edit option


%% import spectrum and freq
load vctspt;
spt = spt.hm.csd(17,:)';
% spt = spt./max(spt);

%% plot initialized components and peaks/troughs
plotflag = [1 1 1];

% unimodal fitting
[spt_ftd,sigIt,lh] = scmem_unim(spt,freq,plotflag);

save Unitest4 sigIt lh spt freq