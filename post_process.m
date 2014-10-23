clear all
close all
clc
format compact

r = {'BJ','TJ','HE','SX','SD','NM','LN','JL','HL','SH','JS','ZJ','AH','FJ','HA','HB','HN','JX','SC','CQ','SN','GS','QH','NX','XJ','GD','GX','YN','GZ','HI'};


%% CO2
figure(1); clf; hold on; box on;

yr = [2007, 2010:5:2030];
gdx_filename = 'result_urban_exo.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
co2 = squeeze(report(strcmp('consCO2emis', report_id{1}),:,1:30));
co2_n = sum(co2,2);
plot(yr, co2_n/1e3, '^-', 'markersize', 7, 'color', [0.5 0.5 0.5], 'linewidth', 1);

% ==============================
gdx_filename = 'result_egyint_n_old.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
co2 = squeeze(report(strcmp('consCO2emis', report_id{1}),:,1:30));
co2_n = sum(co2,2);
plot(yr, co2_n/1e3, 'o-', 'markersize', 7, 'color', [0 0.8 0], 'linewidth', 1);

% ==============================
gdx_filename = 'result_egyint_n.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
co2 = squeeze(report(strcmp('consCO2emis', report_id{1}),:,1:30));
co2_n = sum(co2,2);
plot(yr, co2_n/1e3, 'o-', 'markersize', 7, 'color', 'r', 'linewidth', 1);

% ==============================
yr = [2007 2010 2015];
gdx_filename = 'result_ccap_r.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
co2 = squeeze(report(strcmp('consCO2emis', report_id{1}),:,1:30));
co2_n = sum(co2,2);
plot(yr, co2_n/1e3, 'xb-', 'markersize', 7, 'linewidth', 1);

set(gca, 'fontsize', 10);
ylabel('CO2 (Billion tons)', 'Fontsize', 12, 'fontweight', 'bold');
set(gcf, 'unit', 'inch', 'pos', [8.2188    0.9688    4.0000    3.0000]);
ylim([0 20]);
set(gca, 'yminortick', 'on');
set(gca, 'ytick', 0:5:20);


%% National coal consumption
figure(9); clf; hold on; box on;

yr = [2007, 2010:5:2030];
[egyreport2, egyreport2_id] = getgdx('result_urban_exo', 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
plot(yr, col_consumption_n, '^-', 'color', [0.5 0.5 0.5], 'markersize', 7, 'linewidth', 1);

[egyreport2, egyreport2_id] = getgdx('result_egyint_n_old', 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
plot(yr, col_consumption_n, 'o-', 'color', [0 0.8 0], 'markersize', 7, 'linewidth', 1);

[egyreport2, egyreport2_id] = getgdx('result_egyint_n', 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
plot(yr, col_consumption_n, 'o-', 'color', [1 0 0], 'markersize', 7, 'linewidth', 1);

yr = [2007 2010 2015];
[egyreport2, egyreport2_id] = getgdx('result_ccap_r', 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
plot(yr, col_consumption_n, 'xb-', 'markersize', 7, 'linewidth', 1);

ylim([0 9000]);
set(gca, 'fontsize', 10);
ylabel('National Coal Consumption (mtce)', 'fontsize', 12, 'fontweight', 'bold');
set(gcf, 'unit', 'inch', 'pos', [0.25+4.15    0.7917    4.0000    3.0000]);
legend('No Policy', 'w/ Policy', 2);

my_gridline;
% export_fig national_coal_consumption;


%% Regional CO2
figure(11); clf; hold on; box on;
gdx_filename = 'result_ccap_r.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
co2 = squeeze(report(strcmp('consCO2emis', report_id{1}),:,1:30));
hb1 = bar(1:30, co2', 'hist');
set(hb1, 'facec', [0.3 0.65 1], 'edgec', 'w');

co2_chk2 = getgdx(gdx_filename, 'co2_chk2');
hb1 = bar(1:30, co2_chk2, 0.3, 'hist');
set(hb1, 'facec', 'g', 'edgec', 'none');

xlim([0.4 30.6]);
% ylim([0 800]);
set(gca, 'layer', 'top');
set(gca, 'xtick', 1:30, 'xticklabel', r);
set(gca, 'tickdir', 'out');
set(gca, 'ticklength', [0.005 0.005]);
set(gcf, 'units', 'inch', 'pos', [0.7292    3.7500    9.35    2.25]);
set(gca, 'pos', [0.0569    0.1162    0.9263    0.8421]);
ylabel('CO2 (Million tons)');

legend([hb1(end), hb2(end)], 'Include NHW', 'Exclude NHW');

% export_fig co2_bar -painters;



%% GDP
figure(2); clf; hold on; box on;

yr = [2007, 2010:5:2030];
gdx_filename = 'result_urban_exo.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
h1  = plot(yr, GDP_n, '^-', 'markersize', 7, 'color', [0.5 0.5 0.5], 'linewidth', 1);

% ==============================
gdx_filename = 'result_egyint_n.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
h2 = plot(yr, GDP_n, 'o-', 'markersize', 7, 'color', [0 0.8 0], 'linewidth', 1);

% ==============================
yr = [2007 2010 2015];
gdx_filename = 'result_ccap_r.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
h4= plot(yr, GDP_n, 'x-', 'markersize', 7, 'color', 'b', 'linewidth', 1);

set(gca, 'fontsize', 10);
ylabel('GDP (Billion US dollor in 2007 value)', 'Fontsize', 12, 'fontweight', 'bold');
set(gcf, 'unit', 'inch', 'pos', [12.4167    0.9688    4.0000    3.0000]);
ylim([0 16000]);


%% Regional GDP
figure(21); clf; hold on; box on;

yr = [2007, 2010:5:2030];
gdx_filename = 'result_urban_exo.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
hb1 = bar(1:30, GDP', 0.85, 'hist');
set(hb1, 'facec', [0.3 0.65 1], 'edgec', 'none');

% ==============================
yr = [2007 2010 2015];
gdx_filename = 'result_ccap_r.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
hb2 = bar(1:30, GDP', 0.4, 'hist');
set(hb2, 'facec', 'r', 'edgec', 'r');

xlim([0.4 30.6]);
set(gca, 'xtick', 1:30, 'xticklabel', r);
set(gca, 'tickdir', 'out');
set(gca, 'ticklength', [0.005 0.005]);
set(gcf, 'units', 'inch', 'pos', [0.7292    3.7500    9.35    2.25]);
set(gca, 'pos', [0.0569    0.1162    0.9263    0.8421]);


