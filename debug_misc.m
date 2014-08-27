clear all
close all
clc
format compact

gdx_filename = 'result_default.gdx';

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
[report, report_id] = getgdx('result_default.gdx', 'report'); % [7]x[6]x[35]
% report_id{1} % COL/GAS/OIL/GDP/egycons/GDPperCapita/consCO2emis
% report_id{2} % 2007/2010/2015/2020/2025/2030
% report_id{3} % r+s+CHN

egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30));
figure(1); clf; hold on;
hb = bar(1:30, egycons', 'hist');
set(hb, 'edgecolor', 'none');
xlim([0.4 30.6]);
set(gca, 'fontsize', 7);
set(gca, 'xtick', 1:30);
set(gca, 'xticklabel', r);
set(gcf, 'units', 'inch', 'pos', [0.7292    1.5938    9.35    2.45]);
set(gca, 'pos', [0.0602    0.1023    0.8439    0.8144]);
color_level = cbrewer('div', 'RdYlGn', 4, 'linear');
colormap(color_level);
ylabel('Energy Consumption');

%%
ecap_t = getgdx('result_default.gdx', 'ecap_t'); % [rs]x[t] = [30]x[4]
hold on;
hb2 = bar(1:30, ecap_t, 'hist');
set(hb2, 'facec', 'none', 'edgecolor', 'k');

ecap_t = ecap_t*0.9;
hb2 = bar(1:30, ecap_t, 'hist');
set(hb2, 'facec', 'none', 'edgecolor', 'c');


%% ================================================================== %%
[egy_intensity, egy_intensity_id] = getgdx('result_default.gdx', 'egy_intensity'); % [r]x[t] = [30]x[6]
egy_intensity = egy_intensity(:,1:4);
figure(1); clf; hold on;
hb = bar(1:30, egy_intensity, 'hist');
set(hb, 'edgecolor', 'none');
xlim([0.4 30.6]);
set(gca, 'fontsize', 7);
set(gca, 'xtick', 1:30);
set(gca, 'xticklabel', r);
set(gcf, 'units', 'inch', 'pos', [0.7292    1.5938    9.35    2.45]);
set(gca, 'pos', [0.0602    0.1023    0.8439    0.8144]);
color_level = cbrewer('div', 'RdYlGn', 4, 'linear');
colormap(color_level);
ylabel('Energy Intensity');

%%


