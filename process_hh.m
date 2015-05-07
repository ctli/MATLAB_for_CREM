clear all
close all
clc
format compact

r = {'BJ','TJ','HE','SX','SD','NM','LN','JL','HL','SH','JS','ZJ','AH','FJ','HA','HB','HN','JX','SC','CQ','SN','GS','QH','NX','XJ','GD','GX','YN','GZ','HI'};
yr = [2007,2010,2015,2020,2025,2030];


%% energy consumption
figure(1); clf; hold on; box on;

[report, report_id] = getgdx('result_urban_exo.gdx', 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30));
egycons_n = sum(egycons,2);
plot(yr, egycons_n, '^-', 'color', [0.5 0.5 0.5], 'markersize', 7, 'linewidth', 1);

[report, report_id] = getgdx('result_egyint_n.gdx', 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30));
egycons_n = sum(egycons,2);
plot(yr, egycons_n, 'o-', 'color', [0 0.8 0], 'markersize', 7, 'linewidth', 1);

[report, report_id] = getgdx('result_ccap_r.gdx', 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30));
egycons_n = sum(egycons,2);
plot(yr, egycons_n, 'xb-', 'markersize', 7, 'linewidth', 1);

[report, report_id] = getgdx('result_hhsplit.gdx', 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30));
egycons_n = sum(egycons,2);
plot(yr, egycons_n, 's-', 'color', 'r', 'markersize', 7, 'linewidth', 1);

[report, report_id] = getgdx('result_egyint_n_hh.gdx', 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30));
egycons_n = sum(egycons,2);
plot(yr, egycons_n, 'x-', 'color', 'r', 'markersize', 7, 'linewidth', 1);

ylim([0 9000]);
set(gca, 'fontsize', 10);
ylabel('National Energy Consumption (mtce)', 'fontsize', 12, 'fontweight', 'bold');
set(gcf, 'unit', 'inch', 'pos', [1.45    6.45    4.0000    3.0000]);

legend('No Plicy', 'Action Plan', 'Rgnl CO2 Cap', 'No Policy w/ Migration', 'Action Plan w/ Migration', 2);
set(legend, 'fontsize', 8);


%% Energy intensity
figure(2); clf; hold on; box on;

gdx_filename = 'result_urban_exo.gdx';
egy_intensity_n = getgdx(gdx_filename, 'egy_intensity_n');
plot(yr, egy_intensity_n, '^-', 'color', [0.5 0.5 0.5], 'markersize', 7, 'linewidth', 1);

gdx_filename = 'result_egyint_n.gdx';
egy_intensity_n = getgdx(gdx_filename, 'egy_intensity_n');
pctg = (1-egy_intensity_n(2:end)./egy_intensity_n(1:end-1))';
plot(yr, egy_intensity_n, 'o-', 'color', [0 0.6 0], 'markersize', 7, 'linewidth', 1);
for i = 3:6, text(yr(i)+1.75, egy_intensity_n(i), [num2str(-pctg(i-1)*100, '%2.0f'), '%'], 'fontsize', 8, 'horizontalalignment', 'center', 'color', [0 0.6 0]); end

gdx_filename = 'result_ccap_r.gdx';
egy_intensity_n = getgdx(gdx_filename, 'egy_intensity_n');
pctg = (1-egy_intensity_n(2:end)./egy_intensity_n(1:end-1))';
plot(yr, egy_intensity_n, 'x-', 'color', 'b', 'markersize', 7, 'linewidth', 1);
for i = 3:6, text(yr(i), egy_intensity_n(i)-0.04, [num2str(-pctg(i-1)*100, '%2.0f'), '%'], 'fontsize', 8, 'horizontalalignment', 'center', 'color', 'b'); end

gdx_filename = 'result_hhsplit.gdx';
egy_intensity_n = getgdx(gdx_filename, 'egy_intensity_n');
plot(yr, egy_intensity_n, 'rs-', 'markersize', 7, 'linewidth', 1);

gdx_filename = 'result_egyint_n_hh.gdx';
egy_intensity_n = getgdx(gdx_filename, 'egy_intensity_n');
plot(yr, egy_intensity_n, 'rx-', 'markersize', 7, 'linewidth', 1);

ylim([0 0.8]);
set(gcf, 'unit', 'inch', 'pos', [5.70    6.45    4.0000    3.0000]);
set(gca, 'fontsize', 10);
ylabel('Ntnl Energy Intensity (tce/1000 USD)', 'fontsize', 12, 'fontweight', 'bold');

legend('No Plicy', 'Action Plan', 'Rgnl CO2 Cap', 'No Policy w/ Migration', 'Action Plan w/ Migration', 3);
set(legend, 'fontsize', 8);


%% Coal consumption
figure(3); clf; hold on; box on;

[egyreport2, egyreport2_id] = getgdx('result_urban_exo', 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
plot(yr, col_consumption_n, '^-', 'color', [0.5 0.5 0.5], 'markersize', 7, 'linewidth', 1);

[egyreport2, egyreport2_id] = getgdx('result_egyint_n', 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
plot(yr, col_consumption_n, 'o-', 'color', [0 0.6 0], 'markersize', 7, 'linewidth', 1);

[egyreport2, egyreport2_id] = getgdx('result_ccap_r', 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
plot(yr, col_consumption_n, 'xb-', 'markersize', 7, 'linewidth', 1);
col_consumption_nn = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),31));
pctg = (1-col_consumption_nn(2:end)./col_consumption_nn(1:end-1))';
for i = 3:6, text(yr(i), col_consumption_nn(i)-250, [num2str(-pctg(i-1)*100, '%2.0f'), '%'], 'fontsize', 8, 'horizontalalignment', 'center', 'color', 'b'); end

[egyreport2, egyreport2_id] = getgdx('result_hhsplit', 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
plot(yr, col_consumption_n, 'sr-', 'markersize', 7, 'linewidth', 1);

[egyreport2, egyreport2_id] = getgdx('result_egyint_n_hh', 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
plot(yr, col_consumption_n, 'xr-', 'markersize', 7, 'linewidth', 1);

ylim([0 6000]);
set(gca, 'fontsize', 10);
ylabel('National Coal Consumption (mtce)', 'fontsize', 12, 'fontweight', 'bold');
set(gcf, 'unit', 'inch', 'pos', [10.00    6.45    4.0000    3.0000]);

legend('No Plicy', 'Action Plan', 'Rgnl CO2 Cap', 'No Policy w/ Migration', 'Action Plan w/ Migration', 2);
set(legend, 'fontsize', 8);


%% regional coal consumption
figure(4); clf;
[egyreport2, egyreport2_id] = getgdx('result_urban_exo', 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
hb0 = bar(1:30, col_consumption', 'hist');
set(hb0, 'facec', [0.8 0.8 0.8], 'edgecolor', 'none');

hold on;
[egyreport2, egyreport2_id] = getgdx('result_hhsplit.gdx', 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
hb1 = bar(1:30, col_consumption', 'hist');
for c = 1:size(report,2), set(hb1(c), 'facec', 'none'); end

legend([hb0(1), hb1(1)], 'No Policym; No Migration', 'No Policy; w/ Migration');

set(gca, 'fontsize', 7);
xlim([0.4 30.6]);
ylim([0 500]);
set(gca, 'xtick', 1:30, 'xticklabel', r);
set(gca, 'tickdir', 'out');
set(gca, 'ticklength', [0.005 0.005]);
ylabel('Coal Consumption, 2007-2013 (mtce)');
set(gcf, 'units', 'inch', 'pos', [1.4792    3.3542    9.35    2]);
set(gca, 'pos', [0.0569    0.1023    0.9263    0.7883]);


%% GDP
figure(5); clf; hold on; box on;

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
gdx_filename = 'result_ccap_r.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
h4= plot(yr, GDP_n, 'xb-', 'markersize', 7, 'linewidth', 1);

% ==============================
gdx_filename = 'result_hhsplit.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
plot(yr, GDP_n, 'sr-', 'markersize', 7, 'linewidth', 1);

gdx_filename = 'result_egyint_n_hh.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
plot(yr, GDP_n, 'xr-', 'markersize', 7, 'linewidth', 1);

ylim([0 16000]);
set(gca, 'fontsize', 10);
ylabel('GDP (Bn USD in 2007 value)', 'Fontsize', 12, 'fontweight', 'bold');
set(gcf, 'unit', 'inch', 'pos', [14.2    6.45    4.0000    3.0000]);

legend('No Plicy', 'Action Plan', 'Rgnl CO2 Cap', 'No Policy w/ Migration', 'Action Plan w/ Migration', 2);
set(legend, 'fontsize', 8);


