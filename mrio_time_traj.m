clear all
close all
clc
format compact

gdx_filename = 'result_2007.gdx'; current_yr = 2030;
% gdx_filename = 'result_2030.gdx'; current_yr = 2030;

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

% for gg = 1:length(g)
%     ggg{gg} = [g{gg}, ' (', num2str(gg), ')'];
% end

[~, i_id] = getgdx(gdx_filename, 'i'); % Goods and sectors
i = i_id{1};
clear i_id;


%% ================================================================== %%
[report, report_id] = getgdx(gdx_filename, 'report'); % [7]x[6]x[35]
% report_id{1}; % COL/GAS/OIL/GDP/egycons/GDPperCapita/consCO2emis
% report_id{2}; % 2007/2010/2015/2020/2025/2030
% report_id{3}; % r+s+CHN

% province_name = 'BJ';
% % province_name = 'TJ';
% % province_name = 'HE';
% 
% COL_BJ = report(strcmp('COL', report_id{1}),:,strcmp(province_name,report_id{3}));
% GAS_BJ = report(strcmp('GAS', report_id{1}),:,strcmp(province_name,report_id{3}));
% OIL_BJ = report(strcmp('OIL', report_id{1}),:,strcmp(province_name,report_id{3}));
% 
% yr_span = [2007, 2010, 2015, 2020, 2025, 2030];
% 
% tmp = [COL_BJ;
%        GAS_BJ;
%        OIL_BJ];
% figure(1); clf; hold on;
% ha = area(yr_span, tmp', 'edge', 'none');
% set(ha(1), 'facec', [0.7 0 0]);
% set(ha(2), 'facec', [1 0.65 0]);
% set(ha(3), 'facec', [1 0.6 0.6]);
% set(gca, 'fontsize', 8);
% set(gca, 'tickdir', 'out');
% set(gca, 'layer', 'top');
% set(gca, 'xlim', [2007 2030], 'xtick', yr_span);
% xlabel('Time (Year)');
% ylabel('Energy Consumption (mtce)');
% set(gcf, 'units', 'inch', 'pos', [9.3438    4.1563    3.5    2]);
% set(gca, 'pos', [0.1458    0.1927    0.7917    0.7604]);
% 
% annotation('textbox', [0.15 0.85, 0.1, 0.1], 'linestyle', 'none', 'String', province_name, 'fontsize', 10, 'fontweight', 'bold');
% if strcmp('BJ', province_name)
% text(2029.7, COL_BJ(end)/2, 'COL', 'color', 'k', 'fontsize', 7, 'horizontalalignment', 'right');
% text(2029.7, COL_BJ(end)+GAS_BJ(end)/2-7, 'GAS', 'color', 'k', 'fontsize', 7, 'horizontalalignment', 'right');
% text(2029.7, COL_BJ(end)+GAS_BJ(end)+OIL_BJ(end)/2, 'OIL', 'color', 'k', 'fontsize', 7, 'horizontalalignment', 'right');
% end
% 
% % ==============================
[ecap_t, ecap_t_id] = getgdx(gdx_filename, 'ecap_t'); % [r]x[t]=[30]x[4]; year 2007/2010/2015/2020
% BJ_ecap_t = ecap_t(strcmp(province_name, ecap_t_id{1}),:);
% 
% ecap_t_span = [2007 2010 2015 2020];
% 
% plot(ecap_t_span, BJ_ecap_t, 'x-');
% if strcmp('BJ', province_name)
% text(2012.5, mean(BJ_ecap_t(2:3))+12, 'Energy Cap', 'color', 'b', 'rotation', 3, 'fontsize', 8, 'horizontalalignment', 'center');
% end
% % file_name = ['traj_', province_name];
% % export_fig(file_name, '-w');
% 
% %% ================================================================== %%
% % welfare
% [report2, report2_id] = getgdx(gdx_filename, 'report2'); % [2]x[6]x[]x[35]
% % report2_id{1} % Wchange/HHEGYUSE
% % report2_id{2} % 2007/2010/2015/2020/2025/2030
% % report2_id{3} % c
% % report2_id{4} % r+s+CHN
% 
% wchange = squeeze(report2(1,:,:,:)); % [6]x[35]
% wchange_t_span = [2007 2010 2015 2020 2025 2030];
% 
% BJ_w = wchange(:,strcmp(province_name, ecap_t_id{1}))
% 
% figure(2); clf; hold on;
% plot(wchange_t_span, BJ_w, 'x-');
% set(gcf, 'units', 'inch', 'pos', [9.3438    4.1563    3.5    2]);
% set(gca, 'pos', [0.1458    0.1927    0.7917    0.7604]);
% set(gca, 'fontsize', 8);
% set(gca, 'xlim', [2007 2030], 'xtick', wchange_t_span);
% ylabel('Welfare Change');
% xlabel('Time (Year)');
% 
% annotation('textbox', [0.15 0.85, 0.1, 0.1], 'linestyle', 'none', 'String', province_name, 'fontsize', 10, 'fontweight', 'bold');


%% ================================================================== %%
%% energy cap in 2007
figure(10); clf; hold on;
% COL_use = squeeze(report(strcmp('COL', report_id{1}),1,1:30))';
% GAS_use = squeeze(report(strcmp('GAS', report_id{1}),1,1:30))';
% OIL_use = squeeze(report(strcmp('OIL', report_id{1}),1,1:30))';
% 
% tmp = [COL_use;
%        GAS_use;
%        OIL_use];
% ha = bar(1:30, tmp', 'stack', 'edge', 'none');
% set(ha(1), 'facec', [0.7 0 0]);
% set(ha(2), 'facec', [1 0.65 0]);
% set(ha(3), 'facec', [1 0.6 0.6]);

[ecap_tmp, ~] = getgdx(gdx_filename, 'ecap_tmp');
ha = bar(1:30, ecap_tmp, 'stack', 'edge', 'none', 'facec', [0.6 0.6 0.6]);

zz = squeeze(report(strcmp('egycons', report_id{1}),1,1:30));
bar(1:30, zz, 0.5, 'edge', 'none', 'facec', 'r');

set(gca, 'fontsize', 8);
set(gca, 'tickdir', 'out');
set(gca, 'layer', 'top');
xlim([0 31]);
set(gca, 'xtick', 1:30, 'xticklabel', r);

ecap_2007 = ecap_t(:,1);
bar(1:30, ecap_2007, 'edge', 'b', 'facec', 'none');

