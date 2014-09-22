clear all
close all
clc

r = {'BJ','TJ','HE','SX','SD','NM','LN','JL','HL','SH','JS','ZJ','AH','FJ','HA','HB','HN','JX','SC','CQ','SN','GS','QH','NX','XJ','GD','GX','YN','GZ','HI'};


%% data from Geng (AGU powerpoint)
% G. Geng, Q. Zhang, A. van Donkelaar, R. V. Martin, and K. He, "Time 
% series of satellite-based fine particulate matter (PM2.5) concentrations 
% over China: 2004-2012," in AGU annual meeting, 2013.

yr_geng = 2004:2012;
SO2_geng = [29.5 33.5 34.3 32.6 31.3 28.9 28.5 29.8 29.7];
NOX_geng = [18.5, 21.2, 23.1 25 26 26.5 28.5 31 31.5];

figure(1); clf;
bar(yr_geng, SO2_geng, 'facec', [6 125 255]/255, 'edge', 'none');
set(gca, 'fontsize', 8);
ylim([0 160]);
xlim([2003 2031]);
set(gca, 'xtick', [2005 2010:5:2030]);
set(gca, 'tickdir', 'out');
title('SO2', 'fontsize', 10);
ylabel('Tg');
set(gcf, 'unit', 'inch', 'pos', [0.3646    5.9167    4.0000    3.0000]);

figure(2); clf;
bar(yr_geng, NOX_geng, 'facec', [6 125 255]/255, 'edge', 'none');
set(gca, 'fontsize', 8);
ylim([0 160]);
xlim([2003 2031]);
set(gca, 'xtick', [2005 2010:5:2030]);
set(gca, 'tickdir', 'out');
title('NOX', 'fontsize', 10);
ylabel('Tg');
set(gcf, 'unit', 'inch', 'pos', [4.5833    5.9167    4.0000    3.0000]);


%% Emissions in CREM
yr = [2007, 2010:5:2030];

gdx_filename = 'result_default_new.gdx';
[urban, urban_id] = getgdx(gdx_filename, 'urban'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[11]x[6]
SO2 = squeeze(urban(strcmp('SO2', urban_id{1}),:,:,:)); % [30]x[11]x[6]
SO2_r = squeeze(sum(SO2,2)); % [30]x[6]
SO2_n = sum(SO2_r); % [1x6]
NOX = squeeze(urban(strcmp('NOX', urban_id{1}),:,:,:)); % [30]x[11]x[6]
NOX_r = squeeze(sum(NOX,2)); % [30]x[6]
NOX_n = sum(NOX_r); % [1x6]

[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
[report, report_id] = getgdx(gdx_filename, 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
egycons_n = sum(egycons,2);
col_share_n = col_consumption_n./egycons_n; % national coal share

figure(1); hold on;
plot(yr, SO2_n, 'x-k');

figure(2); hold on;
plot(yr, NOX_n, 'x-k');

figure(3); clf;
plot([2007 2010:5:2030], col_consumption_n/1e3, 'kx-');
set(gca, 'fontsize', 8);
set(gcf, 'units', 'inch', 'pos', [0.3646    1.9375    4.0000    3.0000]);
ylabel('Coal Consumption (Billion ton)');

figure(4); clf;
plot([2007 2010:5:2030], col_share_n, 'kx-');
ylim([0 0.8]);
set(gcf, 'unit', 'inch', 'pos', [4.5833    1.9375    4.0000    3.0000]);
set(gca, 'fontsize', 8);
ylabel('Coal Share');


% ==============================
gdx_filename = 'result_urban_exo.gdx';
[urban, urban_id] = getgdx(gdx_filename, 'urban');
SO2 = squeeze(urban(strcmp('SO2', urban_id{1}),:,:,:));
SO2_r = squeeze(sum(SO2,2));
SO2_n = sum(SO2_r);
NOX = squeeze(urban(strcmp('NOX', urban_id{1}),:,:,:));
NOX_r = squeeze(sum(NOX,2));
NOX_n = sum(NOX_r);

[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
[report, report_id] = getgdx(gdx_filename, 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30));
egycons_n = sum(egycons,2);
col_share_n = col_consumption_n./egycons_n;

figure(1); hold on;
plot(yr, SO2_n, 'r^-', 'markersize', 5);

figure(2); hold on;
plot(yr, NOX_n, 'r^-', 'markersize', 5);

figure(3); hold on;
plot(yr, col_consumption_n/1e3, 'r^-', 'markersize', 5);

figure(4); hold on;
plot(yr, col_share_n, 'r^-', 'markersize', 5);


% ==============================
gdx_filename = 'result_egyint_n.gdx';
[urban, urban_id] = getgdx(gdx_filename, 'urban');
SO2 = squeeze(urban(strcmp('SO2', urban_id{1}),:,:,:));
SO2_r = squeeze(sum(SO2,2));
SO2_n = sum(SO2_r);
NOX = squeeze(urban(strcmp('NOX', urban_id{1}),:,:,:));
NOX_r = squeeze(sum(NOX,2));
NOX_n = sum(NOX_r);

[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
[report, report_id] = getgdx(gdx_filename, 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30));
egycons_n = sum(egycons,2);
col_share_n = col_consumption_n./egycons_n;

figure(1); hold on;
plot(yr, SO2_n, 'go-', 'markersize', 5);
legend('Emission Inventory (Gung et al.)', 'CREM Baseline (No Policy)', 'CREM w/ exponential deay EF (No Policy)', 'CREM w/ exponential deay EF & Policy', 2)
% my_gridline; export_fig SO2_compare;

figure(2); hold on;
plot(yr, NOX_n, 'go-', 'markersize', 5);
legend('Emission Inventory (Gung et al.)', 'CREM Baseline (No Policy)', 'CREM w/ exponential decay EF (No Policy)', 'CREM w/ exponential decay EF & Policy', 2)
% my_gridline; export_fig NOX_compare;

figure(3); hold on;
plot(yr, col_consumption_n/1e3, 'go-', 'markersize', 5);

figure(4); hold on;
plot(yr, col_share_n, 'go-', 'markersize', 5);


%% SO2 in ELE sector
yr = [2007, 2010:5:2030];
[urban, urban_id] = getgdx('result_default_new.gdx', 'urban');
SO2 = squeeze(urban(strcmp('SO2', urban_id{1}),:,:,:));
SO2_r = squeeze(sum(SO2,2));
SO2_n = sum(SO2_r);

SO2_ele = squeeze(SO2(:,strcmp('ELE',urban_id{3}),:)); % [30]x[6]
SO2_ele_n = sum(SO2_ele);

figure(5); clf;
bar(yr, [SO2_n-SO2_ele_n;SO2_ele_n]', 'stacked');
axis([2005 2032 0 160]);
set(gca, 'ygrid', 'on');
set(gca, 'fontsize', 8);
ylabel('SO2 (Tg)');
legend('Other Sectors', 'Electricity', 2);
set(gcf, 'unit', 'inch', 'pos', [8.8750    5.9167    4.0000    3.0000]);

oth_SO2 = SO2_n-SO2_ele_n;
oth_growth = oth_SO2(2:end)./oth_SO2(1:end-1)


%% Provincial SO2 in 2010
figure(6); clf; % only 2010
plot(1:30, SO2_r(:,2), 'kx-');

set(gca, 'fontsize', 8);
xlim([0.4 30.6]);
ylabel('SO2 in 2010 (Tg)');
set(gca, 'xtick', 1:30, 'xticklabel', r);
set(gca, 'tickdir', 'out');
set(gca, 'ticklength', [0.005 0.005]);
set(gcf, 'units', 'inch', 'pos', [8.9375    2.2188    9.35    2]);
set(gca, 'pos', [0.0569    0.1023    0.9263    0.7883]);

% Y. Zhao, J. Zhang and C. P. Nielsen, "The effects of recent control 
% policies on trends in emissions of anthropogenic atmospheric pollutants 
% and CO2 in China," Atmos. Chem. Phys., vol. 13, pp. 487-508, 2013.
data_zhao = [
% SO2     NOx, Tg (tera gram)
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

hold on;
plot(1:30, data_zhao(:,1), 'b-s', 'markersize', 4, 'markerf', 'b');
legend('CREM Baseline', 'Zhao et al.');

