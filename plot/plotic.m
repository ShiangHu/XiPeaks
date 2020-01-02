function plotic(metastep,plotflag)
% Plot information criteria in stepwise forward optimization fitting
% Likelihood, aic, bic, exitflag
% Input
%         metastep --- 4 * # of components

if plotflag==1
    
    figure,
    subplot(121),
    plot(metastep(1:3,:)','linewidth',2);
    legend({'Lh','AIC','BIC'});
    xlabel('# of components');xlim([1 size(metastep,2)]);
    set(gca,'fontsize',12);
    axis square;
    
    subplot(122),
    plot(metastep(4,:),'linewidth',2);
    xlabel('# of components');xlim([1 size(metastep,2)]);
    ylabel('ExitFlag');ylim([-3 5]);
    set(gca,'fontsize',12,'ytick',[-3 -2 -1 0 2 3 4 5]);
    axis square;
end