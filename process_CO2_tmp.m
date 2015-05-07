clear all
close all
clc
format compact

yr = [2007, 2010:5:2030];

r = {'BJ','TJ','HE','SX','SD','NM','LN','JL','HL','SH','JS','ZJ','AH','FJ','HA','HB','HN','JX','SC','CQ','SN','GS','QH','NX','XJ','GD','GX','YN','GZ','HI'};


%% CO2
gdx_filename = 'result_urban_exo.gdx';
[report2, report2_id] = getgdx(gdx_filename, 'report2');
% report2_id{1} %Wchange/welfare/CO2emis
% report2_id{2} %2007/2010/2015/2020/2025/2030
% report2_id{3} %AGR/COL/...
% report2_id{4} %r+s+CHN
co2 = squeeze(report2(strcmp('CO2emis', report2_id{1}),:,1:13,1:30));
co2_r = squeeze(sum(co2,2));
co2_n = squeeze(sum(co2_r,2));

figure(1); clf;
h1 = plot(yr, co2_n/1e3, '^-', 'markersize', 7, 'color', [0.5 0.5 0.5], 'linewidth', 1);
set(gca, 'fontsize', 10);
ylabel('CO2 (Billion tons)', 'Fontsize', 12, 'fontweight', 'bold');
set(gcf, 'unit', 'inch', 'pos', [8.2188    0.9688    4.0000    3.0000]);
ylim([0 20]);
set(gca, 'yminortick', 'on');
set(gca, 'ytick', 0:5:20);
% for yn = 3:length(yr)
%     text(yr(yn), co2_n(yn)/1e3+0.5, num2str(co2_n(yn)/1e3, '%2.1f'), 'fontsize', 8, 'horizontalalignment', 'center');
% end

% ==============================
gdx_filename = 'result_egyint_n.gdx';
[report2, report2_id] = getgdx(gdx_filename, 'report2');
co2 = squeeze(report2(strcmp('CO2emis', report2_id{1}),:,1:13,1:30));
co2_r = squeeze(sum(co2,2));
co2_n = squeeze(sum(co2_r,2));
figure(1); hold on;
h2 = plot(yr, co2_n/1e3, 'o-', 'markersize', 7, 'color', [0 0.8 0], 'linewidth', 1);


% ==============================
gdx_filename = 'result_2030.gdx';
[report2, report2_id] = getgdx(gdx_filename, 'report2');
co2 = squeeze(report2(strcmp('CO2emis', report2_id{1}),:,1:13,1:30));
co2_r = squeeze(sum(co2,2));
co2_n = squeeze(sum(co2_r,2));
figure(1); hold on;
h2 = plot(yr, co2_n/1e3, 'x-', 'markersize', 7, 'color', [0 0.8 0], 'linewidth', 1);
