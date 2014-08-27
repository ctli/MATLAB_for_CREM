clear all
close all
clc
format compact

r = {'BJ','TJ','HE','SX','SD','NM','LN','JL','HL','SH','JS','ZJ','AH','FJ','HA','HB','HN','JX','SC','CQ','SN','GS','QH','NX','XJ','GD','GX','YN','GZ','HI'};

title_name = 'Energy Intensity in 2017 is 20% less than in 2012';
file_heading = 'combine';


%% regional energy consumption
figure(1); clf; hold on;

gdx_filename = 'result_default.gdx'; [report, report_id] = getgdx(gdx_filename, 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); % 2007~2020
hb0 = bar(1:30, egycons', 'hist');
set(hb0, 'facec', [0.8 0.8 0.8], 'edgecolor', 'none');

gdx_filename = 'result_egyint_n.gdx'; [report, ~] = getgdx(gdx_filename, 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); % 2007~2020
hb = bar(1:30, egycons', 'hist');
color1 = [1 1 1];
color2 = [0 0.2 0.8];
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
set(gca, 'pos', [0.0569    0.1023    0.9263    0.7883]);
my_gridline('y');

legend([hb, hb0(1)], [report_id{2}, 'No Policy'], 'orientation', 'horizontal');
set(legend, 'box', 'off');

% file_name = [file_heading, '_egycons'];
% cd(current_folder);


%% regional energy intensity
figure(2); clf; hold on;

gdx_filename = 'result_default.gdx'; [report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30)); % 2007~2030
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); % 2007~2020
egy_intensity = (egycons./GDP)';

hb0 = bar(1:30, egy_intensity, 'hist');
set(hb0, 'facec', [0.8 0.8 0.8], 'edgecolor', 'none');

gdx_filename = 'result_egyint_n.gdx'; [report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30)); % 2007~2030
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); % 2007~2020
egy_intensity = (egycons./GDP)';
hb = bar(1:30, egy_intensity, 'hist');
color1 = [1 1 1];
color2 = [0 0.2 0.8];
cc = [linspace(color1(1),color2(1),size(report,2))
      linspace(color1(2),color2(2),size(report,2))
      linspace(color1(3),color2(3),size(report,2))]';
for c = 1:size(report,2), set(hb(c), 'facec', cc(c,:)); end

set(gca, 'fontsize', 7);
xlim([0.4 30.6]);
set(gca, 'xtick', 1:30, 'xticklabel', r);
set(gca, 'tickdir', 'out');
set(gca, 'ticklength', [0.005 0.005]);
ylabel('Energy Intensity, 2007-2030');
set(gcf, 'units', 'inch', 'pos', [0.7292    3.7500    9.35    2]);
set(gca, 'pos', [0.0569    0.1023    0.9263    0.7883]);
my_gridline('y');

% legend([hb, hb0(1)], [report_id{2}, 'No Policy'], 'orientation', 'horizontal', 2);
% set(legend, 'box', 'off');

% file_name = [file_heading, '_egy_intensity'];
% export_fig(file_name, '-painters');


%% regional coal consumption
figure(3); clf; hold on;

gdx_filename = 'result_default.gdx'; [egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
hb0 = bar(1:30, col_consumption', 'hist');
set(hb0, 'facec', [0.8 0.8 0.8], 'edgecolor', 'none');

gdx_filename = 'result_egyint_n.gdx'; [egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
hb = bar(1:30, col_consumption', 'hist');
color1 = [1 1 1];
color2 = [0 0.2 0.8];
cc = [linspace(color1(1),color2(1),size(report,2))
      linspace(color1(2),color2(2),size(report,2))
      linspace(color1(3),color2(3),size(report,2))]';
for c = 1:size(report,2), set(hb(c), 'facec', cc(c,:)); end

set(gca, 'fontsize', 7);
xlim([0.4 30.6]);
ylim([0 500]);
set(gca, 'xtick', 1:30, 'xticklabel', r);
set(gca, 'tickdir', 'out');
set(gca, 'ticklength', [0.005 0.005]);
ylabel('Coal Consumption, 2007-2013 (mtce)');
set(gcf, 'units', 'inch', 'pos', [0.7292    0.770    9.35    2]);
set(gca, 'pos', [0.0569    0.1023    0.9263    0.7883]);
my_gridline('y');

% legend([hb, hb0(1)], [report_id{2}, 'No Policy'], 'orientation', 'horizontal');
% set(legend, 'box', 'off');

% file_name = [file_heading, '_coal_consumption'];
% export_fig(file_name, '-painters');


%% total urban emissions
figure(4); clf; hold on;

gdx_filename = 'result_default.gdx'; [turban, turban_id] = getgdx(gdx_filename, 'turban');
PM10 = squeeze(turban(strcmp('PM10',turban_id{1}),:,:));
PM25 = squeeze(turban(strcmp('PM25',turban_id{1}),:,:));
PM10_2017 = PM10(:,2)*3/5 + PM10(:,3)*2/5;
PM25_2017 = PM25(:,2)*3/5 + PM25(:,3)*2/5;
bar((1:30)-0.2, PM10_2017, 0.4, 'facec', [0.8 0.8 0.8], 'edgecolor', 'none');
bar((1:30)+0.2, PM25_2017, 0.4, 'facec', [0.8 0.8 0.8], 'edgecolor', 'none');

% legend('PM10', 'PM25');
text(0.83, PM25_2017(1), ' PM10', 'rotation', 90, 'fontsize', 8, 'fontweight', 'bold');
text(1.25, PM25_2017(1), ' PM2.5', 'rotation', 90, 'fontsize', 8, 'fontweight', 'bold');

gdx_filename = 'result_egyint_n.gdx'; [turban, ~] = getgdx(gdx_filename, 'turban');
PM10 = squeeze(turban(strcmp('PM10',turban_id{1}),:,:));
PM25 = squeeze(turban(strcmp('PM25',turban_id{1}),:,:));
PM10_2017 = PM10(:,2)*3/5 + PM10(:,3)*2/5;
PM25_2017 = PM25(:,2)*3/5 + PM25(:,3)*2/5;
bar((1:30)-0.2, PM10_2017, 0.4, 'facec', [0.52 0.35 0], 'edgecolor', 'none');
bar((1:30)+0.2, PM25_2017, 0.4, 'facec', [0.9 0 0], 'edgecolor', 'none');

xlim([0.3 30.6]);
set(gca, 'fontsize', 7);
set(gca, 'layer', 'top');
set(gca, 'xtick', 1:30);
set(gca, 'xticklabel', r);
ylabel({'Non-GHG Urban Pollution Specices', '(Absolute Quantity)'});
box off
set(gca, 'tickdir', 'out');
set(gca, 'ticklength', [0.005 0.005]);
title(['Non-GHG Urban Pollution Specices in 2017 (', title_name, ')'], 'fontsize', 10, 'fontweight', 'bold');
my_gridline('y');

set(gcf, 'units', 'inch', 'pos', [10.2708    0.770    9.35    2]);
set(gca, 'pos', [0.0569    0.1023    0.9263    0.7883]);




