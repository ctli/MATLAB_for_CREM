clear all
close all
clc
format compact

r = {'BJ','TJ','HE','SX','SD','NM','LN','JL','HL','SH','JS','ZJ','AH','FJ','HA','HB','HN','JX','SC','CQ','SN','GS','QH','NX','XJ','GD','GX','YN','GZ','HI'};


%% Energy intensity
figure(1); clf; hold on; box on;

yr = [2007,2010,2015,2020,2025,2030];
gdx_filename = 'result_urban_exo.gdx';
egy_intensity_n = getgdx(gdx_filename, 'egy_intensity_n');
plot(yr, egy_intensity_n, '^-', 'color', [0.5 0.5 0.5], 'markersize', 7, 'linewidth', 1);

gdx_filename = 'result_egyint_n_old.gdx';
egy_intensity_n = getgdx(gdx_filename, 'egy_intensity_n');
plot(yr, egy_intensity_n, 'o-', 'color', [0 0.8 0], 'markersize', 7, 'linewidth', 1);

gdx_filename = 'result_egyint_n.gdx';
egy_intensity_n = getgdx(gdx_filename, 'egy_intensity_n');
plot(yr, egy_intensity_n, 's-', 'color', [1 0 0], 'markersize', 7, 'linewidth', 1);

gdx_filename = 'result_ccap_r.gdx';
yr = [2007,2010,2015];
egy_intensity_n = getgdx(gdx_filename, 'egy_intensity_n');
plot(yr, egy_intensity_n, 'x-', 'color', 'b', 'markersize', 7, 'linewidth', 1);

ylim([0 0.8]);
set(gcf, 'unit', 'inch', 'pos', [20.8958    4.7604    4.0000    3.0000]);
set(gca, 'fontsize', 10);
ylabel('National Energy Intensity');


%% CO2
figure(2); clf; hold on; box on;

yr = [2007,2010,2015,2020,2025,2030];
gdx_filename = 'result_urban_exo.gdx';
[report2, report2_id] = getgdx(gdx_filename, 'report2');
co2 = squeeze(report2(strcmp('CO2emis', report2_id{1}),:,1:13,1:30));
co2_r = squeeze(sum(co2,2));
co2_n = squeeze(sum(co2_r,2));
plot(yr, co2_n/1e3, '^-', 'markersize', 7, 'color', [0.5 0.5 0.5], 'linewidth', 1);

[report, report_id] = getgdx(gdx_filename, 'report');
co2 = squeeze(report(strcmp('consCO2emis', report_id{1}),:,1:30));
co2_n = sum(co2,2);
plot(yr, co2_n/1e3, '^:', 'markersize', 7, 'color', [0.5 0.5 0.5], 'linewidth', 1);

gdx_filename = 'result_egyint_n_old.gdx';
[report2, report2_id] = getgdx(gdx_filename, 'report2');
co2 = squeeze(report2(strcmp('CO2emis', report2_id{1}),:,1:13,1:30));
co2_r = squeeze(sum(co2,2));
co2_n = squeeze(sum(co2_r,2));
plot(yr, co2_n/1e3, 'o-', 'color', [0 0.8 0], 'markersize', 7, 'linewidth', 1);

[report, report_id] = getgdx(gdx_filename, 'report');
co2 = squeeze(report(strcmp('consCO2emis', report_id{1}),:,1:30));
co2_n = sum(co2,2);
plot(yr, co2_n/1e3, 'o:', 'color', [0 0.8 0], 'markersize', 7, 'linewidth', 1);

gdx_filename = 'result_egyint_n.gdx';
[report2, report2_id] = getgdx(gdx_filename, 'report2');
co2 = squeeze(report2(strcmp('CO2emis', report2_id{1}),:,1:13,1:30));
co2_r = squeeze(sum(co2,2));
co2_n = squeeze(sum(co2_r,2));
plot(yr, co2_n/1e3, 'o-', 'color', [1 0 0], 'markersize', 7, 'linewidth', 1);

[report, report_id] = getgdx(gdx_filename, 'report');
co2 = squeeze(report(strcmp('consCO2emis', report_id{1}),:,1:30));
co2_n = sum(co2,2);
plot(yr, co2_n/1e3, 'o:', 'color', [1 0 0], 'markersize', 7, 'linewidth', 1);

yr = [2007,2010,2015];
gdx_filename = 'result_ccap_r.gdx';
[report2, report2_id] = getgdx(gdx_filename, 'report2');
co2 = squeeze(report2(strcmp('CO2emis', report2_id{1}),:,1:13,1:30));
co2_r = squeeze(sum(co2,2));
co2_n = squeeze(sum(co2_r,2));
plot(yr, co2_n/1e3, 'x-', 'color', 'b', 'markersize', 7, 'linewidth', 1);

[report, report_id] = getgdx(gdx_filename, 'report');
co2 = squeeze(report(strcmp('consCO2emis', report_id{1}),:,1:30));
co2_n = sum(co2,2);
plot(yr, co2_n/1e3, 'x:', 'color', 'b', 'markersize', 7, 'linewidth', 1);

set(gca, 'fontsize', 10);
ylabel('CO2 (Billion tons)', 'Fontsize', 12, 'fontweight', 'bold');
set(gcf, 'unit', 'inch', 'pos', [25.3958    4.7604    4.0000    3.0000]);
ylim([0 20]);
set(gca, 'ytick', 0:5:20);

%% =========
figure(21); clf;
bar(1:30, co2', 'hist');
set(gca, 'xtick', 1:30, 'xticklabel', r);
set(gcf, 'units', 'inch', 'pos', [0.7292    3.7500    9.35    2.25]);
set(gca, 'pos', [0.0569    0.1162    0.9263    0.8421]);
xlim([0.4 30.6]);

for rn = 1:30
    text(rn+0.25, co2_r(3,rn), [' ', num2str(co2_r(3,rn), '%5.0f')], 'fontsize', 8, 'rotation', 90);
end

ccap_baseline = getgdx('result_ccap_r.gdx', 'ccap_baseline');
hold on;
hb = bar(1:30, ccap_baseline(:,1:3), 'hist');
set(hb, 'facec', 'none', 'edgecolor', 'r');

ccapr_t = getgdx('result_ccap_r.gdx', 'ccapr_t');
bar(1:30, ccapr_t, 'facec', 'none', 'edge', 'b');


%% Coal consumption
figure(3); clf; hold on; box on;

yr = [2007,2010,2015,2020,2025,2030];
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
plot(yr, col_consumption_n, 'rs-', 'markersize', 7, 'linewidth', 1);

yr = [2007 2010 2015];
[egyreport2, egyreport2_id] = getgdx('result_ccap_r', 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
plot(yr, col_consumption_n, 'xb-', 'markersize', 7, 'linewidth', 1);

ylim([0 9000]);
set(gca, 'fontsize', 10);
ylabel('National Coal Consumption (mtce)', 'fontsize', 12, 'fontweight', 'bold');
set(gcf, 'unit', 'inch', 'pos', [29.8958    4.7604    4.0000    3.0000]);


%% SO2
figure(4); hold on; box on;

yr = [2007,2010,2015,2020,2025,2030];
gdx_filename = 'result_urban_exo.gdx';
[urban, urban_id] = getgdx(gdx_filename, 'urban');
urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
i = 8;
urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
urban_CHN(i,:) = sum(urban_extract);
plot(yr, urban_CHN(i,:), '^-', 'markersize', 7, 'color', [0.5 0.5 0.5], 'linewidth', 1);

gdx_filename = 'result_egyint_n_old.gdx';
[urban, urban_id] = getgdx(gdx_filename, 'urban');
urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
i = 8;
urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
urban_CHN(i,:) = sum(urban_extract);
plot(yr, urban_CHN(i,:), 'o-', 'color', [0 0.8 0], 'markersize', 7, 'linewidth', 1);

gdx_filename = 'result_egyint_n.gdx';
[urban, urban_id] = getgdx(gdx_filename, 'urban');
urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
i = 8;
urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
urban_CHN(i,:) = sum(urban_extract);
plot(yr, urban_CHN(i,:), 'o-', 'color', [1 0 0], 'markersize', 7, 'linewidth', 1);

yr = [2007,2010,2015];
gdx_filename = 'result_ccap_r.gdx';
[urban, urban_id] = getgdx(gdx_filename, 'urban');
urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
i = 8;
urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
urban_CHN(i,:) = sum(urban_extract);
plot(yr, urban_CHN(i,:), 'x-', 'color', 'b', 'markersize', 7, 'linewidth', 1);


set(gca, 'fontsize', 10);
ylabel('(Tg)', 'fontsize', 12, 'fontweight', 'bold');
title(urban_id{1}(i), 'fontsize', 12, 'fontweight', 'bold');

set(gcf, 'unit', 'inch', 'pos', [29.8958    0.7200    4.0000    3.0000]);



