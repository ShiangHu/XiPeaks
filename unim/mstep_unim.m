function sigk_up = mstep_unim(sigk_sdo, freq)
% Separately update the fitting for each spectrum component in the M step
% using the nonlinear contrained programming solver (fmincon) and unimodal
% nonparametric fitting
% Input
% psd_real --- []
% sigk_sdo --- [nf*ank] pseudo components updated in E step
%       xs0 --- [4*15] initialized parameters in updating
% Output
%   x0_up --- updated parameters
%   sigk_up  --- updated components
% See also scmfmin_em

% Shiang Hu, Aug. 9, 2018

% initialize
ank = size(sigk_sdo,2);
sigk_up = zeros(size(sigk_sdo));

% smoothing paras
lmd1 = 0.01;
lmd2 = 0;

for k=1:ank
    
    if k==1
        sigk_up(:,k) = mono(sigk_sdo(:,k), freq, lmd1);
        
    else
        sigk_up(:,k) = mono(sigk_sdo(:,k), freq, lmd2);
%         sigk_up(:,k) = stcfit(sigk_sdo(:,k), freq);
    end
    
end