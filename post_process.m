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
gdx_filename = 'result_ccap_r_old.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
co2 = squeeze(report(strcmp('consCO2emis', report_id{1}),:,1:30));
co2_n = sum(co2,2);
plot(yr, co2_n/1e3, 'xb-', 'markersize', 7, 'linewidth', 1);


% ==============================
yr = [2007 2010 2015 2020];
gdx_filename = 'result_ccap_r.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
co2 = squeeze(report(strcmp('consCO2emis', report_id{1}),:,1:30));
co2_n = sum(co2,2);
plot(yr, co2_n/1e3, 'xc-', 'markersize', 7, 'linewidth', 1);

set(gca, 'fontsize', 10);
ylabel('CO2 (Billion tons)', 'Fontsize', 12, 'fontweight', 'bold');
set(gcf, 'unit', 'inch', 'pos', [8.2188    0.9688    4.0000    3.0000]);
ylim([0 20]);
set(gca, 'yminortick', 'on');
set(gca, 'ytick', 0:5:20);



%% Regional CO2
figure(11); clf; hold on; box on;
gdx_filename = 'result_ccap_r.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
co2 = squeeze(report(strcmp('consCO2emis', report_id{1}),:,1:30));
hb1 = bar(1:30, co2', 0.85, 'hist');
set(hb1, 'facec', [0.3 0.65 1], 'edgec', 'none');

% Regional CO2, a different counting
gdx_filename = 'result_ccap_r_old.gdx';
co2_chk2 = getgdx(gdx_filename, 'co2_chk2');
hb2 = bar(1:30, co2_chk2, 0.4, 'hist');
set(hb2, 'facec', 'r', 'edgec', 'r');

% Regional CO2, a different counting
gdx_filename = 'result_ccap_r.gdx';
co2_chk2 = getgdx(gdx_filename, 'co2_chk2');
hb3 = bar(1:30, co2_chk2, 0.2, 'hist');
set(hb3, 'facec', 'c', 'edgec', 'c');

xlim([0.4 30.6]);
set(gca, 'xtick', 1:30, 'xticklabel', r);
set(gca, 'tickdir', 'out');
set(gca, 'ticklength', [0.005 0.005]);
set(gcf, 'units', 'inch', 'pos', [0.7292    3.7500    9.35    2.25]);
set(gca, 'pos', [0.0569    0.1162    0.9263    0.8421]);
ylabel('CO2 (Million tons)');

legend([hb1(end), hb2(end)], 'Emission of ELE is counted at sink', 'Emission of ELE is counted at source');

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
gdx_filename = 'result_ccap_r_old.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
h3 = plot(yr, GDP_n, 'x-', 'markersize', 7, 'color', 'r', 'linewidth', 1);

% ==============================
yr = [2007 2010 2015 2020];
gdx_filename = 'result_ccap_r.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
h4= plot(yr, GDP_n, 'x-', 'markersize', 7, 'color', 'm', 'linewidth', 1);

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
yr = [2007 2010 2015 2020];
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


