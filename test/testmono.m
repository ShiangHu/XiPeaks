clean;
addpath(genpath(cd));
load vctspt;
lmd = 0;

% x = linspace(-2,3,308)';
% x= exp(-x.^2/2+1);
% e = 0.1*(rand(308,1) - 0.3);
% pks_real = x + e;
% load xi_a;
load pks;
% pks_real = pks_real(89:end);
% freq = freq(89:end);

% pks_real = sigk_sdo(:,1);

tic;
pks_up = mono(pks_real, freq, lmd);
toc;

% plot
pict([pks_real,pks_up],freq,{'Pks real','Pks fit'});