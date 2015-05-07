clear all
close all
clc
format compact

addpath 'c:\Program Files\GAMS\24.2';

yr = [2007,2010,2015,2020,2025,2030];

r = {'BJ','TJ','HE','SX','SD','NM','LN','JL','HL','SH','JS','ZJ','AH','FJ','HA','HB','HN','JX','SC','CQ','SN','GS','QH','NX','XJ','GD','GX','YN','GZ','HI'};
JJJ = [1,2,3]; %BJ/TJ/HE
YRD = [10,11,12,13]; %SH/JS/ZJ/AH
PRD = 26; %GD


%% No policy
gdx_filename = 'result_default.gdx';

egy_intensity_n = getgdx(gdx_filename, 'egy_intensity_n');

[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
nhw_consumption = squeeze(egyreport2(1,:,strcmp('NHW', egyreport2_id{3}),1:30))/0.12*0.356;
nhw_consumption_n = sum(nhw_consumption,2);

[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
egycons_n = sum(egycons,2);

col_share_n = col_consumption_n./egycons_n; % national coal share
nhw_share_n = nhw_consumption_n./egycons_n;

% ===========================
figure(1); clf;
plot(yr, egy_intensity_n, 'x-');
ylim([0 0.8]);
set(gcf, 'unit', 'inch', 'pos', [0.3646    5.9167    4.0000    3.0000]);
set(gca, 'fontsize', 8);
set(gca, 'xminortick', 'on', 'yminortick', 'on');
ylabel('National Energy Intensity');

% ==========
figure(2); clf;
plot(yr, col_share_n, 'x-');
ylim([0 0.8]);
set(gcf, 'unit', 'inch', 'pos', [4.5833    5.9167    4.0000    3.0000]);
set(gca, 'fontsize', 8);
set(gca, 'xminortick', 'on', 'yminortick', 'on');
ylabel('Coal Share');

line([2005 2030], [1 1]*0.65, 'linestyle', ':', 'color', [0.2 0.2 0.2]);
text(2018, 0.65, {'Action Plan Target:', 'Coal Share below 65% by 2017'}, 'fontsize', 7, 'color', [0.4 0.4 0.4]);

% ==========
figure(3); clf;
plot(yr, nhw_share_n, 'x-', 'markersize', 5);
ylim([0.0 0.8]);
set(gcf, 'unit', 'inch', 'pos', [8.7604    5.9167    4.0000    3.0000]);
set(gca, 'fontsize', 8);
set(gca, 'xminortick', 'on', 'yminortick', 'on');
ylabel('Non-Fossil Fuel (NHW) Share');

line([2005 2030], [1 1]*0.13, 'linestyle', ':', 'color', [0.2 0.2 0.2]);
text(2005.7, 0.17, {'Action Plan Target:', 'Non-Fossil Fuel Share at 13% by 2017'}, 'fontsize', 7, 'color', [0.4 0.4 0.4]);

% ==========
figure(4); clf;
plot(yr, GDP_n, 'x-');
ylim([2000 16000]);
set(gcf, 'unit', 'inch', 'pos', [0.3646    1.9479    4.0000    3.0000]);
set(gca, 'fontsize', 8);
set(gca, 'xminortick', 'on', 'yminortick', 'on');
ylabel('GDP (Billion USD in 2007)');

% ==========
figure(5); clf;
bar(1:30, col_consumption(end,:), 'facec', [70 126 255]/255, 'edgecolor', 'none');
set(gca, 'fontsize', 7);
xlim([0.4 30.6]);
ylim([0 600]);
set(gca, 'xtick', 1:30, 'xticklabel', r);
set(gca, 'tickdir', 'out');
set(gca, 'ticklength', [0.005 0.005]);
ylabel('Coal Consumption in 2030 (mtce)');
text(12, 550, ['total = ', num2str(sum(col_consumption(end,:)), '%4.0f'), 'mt'], 'color', 'b');

set(gcf, 'units', 'inch', 'pos', [4.7708    2.3229    9.3438    2.0000]);
set(gca, 'pos', [0.0569    0.1023    0.9263    0.7883]);


%% policy scenario: national energy intensity
gdx_filename = 'result_egyint_n.gdx';

egy_intensity_n = getgdx(gdx_filename, 'egy_intensity_n');

[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
nhw_consumption = squeeze(egyreport2(1,:,strcmp('NHW', egyreport2_id{3}),1:30))/0.12*0.356;
nhw_consumption_n = sum(nhw_consumption,2);

[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
egycons_n = sum(egycons,2);

col_share_n = col_consumption_n./egycons_n;
nhw_share_n = nhw_consumption_n./egycons_n;

% ===========================
figure(1); hold on;
plot(yr, egy_intensity_n, 'r^-', 'markersize', 5);
legend('No Policy', 'w/ National Energy Intensity Target', 3);

% ==========
figure(2); hold on;
plot(yr, col_share_n, 'r^-', 'markersize', 5);

% ==========
figure(3); hold on;
plot(yr, nhw_share_n, 'r^-', 'markersize', 5);

% ==========
figure(4); hold on;
plot(yr, GDP_n, 'r^-', 'markersize', 5);

% ==========
figure(5); hold on;
bar(1:30, col_consumption(end,:), 0.55, 'facec', [1 0.5 0.5], 'edgecolor', 'none');
legend('No Policy', 'w/ National Energy Intensity Target',2, 'orientation', 'horizontal');

text(12, 500, ['total = ', num2str(sum(col_consumption(end,:)), '%4.0f'), 'mt'], 'color', 'r');



%% regional energy intensity
figure(6); clf; hold on;
gdx_filename = 'result_urban_exo.gdx'; [report, report_id] = getgdx(gdx_filename, 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); % 2007~2020
hb0 = bar(1:30, egycons', 'hist');
set(hb0, 'facec', [0.8 0.8 0.8], 'edgecolor', 'none');

gdx_filename = 'result_egyint_n.gdx'; [report, ~] = getgdx(gdx_filename, 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); % 2007~2020
hb = bar(1:30, egycons', 'hist');
color1 = [1 1 1];
color2 = [0 0.5 0];
cc = [linspace(color1(1),color2(1),size(report,2))
      linspace(color1(2),color2(2),size(report,2))
      linspace(color1(3),color2(3),size(report,2))]';
for c = 1:size(report,2), set(hb(c), 'facec', cc(c,:)); end

set(gca, 'fontsize', 7);
xlim([0.4 30.6]);
ylim([0 600]);
set(gca, 'xtick', 1:30, 'xticklabel', r);
set(gca, 'tickdir', 'out');
set(gca, 'ticklength', [0.005 0.005]);
ylabel('Energy Consumption, 2007-2030 (mtce)');
set(gcf, 'units', 'inch', 'pos', [0.7292    6.7292    9.35    2]);
set(gca, 'pos', [0.0569    0.1023    0.9263    0.8560]);
my_gridline('y');

legend([hb, hb0(1)], [report_id{2}, 'No Policy'], 'orientation', 'horizontal');
set(legend, 'box', 'off');
