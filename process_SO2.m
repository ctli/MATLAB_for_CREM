clear all
close all
clc
format compact

r = {'BJ','TJ','HE','SX','SD','NM','LN','JL','HL','SH','JS','ZJ','AH','FJ','HA','HB','HN','JX','SC','CQ','SN','GS','QH','NX','XJ','GD','GX','YN','GZ','HI'};

yr = [2007, 2010:5:2030];

% Yr 2010, Tg (tera gram)
zhao_data = [
% SO2     NOx
0.187	0.309
0.351	0.592
1.942	1.996
1.66	1.237
3.199	2.589
1.304	1.244
1.188	1.334
0.356	0.583
0.309	0.759
0.691	0.911
1.341	1.877
0.909	1.324
0.803	1.177
0.486	0.761
1.402	1.866
1.24	1.102
1.036	0.956
0.633	0.574
1.813	1.074
1.148	0.485
0.926	0.699
0.409	0.378
0.036	0.093
0.303	0.276
0.46	0.455
1.112	1.824
0.738	0.707
0.616	0.73
1.075	0.751
0.038	0.127
];

yr_geng = 2004:2012;
SO2_geng = [29.5 33.5 34.3 32.6 31.3 28.9 28.5 29.8 29.7];
NOX_geng = [18.5, 21.2, 23.1 25 26 26.5 28.5 31 31.5];


%% Baseline
gdx_filename = 'result_default.gdx';
[urban, urban_id] = getgdx(gdx_filename, 'urban'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[11]x[6]

SO2 = squeeze(urban(strcmp('SO2', urban_id{1}),:,:,:)); % [30]x[11]x[6]
SO2_r = squeeze(sum(SO2,2)); % [30]x[6]
SO2_n = sum(SO2_r); % [1x6]

NOX = squeeze(urban(strcmp('NOX', urban_id{1}),:,:,:)); % [30]x[11]x[6]
NOX_r = squeeze(sum(NOX,2)); % [30]x[6]
NOX_n = sum(NOX_r); % [1x6]

SO2_r_baseline = SO2_r;
NOX_r_baseline = NOX_r;

% ==============================
figure(1); clf;
bar(yr_geng, SO2_geng, 'facec', 'b', 'edge', 'none'); hold on;
plot(yr, SO2_n, 'x-');
ylabel('SO2 (Tg/yr)');
set(gcf, 'unit', 'inch', 'pos', [0.3646    5.9167    4.0000    3.0000]);

figure(2); clf;
bar(yr_geng, NOX_geng, 'facec', 'b', 'edge', 'none'); hold on;
plot(yr, NOX_n, 'x-');
ylabel('NOx (Tg/yr)');
set(gcf, 'unit', 'inch', 'pos', [0.3646    1.9167    4.0000    3.0000]);


%% w/ exogenous pollution abetment
gdx_filename = 'result_urban_exo.gdx';
[urban, urban_id] = getgdx(gdx_filename, 'urban'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[11]x[6]

SO2 = squeeze(urban(strcmp('SO2', urban_id{1}),:,:,:)); % [30]x[11]x[6]
SO2_r = squeeze(sum(SO2,2)); % [30]x[6]
SO2_n = sum(SO2_r); % [1x6]

NOX = squeeze(urban(strcmp('NOX', urban_id{1}),:,:,:)); % [30]x[11]x[6]
NOX_r = squeeze(sum(NOX,2)); % [30]x[6]
NOX_n = sum(NOX_r); % [1x6]

% ==============================
figure(1); hold on;
plot(yr, SO2_n, 'r^-', 'markersize', 5);
set(gca, 'fontsize', 8);
ylabel('SO2 (Tg/yr)');
legend('Baseline', 'w/ Exogenous Pollution Abetment', 2);
ylim([20 160]);

plot(2010, sum(zhao_data(:,1)), 'og', 'linewidth', 1, 'markersize', 5); % Zhao (Atmospheric Chemestry and Physics, 2013)
text(2010.7, sum(zhao_data(:,1)), 'Zhao (2013)', 'fontsize', 8);
% my_gridline; export_fig SO2 -painters;

figure(2); hold on;
plot(yr, NOX_n, 'r^-', 'markersize', 5);
set(gca, 'fontsize', 8);
ylabel('NOx (Tg/yr)');
legend('Baseline', 'w/ Exogenous Pollution Abetment', 2);
ylim([20 160]);

plot(2010, sum(zhao_data(:,2)), 'og', 'linewidth', 1, 'markersize', 5); % Zhao (Atmospheric Chemestry and Physics, 2013)
text(2010.7, sum(zhao_data(:,2)), 'Zhao (2013)', 'fontsize', 8);
% my_gridline; export_fig NOx -painters;


%% baseline vs. exogenous pollution abetment
figure(11); clf; % only 2010
hb = bar(1:30, [SO2_r_baseline(:,2), SO2_r(:,2)], 'hist');
set(hb(1), 'facec', 'b', 'edgecolor', 'none');
set(hb(2), 'facec', 'r', 'edgecolor', 'none');
set(gca, 'fontsize', 7);
ylabel('SO2 in 2010 (Tg/yr)', 'fontsize', 10, 'fontweight', 'bold');
xlim([0.4 30.6]);
ylim([0 6]);
set(gca, 'xtick', 1:30, 'xticklabel', r);
set(gca, 'tickdir', 'out');
set(gca, 'ticklength', [0.005 0.005]);
set(gcf, 'units', 'inch', 'pos', [4.6250    6.3542    9.35    2]);
set(gca, 'pos', [0.0569    0.1023    0.9263    0.7883]);
for rn = 1:30
    text(rn-0.15, SO2_r_baseline(rn,2)+0.05, num2str(SO2_r_baseline(rn,2), '%1.3f'), 'fontsize', 6, 'rotation', 90, 'color', 'b');
    text(rn+0.15, SO2_r(rn,2)+0.05, num2str(SO2_r(rn,2), '%1.3f'), 'fontsize', 6, 'rotation', 90, 'color', 'r');
end

hold on;
plot((1:30)+0.15, zhao_data(:,1), 'kx-');

%% 
[urban, urban_id] = getgdx('result_default.gdx', 'urban'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[11]x[6]
SO2 = squeeze(urban(strcmp('SO2', urban_id{1}),:,:,:)); % [30]x[11]x[6]
SO2_r = squeeze(sum(SO2,2)); % [30]x[6]
SO2_n = sum(SO2_r); % [1x6]

NOX = squeeze(urban(strcmp('NOX', urban_id{1}),:,:,:)); % [30]x[11]x[6]
NOX_r = squeeze(sum(NOX,2)); % [30]x[6]
NOX_n = sum(NOX_r); % [1x6]

SO2_ele = squeeze(SO2(:,strcmp('ELE',urban_id{3}),:)); % [30]x[6]
SO2_ele_n = sum(SO2_ele);
SO2_g_n = squeeze(sum(SO2));


% export_fig SO2_2010 -painters;

% figure(12); clf; % only 2030
% hb = bar(1:30, [SO2_r_baseline(:,end), SO2_r(:,end)], 'hist');
% set(hb(1), 'facec', 'b', 'edgecolor', 'none');
% set(hb(2), 'facec', 'r', 'edgecolor', 'none');
% set(gca, 'fontsize', 7);
% ylabel('SO2 in 2030 (Tg/yr)', 'fontsize', 10, 'fontweight', 'bold');
% xlim([0.4 30.6]);
% ylim([0 20]);
% set(gca, 'xtick', 1:30, 'xticklabel', r);
% set(gca, 'tickdir', 'out');
% set(gca, 'ticklength', [0.005 0.005]);
% set(gcf, 'units', 'inch', 'pos', [14.1875    6.3542    9.35    2]);
% set(gca, 'pos', [0.0569    0.1023    0.9263    0.7883]);
% for rn = 1:30
%     text(rn-0.15, SO2_r_baseline(rn,end)+0.05, num2str(SO2_r_baseline(rn,end), '%1.3f'), 'fontsize', 6, 'rotation', 90, 'color', 'b');
%     text(rn+0.15, SO2_r(rn,end)+0.05, num2str(SO2_r(rn,end), '%1.3f'), 'fontsize', 6, 'rotation', 90, 'color', 'r');
% end
% % export_fig SO2_2030 -painters;

figure(21); clf; % only 2010
hb = bar(1:30, [NOX_r_baseline(:,2), NOX_r(:,2)], 'hist');
set(hb(1), 'facec', 'b', 'edgecolor', 'none');
set(hb(2), 'facec', 'r', 'edgecolor', 'none');
set(gca, 'fontsize', 7);
ylabel('NOx in 2010 (Tg/yr)', 'fontsize', 10, 'fontweight', 'bold');
xlim([0.4 30.6]);
ylim([0 6]);
set(gca, 'xtick', 1:30, 'xticklabel', r);
set(gca, 'tickdir', 'out');
set(gca, 'ticklength', [0.005 0.005]);
set(gcf, 'units', 'inch', 'pos', [4.6250    2.3750    9.35    2]);
set(gca, 'pos', [0.0569    0.1023    0.9263    0.7883]);
for rn = 1:30
    text(rn-0.15, NOX_r_baseline(rn,2)+0.05, num2str(NOX_r_baseline(rn,2), '%1.3f'), 'fontsize', 6, 'rotation', 90, 'color', 'b');
    text(rn+0.15, NOX_r(rn,2)+0.05, num2str(NOX_r(rn,2), '%1.3f'), 'fontsize', 6, 'rotation', 90, 'color', 'r');
end
hold on;
plot((1:30)+0.15, zhao_data(:,2), 'kx-');

% export_fig NOX_2010 -painters;

% figure(22); clf; % only 2030
% hb = bar(1:30, [NOX_r_baseline(:,end), NOX_r(:,end)], 'hist');
% set(hb(1), 'facec', 'b', 'edgecolor', 'none');
% set(hb(2), 'facec', 'r', 'edgecolor', 'none');
% set(gca, 'fontsize', 7);
% ylabel('NOx in 2030 (Tg/yr)', 'fontsize', 10, 'fontweight', 'bold');
% xlim([0.4 30.6]);
% ylim([0 20]);
% set(gca, 'xtick', 1:30, 'xticklabel', r);
% set(gca, 'tickdir', 'out');
% set(gca, 'ticklength', [0.005 0.005]);
% set(gcf, 'units', 'inch', 'pos', [14.1875    2.3750    9.35    2]);
% set(gca, 'pos', [0.0569    0.1023    0.9263    0.7883]);
% for rn = 1:30
%     text(rn-0.15, NOX_r_baseline(rn,end)+0.05, num2str(NOX_r_baseline(rn,end), '%1.3f'), 'fontsize', 6, 'rotation', 90, 'color', 'b');
%     text(rn+0.15, NOX_r(rn,end)+0.05, num2str(NOX_r(rn,end), '%1.3f'), 'fontsize', 6, 'rotation', 90, 'color', 'r');
% end
% % export_fig NOX_2030 -painters;

