% only yr 2007

clear all
close all
clc
format compact

gdx_filename = 'result_default.gdx'; title_name = 'No Policy'; file_name = 'egycons';

%% ================================================================== %%
% SET
[~, rs_id] = getgdx(gdx_filename, 'rs'); % All regions: China provinces + Other regions
rs = rs_id{1};
clear rs_id;

[~, r_id] = getgdx(gdx_filename, 'r'); % Other regions: USA, EUR, ODC, ROW
r = r_id{1};
clear r_id;

[~, s_id] = getgdx(gdx_filename, 's'); % Other regions: USA, EUR, ODC, ROW
s = s_id{1};
clear s_id;

[~, g_id] = getgdx(gdx_filename, 'g'); % Goods and final demands
g = g_id{1};
g(end-1:end) = []; % eliminate 'hh1' & 'hh2'
clear g_id;

[~, i_id] = getgdx(gdx_filename, 'i'); % Goods and sectors
i = i_id{1};
clear i_id;


%% ================================================================== %%
[report, report_id] = getgdx('result_default.gdx', 'report'); % [7]x[6]x[35]
% report_id{1}; % COL/GAS/OIL/GDP/egycons/GDPperCapita/consCO2emis
% report_id{2}; % 2007/2010/2015/2020/2025/2030
% report_id{3}; % r+s+CHN

egycons = squeeze(report(strcmp('egycons', report_id{1}),1,1:30));

figure(1); clf; hold on;
bar(1:30, egycons, 'facec', [0.7 0.7 0.7], 'edge', 'none');
xlim([0.4 30.6]);
set(gca, 'fontsize', 7);
set(gca, 'layer', 'top');
set(gca, 'xtick', 1:30);
set(gca, 'xticklabel', r);
box off
set(gca, 'tickdir', 'out');
set(gca, 'ticklength', [0.005 0.005])
ylabel('Energy Consumption (mtce)');
title('Energy Consumption (COL+GAS+CRU) in 2007 (ELE trades excluded)', 'fontsize', 10, 'fontweight', 'bold');
set(gcf, 'units', 'inch', 'pos', [0.7292    7.2813    9.35    2]);
set(gca, 'pos', [0.0602    0.1023    0.8574    0.7883]);

% ==============================
[report, ~] = getgdx('result_egycap.gdx', 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),1,1:30));
bar(1:30, egycons, 0.5, 'facec', [0.3 0.3 0.3], 'edge', 'none');

bar([1:3, 10:12, 26], egycons([1:3, 10:12, 26]), 0.5, 'facec', [0.3 0.3 0.3], 'edge', 'w', 'linewidth', 1);

legend('No Policy', 'Energy Cap in JJJ, YRD, and PRD');

% export_fig egycons_2007 -w


%% ================================================================== %%
[report2, report2_id] = getgdx('result_default.gdx', 'report2'); %
% report2_id{1} % Wchange/HHEGYUSE
% report2_id{2} % 2007
% report2_id{3} % Sector c
% report2_id{4} % r+s+CHN

wchange = squeeze(report2(1,1,1,1:30));

figure(2); clf; hold on;
% bar(1:30, wchange, 'facec', [0.7 0.7 0.7], 'edge', 'none');

% ==============================
[report2, ~] = getgdx('result_egycap.gdx', 'report2'); %
wchange = squeeze(report2(1,1,1,1:30));
bar(1:30, wchange, 0.5, 'facec', [0.3 0.3 0.3], 'edge', 'none');

% ylim([-1.5 0.5]);
set(gca, 'yminortick', 'on');%, 'yTicksBetween', 5);
xlim([0.4 30.6]);
set(gca, 'fontsize', 7);
set(gca, 'layer', 'top');
set(gca, 'xtick', 1:30);
set(gca, 'xticklabel', r);
box off
set(gca, 'tickdir', 'out');
set(gca, 'ticklength', [0.005 0.005])
ylabel('Welfare Change (%)');
title('Welfare Change with Energy Cap in JJJ, YRD, and PRD', 'fontsize', 10, 'fontweight', 'bold');
set(gcf, 'units', 'inch', 'pos', [0.7292    4.3021    9.35    2]);
set(gca, 'pos', [0.0602    0.1023    0.8574    0.7883]);

for rn = [1:3, 4, 10:12]
    text(rn, wchange(rn), [' ', num2str(wchange(rn), '%2.2f'), '%'], 'fontsize', 7, 'color', 'w', 'rotation', 90);
end
text(26, wchange(26), [' ', num2str(wchange(rn), '%2.2f'), '% '], 'fontsize', 7, 'color', [0.3 0.3 0.3], 'rotation', 90, 'horizontalalignment', 'right');

% export_fig welfare_chg_2007 -w


%% ================================================================== %%
[report, ~] = getgdx('result_default.gdx', 'report'); % [7]x[6]x[35]
consCO2emis0 = squeeze(report(7,1,1:30));

[report, ~] = getgdx('result_egycap.gdx', 'report'); % [7]x[6]x[35]
consCO2emis = squeeze(report(7,1,1:30));

CO2_pctg = ((consCO2emis - consCO2emis0)./consCO2emis0)*100;

figure(3); clf; hold on;
bar(1:30, consCO2emis0, 'facec', [0.7 0.7 0.7], 'edge', 'none');
bar(1:30, consCO2emis, 0.5, 'facec', [0.3 0.3 0.3], 'edge', 'none');
xlim([0.4 30.6]);
set(gca, 'fontsize', 7);
set(gca, 'layer', 'top');
set(gca, 'xtick', 1:30);
set(gca, 'xticklabel', r);
box off
set(gca, 'tickdir', 'out');
set(gca, 'ticklength', [0.005 0.005])

ylabel('CO2 Emissions (Mt)');
title('CO2 Emissions in 2007', 'fontsize', 10, 'fontweight', 'bold');
set(gcf, 'units', 'inch', 'pos', [0.7292    1.2604    9.35    2]);
set(gca, 'pos', [0.0602    0.1023    0.8574    0.7883]);

for rn = [1:3, 10:12, 26]
    text(rn, consCO2emis(rn), [' ', num2str(CO2_pctg(rn), '%2.0f'), '% '], 'fontsize', 7, 'color', 'w', 'rotation', 90, 'horizontalalignment', 'right');
end

% export_fig consCO2emis_2007 -w


