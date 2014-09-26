clear all
close all
clc
format compact

yr = [2007, 2010:5:2030];

r = {'BJ','TJ','HE','SX','SD','NM','LN','JL','HL','SH','JS','ZJ','AH','FJ','HA','HB','HN','JX','SC','CQ','SN','GS','QH','NX','XJ','GD','GX','YN','GZ','HI'};


%% No policy
gdx_filename = 'result_urban_exo.gdx';
[report2, report2_id] = getgdx(gdx_filename, 'report2');
% report2_id{1} %Wchange/welfare/CO2emis
% report2_id{2} %2007/2010/2015/2020/2025/2030
% report2_id{3} %AGR/COL/...
% report2_id{4} %r+s+CHN
co2 = squeeze(report2(strcmp('CO2emis', report2_id{1}),:,1:13,1:30));
co2_r = squeeze(sum(co2,2));
co2_n = squeeze(sum(co2_r,2));

[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);

figure(15); clf;
plot(yr, GDP_n, 'r^-', 'markersize', 5);
set(gca, 'fontsize', 8);
ylabel('GDP (Billion US dollor in 2007 value)', 'Fontsize', 9);

figure(14); clf;
plot(yr, co2_n/1e3, 'r^-', 'markersize', 5);
set(gca, 'fontsize', 8);
ylabel('CO2 (Billion tons)', 'Fontsize', 9);
set(gcf, 'unit', 'inch', 'pos', [0.25+4.15*3    0.7917    4.0000    3.0000]);
% for yn = 3:length(yr)
%     text(yr(yn), co2_n(yn)/1e3+0.5, num2str(co2_n(yn)/1e3, '%2.1f'), 'fontsize', 8, 'horizontalalignment', 'center');
% end

%% policy scenario: national energy intensity
gdx_filename = 'result_egyint_n.gdx';
[report2, report2_id] = getgdx(gdx_filename, 'report2');
co2 = squeeze(report2(strcmp('CO2emis', report2_id{1}),:,1:13,1:30));
co2_r = squeeze(sum(co2,2));
co2_n = squeeze(sum(co2_r,2));

[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);

figure(15); hold on;
plot(yr, GDP_n, 'go-', 'markersize', 5);
set(gca, 'fontsize', 8);
ylabel('GDP (Billion US dollor in 2007 value)', 'Fontsize', 9);

figure(14); hold on;
plot(yr, co2_n/1e3, 'go-', 'markersize', 5);
% for yn = 1:length(yr)
%     text(yr(yn), co2_n(yn)/1e3+0.5, num2str(co2_n(yn)/1e3, '%2.1f'), 'fontsize', 8, 'horizontalalignment', 'center');
% end

%% policy scenario: national co2 cap
gdx_filename = 'result_ccap_n.gdx';
[report2, report2_id] = getgdx(gdx_filename, 'report2');
co2 = squeeze(report2(strcmp('CO2emis', report2_id{1}),:,1:13,1:30));
co2_r = squeeze(sum(co2,2));
co2_n = squeeze(sum(co2_r,2));

[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);

% figure(15); hold on;
% plot(yr, GDP_n, 'mx-', 'markersize', 5);
% set(gca, 'fontsize', 8);
% ylabel('GDP (Billion US dollor in 2007 value)', 'Fontsize', 9);

figure(14); hold on;
plot(yr(1:length(co2_n)), co2_n/1e3, 'mx-', 'markersize', 5);
legend('No Policy', 'w/ Policy', 'w/ Carbon Price', 2);
% for yn = 1:length(yr)
%     text(yr(yn), co2_n(yn)/1e3+0.5, num2str(co2_n(yn)/1e3, '%2.1f'), 'fontsize', 8, 'horizontalalignment', 'center');
% end

% my_gridline; export_fig CO2;


