clear all
close all
clc
format compact

r = {'BJ','TJ','HE','SX','SD','NM','LN','JL','HL','SH','JS','ZJ','AH','FJ','HA','HB','HN','JX','SC','CQ','SN','GS','QH','NX','XJ','GD','GX','YN','GZ','HI'};
yr = [2007,2010,2015,2020,2025,2030];


%% CO2
figure(1); clf; hold on; box on;

gdx_filename = 'result_urban_exo.gdx';
co2_chk = getgdx(gdx_filename, 'co2_chk');
co2_chk_n = sum(co2_chk);
plot(yr, co2_chk_n/1e3, '^-', 'markersize', 7, 'color', [0.5 0.5 0.5], 'linewidth', 1);

% ==========
gdx_filename = 'result_egyint_n_old.gdx';
co2_chk = getgdx(gdx_filename, 'co2_chk');
co2_chk_n = sum(co2_chk);
plot(yr, co2_chk_n/1e3, 'o-', 'color', [0 0.8 0], 'markersize', 7, 'linewidth', 1);

% ==========
gdx_filename = 'result_egyint_n.gdx';
co2_chk = getgdx(gdx_filename, 'co2_chk');
co2_chk_n = sum(co2_chk);
plot(yr, co2_chk_n/1e3, 's-', 'color', 'r', 'markersize', 7, 'linewidth', 1);

% ==========
gdx_filename = 'result_ccap_r.gdx';
co2_chk = getgdx(gdx_filename, 'co2_chk');
co2_chk_n = sum(co2_chk);
plot(yr, co2_chk_n/1e3, 'x-', 'color', 'b', 'markersize', 7, 'linewidth', 1);

legend('No Policy', 'Action Plan', '12th FYP' ,'More Stringent Scenario', 2);
set(legend, 'fontsize', 9);
set(gca, 'fontsize', 10);
ylabel('CO2 (Billion tons)', 'Fontsize', 12, 'fontweight', 'bold');
set(gcf, 'unit', 'inch', 'pos', [5.3958    4.7604    4.0000    3.0000]);
ylim([0 20]);
set(gca, 'ytick', 0:5:20);

ratio = co2_chk_n(2:end)./co2_chk_n(1:end-1);
% for yn = 2:length(yr), text(yr(yn), co2_chk_n(yn)/1e3-1, num2str(ratio(yn-1), '%2.2f'), 'fontsize', 8, 'color', 'b', 'horizontalalignment', 'center'); end

my_gridline;


%% CO2 intensity
figure(2); clf; hold on; box on;

gdx_filename = 'result_urban_exo.gdx';
co2_chk = getgdx(gdx_filename, 'co2_chk');
co2_chk_n = sum(co2_chk);
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
co2_int = co2_chk_n'./GDP_n;

plot(yr, co2_int, '^-', 'markersize', 7, 'color', [0.5 0.5 0.5], 'linewidth', 1);

% ==============================
gdx_filename = 'result_egyint_n_old.gdx';
co2_chk = getgdx(gdx_filename, 'co2_chk');
co2_chk_n = sum(co2_chk);
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
co2_int = co2_chk_n'./GDP_n;
pctg = (1-co2_int(2:end)./co2_int(1:end-1))';

plot(yr, co2_int, 'o-', 'markersize', 7, 'color', [0 0.8 0], 'linewidth', 1);
% for i = 3:4, text(yr(i)+1.75, co2_int(i), [num2str(-pctg(i-1)*100, '%2.0f'), '%'], 'fontsize', 8, 'horizontalalignment', 'center'); end

% ==============================
gdx_filename = 'result_egyint_n.gdx';
co2_chk = getgdx(gdx_filename, 'co2_chk');
co2_chk_n = sum(co2_chk);
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
co2_int = co2_chk_n'./GDP_n;
pctg = (1-co2_int(2:end)./co2_int(1:end-1))';

plot(yr, co2_int, 'rs-', 'markersize', 7, 'linewidth', 1);
% for i = 3:4, text(yr(i), co2_int(i)-0.075, [num2str(-pctg(i-1)*100, '%2.0f'), '%'], 'fontsize', 8, 'horizontalalignment', 'center'); end

% ==============================
gdx_filename = 'result_ccap_r.gdx';
co2_chk = getgdx(gdx_filename, 'co2_chk');
co2_chk_n = sum(co2_chk);
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
co2_int = co2_chk_n'./GDP_n;
pctg = (1-co2_int(2:end)./co2_int(1:end-1))';

plot(yr, co2_int, 'bx-', 'markersize', 7, 'linewidth', 1);
% for i = 3:4, text(yr(i), co2_int(i)-0.075, [num2str(-pctg(i-1)*100, '%2.0f'), '%'], 'fontsize', 8, 'horizontalalignment', 'center'); end

ylim([0 1.8]);
set(gca, 'fontsize', 10);
ylabel('CO2 Intensity', 'Fontsize', 12, 'fontweight', 'bold');
set(gcf, 'unit', 'inch', 'pos', [4.3229    1.8229    4.0000    3.0000]);
my_gridline;


%% Energy intensity
figure(3); clf; hold on; box on;

gdx_filename = 'result_urban_exo.gdx';
egy_intensity_n = getgdx(gdx_filename, 'egy_intensity_n');
plot(yr, egy_intensity_n, '^-', 'color', [0.5 0.5 0.5], 'markersize', 7, 'linewidth', 1);

gdx_filename = 'result_egyint_n_old.gdx';
egy_intensity_n = getgdx(gdx_filename, 'egy_intensity_n');
pctg = (1-egy_intensity_n(2:end)./egy_intensity_n(1:end-1))';
plot(yr, egy_intensity_n, 'o-', 'color', [0 0.8 0], 'markersize', 7, 'linewidth', 1);
for i = 3:4, text(yr(i)+1.75, egy_intensity_n(i), '-20%', 'fontsize', 8, 'horizontalalignment', 'center', 'color', [0 0.8 0]); end

gdx_filename = 'result_egyint_n.gdx';
egy_intensity_n = getgdx(gdx_filename, 'egy_intensity_n');
pctg = (1-egy_intensity_n(2:end)./egy_intensity_n(1:end-1))';
plot(yr, egy_intensity_n, 's-', 'color', [1 0 0], 'markersize', 7, 'linewidth', 1);
for i = 3:4, text(yr(i)+1.75, egy_intensity_n(i), [num2str(-pctg(i-1)*100, '%2.0f'), '%'], 'fontsize', 8, 'horizontalalignment', 'center', 'color', [1 0 0]); end

gdx_filename = 'result_ccap_r.gdx';
egy_intensity_n = getgdx(gdx_filename, 'egy_intensity_n');
pctg = (1-egy_intensity_n(2:end)./egy_intensity_n(1:end-1))';
plot(yr, egy_intensity_n, 'x-', 'color', 'b', 'markersize', 7, 'linewidth', 1);
for i = 3:4, text(yr(i)+1.75, egy_intensity_n(i)-0.01, [num2str(-pctg(i-1)*100, '%2.0f'), '%'], 'fontsize', 8, 'horizontalalignment', 'center', 'color', 'b'); end

ylim([0 0.8]);
set(gcf, 'unit', 'inch', 'pos', [6.8958    4.7604    4.0000    3.0000]);
set(gca, 'fontsize', 10);
ylabel('National Energy Intensity', 'fontsize', 12, 'fontweight', 'bold');
my_gridline;


%% Coal consumption
figure(4); clf; hold on; box on;

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

[egyreport2, egyreport2_id] = getgdx('result_ccap_r', 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
plot(yr, col_consumption_n, 'xb-', 'markersize', 7, 'linewidth', 1);

ylim([0 6000]);
set(gca, 'fontsize', 10);
ylabel('National Coal Consumption (mtce)', 'fontsize', 12, 'fontweight', 'bold');
set(gcf, 'unit', 'inch', 'pos', [29.8958    4.7604    4.0000    3.0000]);
my_gridline;


%% SO2
figure(5); clf; hold on; box on;

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
pctg = 1-(urban_CHN(i,2:end)./urban_CHN(i,1:end-1));
for j = 3:4, text(yr(j)+1.75, urban_CHN(i,j), [num2str(-pctg(j)*100, '%2.0f'), '%'], 'fontsize', 8, 'horizontalalignment', 'center', 'color', [1 0 0]); end

gdx_filename = 'result_ccap_r.gdx';
[urban, urban_id] = getgdx(gdx_filename, 'urban');
urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
i = 8;
urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
urban_CHN(i,:) = sum(urban_extract);
plot(yr, urban_CHN(i,:), 'x-', 'color', 'b', 'markersize', 7, 'linewidth', 1);

ylim([0 70]);
set(gca, 'fontsize', 10);
set(gcf, 'unit', 'inch', 'pos', [7.8958    0.7200    4.0000    3.0000]);
ylabel('SO2 (Tg)', 'fontsize', 12, 'fontweight', 'bold');
title(urban_id{1}(i), 'fontsize', 12, 'fontweight', 'bold');

my_gridline;


