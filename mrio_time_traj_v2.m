clear all
close all
clc
format compact

% gdx_filename = 'result_default.gdx'; title_name = 'No Policy'; file_name = 'egycons';
gdx_filename = 'result_egycap_multiyear.gdx'; title_name = 'with Energy Caps in JJJ'; file_name = 'egycons_egycap';

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
[report, report_id] = getgdx(gdx_filename, 'report'); % [7]x[6]x[35]
% report_id{1}; % COL/GAS/OIL/GDP/egycons/GDPperCapita/consCO2emis
% report_id{2}; % 2007/2010/2015/2020/2025/2030
% report_id{3}; % r+s+CHN

% egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); % 2007~2030
egycons = squeeze(report(strcmp('egycons', report_id{1}),1:4,1:30)); % 2007~2020

figure(1); clf;
% x = repmat([2007 2010 2015 2020 2025 2030],30,1);
x = repmat([2007 2010 2015 2020],30,1);
y = 1:30;
z = (egycons');
options.barwidth = 0.001;
options.ColormapWall = 'jet';
options.Edgecolor = 'none';
options.LegendSym = 'none';
[ha,opt] = area3(x,y,z, options);
set(gca, 'ytick', 1:30, 'yticklabel', (r));

% set(ha(1), 'edgecolor', [0.5 0.5 0.5], 'linewidth', 2);

% ==============================
[ecap_t, ecap_t_id] = getgdx(gdx_filename, 'ecap_t'); % [r]x[t]=[30]x[4]; year 2007/2010/2015/2020

hold on;
for rn = 1:30
h3 = plot3([2007 2010 2015 2020], ones(1,4)*rn-0.01, ecap_t(rn,:)', 'k-x', 'markersize', 4);
end

set(gcf, 'units', 'inch', 'pos', [0.7292    5.5938    9.35    2.45]);
set(gca, 'pos', [0.0635    0.0972    0.9064    0.8007]);
set(gca, 'fontsize', 8);
set(gca, 'ydir', 'reverse');
set(gca, 'ticklength', [0.01 0.01]);
grid on
view(-95,8);
zlabel('Energy Consumption (mtce)');
zlim([0 600]);
ylim([0.4 30.6]);
xlim([2007 2020]);
set(gca, 'xtick', [2007 2010 2015 2020]);
title(title_name, 'fontsize', 10, 'fontweight', 'bold');

legend(h3, 'Energy Cap', 'location', 'NorthEast');

% export_fig(file_name, '-w', '-painters');


%% ================================================================== %%
[report2, report2_id] = getgdx('result_default.gdx', 'report2');
% report2_id{1} % Wchange/HHEGYUSE
% report2_id{2} % 2007
% report2_id{3} % Sector c
% report2_id{4} % r+s+CHN

wchange = squeeze(report2(1,1:4,1,1:30));

figure(2); clf;
x = repmat([2007 2010 2015 2020],30,1);
y = 1:30;
z = (wchange');
options.barwidth = 0.001;
options.ColormapWall = 'jet';
options.Edgecolor = 'none';
options.LegendSym = 'none';
[ha,opt] = area3(x,y,z, options);


%% ==============================
[welfare, welfare_id] = getgdx('result_default.gdx', 'welfare');
welfare0 = squeeze(welfare(1,1:30,1:4)); % [30x4]

[welfare, ~] = getgdx('result_egycap_multiyear.gdx', 'welfare');
welfare = squeeze(welfare(1,1:30,1:4)); % [30x4]

welfare_chg = (welfare-welfare0)./welfare0*100;

figure(3); clf;
x = repmat([2007 2010 2015 2020],30,1);
y = 1:30;
z = (welfare_chg);
options.barwidth = 0.001;
options.ColormapWall = 'jet';
options.Edgecolor = 'none';
options.LegendSym = 'none';
options.FacealphaWall = 1;
options.FacealphaFloor = 1;
options.FacealphaRoof = 1;
[~,opt] = area3(x,y,z, options)
alpha(0.5)

set(gcf, 'units', 'inch', 'pos', [0.7292    1.6042    9.35    2.45]);
set(gca, 'pos', [0.0635    0.0972    0.9064    0.8254]);
set(gca, 'fontsize', 8);
zlim([-8 1]);
ylim([0.4 30.6]);
xlim([2007 2020]);
zlabel('Welfare Change (%)');
set(gca, 'xtick', [2007 2010 2015 2020]);
set(gca, 'ytick', 1:30, 'yticklabel', (r));
set(gca, 'ydir', 'reverse');
set(gca, 'ticklength', [0.01 0.01]);
grid on
view(-95,10);

plot3([2007 2007],[0.4 30.6],[0 0], 'k');
plot3([2020 2020],[0.4 30.6],[0 0], 'k');
plot3([2007 2020],[0.4 0.4],[0 0], 'k');
plot3([2007 2020],[30.6 30.6],[0 0], 'k');

for rn = 1:30
text(2020, rn, 0.3, r(rn), 'fontsize', 8, 'horizontalalignment', 'center');
end

% export_fig welfare_chg_multiyear -w


