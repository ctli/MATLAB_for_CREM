clear all
close all
clc
format compact

yr = [2007, 2010:5:2100];
lp = [0 diff(yr)]; %year to next time period
lp_tot = cumsum(lp);

%% emission factor
emis_factor1 = exp(-0.03*lp_tot);
emis_factor2 = exp(-0.01*lp_tot);

figure(1); clf;
plot(yr, emis_factor1, 'x-', ...
     yr, emis_factor2, 'x-');
set(gca, 'fontsize', 8);
legend('\alpha=-0.03 (for SO2)', '\alpha=-0.01 (for NOx)');
ylabel('Emission Factor (-)');
title('Emission Factor: exponential decay, exp(\alpha*t)', 'fontsize', 10);

xlim([2005 2100]);


%%
alpha = [-0.3 %SO2
         -0.1];%NOx

lo_bnd = [0.85 %SO2
          0.8];%NOx
lo_bnd = repmat(lo_bnd,1,length(yr));

ef = exp(alpha*(lp_tot-3)).*(1-lo_bnd)+lo_bnd; % emission factor

figure(1); hold on;
plot(yr, ef, '^-');

plot([1 1]*2030, [0 1], 'color', [0.8 0.8 0.8]);
ylim([0 1]);