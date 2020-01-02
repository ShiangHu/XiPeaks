function [psd_ftd, sigIt, lh] = scmem_unim(psd_real, freq, plotflag)
% SCM EM algorithm with unimodal nonparametric fitting
% Input
%       psd_real --- power spectrum nf*1
%       freq --- frequency vector nf*1
%       plotflag --- [1 0 0], plot for initialization
% Output
%       psd_ftd --- [nf*1] fitted spectrum
%       sigIt --- save sigk, sige, sigk_sdo in each interation as structure
%       meta --- [4*maxIt], lh, aic, bic and exitflag with iterations
% See SCM-EM v7

% Shiang Hu, Aug. 2, 2018

% Heuristic fitting
x0 = initialfit1(psd_real,freq,plotflag);
ind = input('which components are you fitting?\n');
x0 = x0(:,ind); 
sigk_ini = stc(x0,freq);

% EM
progressbar;

[sigIt, sigk, sige, lh, maxIt, ank, nf] = em_initial (sigk_ini, 10);

for i=1:maxIt
    % E step
    c = sum(sigk,2)+sige;
    w = repmat((psd_real-c)./c.^2,[1,ank]);
    sigk_sdo = sigk + w.*sigk.^2;
    sige_sdo = sige + w(:,1).*sige.^2;
    
    % M step
    profile on
    sigk = mstep_unim(sigk_sdo, freq);
    sige = mean(sige_sdo)*ones(nf,1);
    profile viewer; 
    profile off;
    
    % save
    [sigIt,  lh] = em_save(sigIt, lh, sigk, sige, sigk_sdo, sige_sdo, i);
    if i>1 && abs(lh(i)-lh(i-1))<1e-4, break; end
    progressbar(i/maxIt); % drawnow
        
end

psd_ftd = sum(sigk,2);
end