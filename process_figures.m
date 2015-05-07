clear all
close all
clc
format compact

r = {'BJ','TJ','HE','SX','SD','NM','LN','JL','HL','SH','JS','ZJ','AH','FJ','HA','HB','HN','JX','SC','CQ','SN','GS','QH','NX','XJ','GD','GX','YN','GZ','HI'};


%% regional energy intensity
figure(1); clf; hold on;

gdx_filename = 'result_urban_exo.gdx'; [report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30)); % 2007~2030
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); % 2007~2020
egy_intensity = (egycons./GDP)';

hb0 = bar(1:30, egy_intensity, 'hist');
set(hb0, 'facec', [0.6 0.6 0.6], 'edgecolor', 'none');

gdx_filename = 'result_egyint_n.gdx'; [report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30)); % 2007~2030
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); % 2007~2020
egy_intensity = (egycons./GDP)';
hb = bar(1:30, egy_intensity, 'hist');
color1 = [1 1 1];
color2 = [0 0.5 0];
cc = [linspace(color1(1),color2(1),size(report,2))
      linspace(color1(2),color2(2),size(report,2))
      linspace(color1(3),color2(3),size(report,2))]';
for c = 1:size(report,2), set(hb(c), 'facec', cc(c,:)); end

set(gca, 'fontsize', 10);
xlim([0.4 30.6]);
set(gca, 'xtick', 1:30, 'xticklabel', r);
set(gca, 'tickdir', 'out');
set(gca, 'ticklength', [0.005 0.005]);
ylabel('Energy Intensity, 2007-2030  ', 'Fontsize', 11, 'fontweight', 'bold');
set(gcf, 'units', 'inch', 'pos', [0.7292    3.7500    9.35    2.25]);
set(gca, 'pos', [0.0569    0.1162    0.9263    0.8421]);

my_gridline('y');

legend([hb, hb0(1)], [report_id{2}, 'No Policy'], 'orientation', 'horizontal', 2);
set(legend, 'box', 'off');

% export_fig combine_egy_intensity -painters;


%% ==========
yr = [2007, 2010:5:2030];
figure(2); clf; hold on; box on;

egy_intensity_n = getgdx('result_urban_exo.gdx', 'egy_intensity_n');
plot(yr, egy_intensity_n, '^-', 'color', [0.5 0.5 0.5], 'markersize', 7, 'linewidth', 1);
egy_intensity_n = getgdx('result_egyint_n.gdx', 'egy_intensity_n');
plot(yr, egy_intensity_n, 'o-', 'color', [0 0.8 0], 'markersize', 7, 'linewidth', 1);

ylim([0 0.8]);
set(gca, 'fontsize', 10);
ylabel('National Energy Intensity', 'fontsize', 12, 'fontweight', 'bold');
set(gcf, 'unit', 'inch', 'pos', [0.25+4.15    0.7917    4.0000    3.0000]);
legend('No Policy', 'w/ Policy', 3);

my_gridline;
% export_fig egy_int_n;


%% ==========
% regional energy intensity map (only 2007)
egy_intensity_r = getgdx('result_urban_exo.gdx', 'egy_intensity_r'); % [r]x[t]
egy_intensity_2007 = egy_intensity_r(:,1)';
min(egy_intensity_2007)
max(egy_intensity_2007)

figure(3); clf;
set(gcf, 'unit', 'inch', 'pos', [10.2813    3.7500    5.0000    3.7500]);
ax = worldmap('world');

latlim = [15 57];
lonlim = [70 140];
setm(ax, 'MapLatLimit', latlim);
setm(ax, 'MapLonLimit', lonlim);
setm(ax, 'MapProjection', 'miller');

z = [0 0 0.9; % blue
     1 1 1; % white
     1 0 0];% red
min_tick = 0;
max_tick = 3;
scaling_color = [interp1(linspace(min_tick, max_tick, length(z)), z(:,1), egy_intensity_2007)', ...
                 interp1(linspace(min_tick, max_tick, length(z)), z(:,2), egy_intensity_2007)', ...
                 interp1(linspace(min_tick, max_tick, length(z)), z(:,3), egy_intensity_2007)'];
scaling_color = [scaling_color;[0.7 0.7 0.7]]; % add 'XZ' as grey mannually
load china_province;
faceColors = makesymbolspec('Polygon',{'INDEX', [1 numel(china_province)], 'FaceColor', scaling_color});
geoshow(gca, china_province, 'DisplayType', 'polygon', 'SymbolSpec', faceColors, 'edgecolor', 'k')
framem off; gridm off; mlabel off; plabel off

set(ax, 'pos', [-0.02 -0.05 1.15 1.15]);
set(gcf, 'color', 'w');

latlim = getm(ax, 'MapLatLimit');
lonlim = getm(ax, 'MapLonLimit');
lat = [china_province.LabelLat];
lon = [china_province.LabelLon];
tf = ingeoquad(lat, lon, latlim, lonlim);
textm(lat(tf), lon(tf), {china_province(tf).Name}, 'HorizontalAlignment', 'center', 'fontsize', 8, 'fontweight', 'bold', 'color', 'k');
textm(30, 89.5, '(No Data Avialable)', 'HorizontalAlignment', 'center', 'fontsize', 6, 'color', 'k');

textm(52, 100, 'Energy Intensity in 2007', 'HorizontalAlignment', 'center', 'fontsize', 10, 'fontweight', 'bold', 'color', 'k');

% scaleruler('units', 'km', 'MajorTick', 0:500:1000, 'minortick',0:0.1:0.1, 'minorticklabel', '0', ...
%            'yloc', 2.6e6, 'xloc', 8.75e6, 'fontsize', 6);
% scaleruler('units', 'mi', 'MajorTick', 0:500:1000, 'minortick',0:0.1:0.1, 'minorticklabel', '0', ...
%            'TickDir', 'down', 'yloc', 2.55e6, 'xloc', 8.75e6, 'fontsize', 6);

% home-made colorbar (vertical):
ax2 = axes('Position',[0.8450    0.1100    0.0246    0.3948]);

cvec = linspace(0,1,16);
[~, conhand] = contourf(ax2, [0 1]', cvec ,[cvec; cvec]',cvec,'linecolor','none');
set(ax2,'xtick',[],'yaxislocation','right','ytick',cvec,'yticklabel', roundn(linspace(min_tick,max_tick,length(cvec)), -1), 'fontsize', 6);
set(ax2, 'pos', [0.8450    0.1100    0.0246    0.3948]);

p = get(conhand,'children');
thechild = get(p,'CData');   
cdat = cell2mat(thechild);
scaling_color = [interp1(linspace(0, 1,length(z)), z(:,1), cvec)', ...
                 interp1(linspace(0, 1,length(z)), z(:,2), cvec)', ...
                 interp1(linspace(0, 1,length(z)), z(:,3), cvec)'];
for i = 1:length(cvec), set(p(cdat==cvec(i)), 'Facecolor', scaling_color(i,:)); end

% file_name = [file_heading, '_egy_intensity_map'];
% export_fig(file_name, '-painters');

%% ==========
% regional energy intensity map (only 2030)
egy_intensity_r = getgdx('result_urban_exo.gdx', 'egy_intensity_r'); % [r]x[t]
egy_intensity_2030 = egy_intensity_r(:,end)';
min(egy_intensity_2030)
max(egy_intensity_2030)

figure(4); clf;
set(gcf, 'unit', 'inch', 'pos', [10.2813    3.7500    5.0000    3.7500]);
ax = worldmap('world');

latlim = [15 57];
lonlim = [70 140];
setm(ax, 'MapLatLimit', latlim);
setm(ax, 'MapLonLimit', lonlim);
setm(ax, 'MapProjection', 'miller');

z = [0 0 0.9; % blue
     1 1 1; % white
     1 0 0];% red
min_tick = 0;
max_tick = 3;
scaling_color = [interp1(linspace(min_tick, max_tick, length(z)), z(:,1), egy_intensity_2030)', ...
                 interp1(linspace(min_tick, max_tick, length(z)), z(:,2), egy_intensity_2030)', ...
                 interp1(linspace(min_tick, max_tick, length(z)), z(:,3), egy_intensity_2030)'];
scaling_color = [scaling_color;[0.7 0.7 0.7]]; % add 'XZ' as grey mannually
load china_province;
faceColors = makesymbolspec('Polygon',{'INDEX', [1 numel(china_province)], 'FaceColor', scaling_color});
geoshow(gca, china_province, 'DisplayType', 'polygon', 'SymbolSpec', faceColors, 'edgecolor', 'k')
framem off; gridm off; mlabel off; plabel off

set(ax, 'pos', [-0.02 -0.05 1.15 1.15]);
set(gcf, 'color', 'w');

latlim = getm(ax, 'MapLatLimit');
lonlim = getm(ax, 'MapLonLimit');
lat = [china_province.LabelLat];
lon = [china_province.LabelLon];
tf = ingeoquad(lat, lon, latlim, lonlim);
textm(lat(tf), lon(tf), {china_province(tf).Name}, 'HorizontalAlignment', 'center', 'fontsize', 8, 'fontweight', 'bold', 'color', 'k');
textm(30, 89.5, '(No Data Avialable)', 'HorizontalAlignment', 'center', 'fontsize', 6, 'color', 'k');

textm(52, 100, 'Energy Intensity in 2030 (No Policy)', 'HorizontalAlignment', 'center', 'fontsize', 10, 'fontweight', 'bold', 'color', 'k');

% scaleruler('units', 'km', 'MajorTick', 0:500:1000, 'minortick',0:0.1:0.1, 'minorticklabel', '0', ...
%            'yloc', 2.6e6, 'xloc', 8.75e6, 'fontsize', 6);
% scaleruler('units', 'mi', 'MajorTick', 0:500:1000, 'minortick',0:0.1:0.1, 'minorticklabel', '0', ...
%            'TickDir', 'down', 'yloc', 2.55e6, 'xloc', 8.75e6, 'fontsize', 6);

% home-made colorbar (vertical):
ax2 = axes('Position',[0.8450    0.1100    0.0246    0.3948]);

cvec = linspace(0,1,16);
[~, conhand] = contourf(ax2, [0 1]', cvec ,[cvec; cvec]',cvec,'linecolor','none');
set(ax2,'xtick',[],'yaxislocation','right','ytick',cvec,'yticklabel', roundn(linspace(min_tick,max_tick,length(cvec)), -1), 'fontsize', 6);
set(ax2, 'pos', [0.8450    0.1100    0.0246    0.3948]);

p = get(conhand,'children');
thechild = get(p,'CData');   
cdat = cell2mat(thechild);
scaling_color = [interp1(linspace(0, 1,length(z)), z(:,1), cvec)', ...
                 interp1(linspace(0, 1,length(z)), z(:,2), cvec)', ...
                 interp1(linspace(0, 1,length(z)), z(:,3), cvec)'];
for i = 1:length(cvec), set(p(cdat==cvec(i)), 'Facecolor', scaling_color(i,:)); end

% file_name = [file_heading, '_egy_intensity_map_2030_noPolicy'];
% export_fig(file_name, '-painters');

%% ==========
% regional energy intensity map (only 2030)
egy_intensity_r = getgdx('result_egyint_n.gdx', 'egy_intensity_r'); % [r]x[t]
egy_intensity_2030 = egy_intensity_r(:,end)';

figure(5); clf;
set(gcf, 'unit', 'inch', 'pos', [10.2813    3.7500    5.0000    3.7500]);
ax = worldmap('world');

latlim = [15 57];
lonlim = [70 140];
setm(ax, 'MapLatLimit', latlim);
setm(ax, 'MapLonLimit', lonlim);
setm(ax, 'MapProjection', 'miller');

z = [0 0 0.9; % blue
     1 1 1; % white
     1 0 0];% red
min_tick = 0;
max_tick = 3;
scaling_color = [interp1(linspace(min_tick, max_tick, length(z)), z(:,1), egy_intensity_2030)', ...
                 interp1(linspace(min_tick, max_tick, length(z)), z(:,2), egy_intensity_2030)', ...
                 interp1(linspace(min_tick, max_tick, length(z)), z(:,3), egy_intensity_2030)'];
scaling_color = [scaling_color;[0.7 0.7 0.7]]; % add 'XZ' as grey mannually
load china_province;
faceColors = makesymbolspec('Polygon',{'INDEX', [1 numel(china_province)], 'FaceColor', scaling_color});
geoshow(gca, china_province, 'DisplayType', 'polygon', 'SymbolSpec', faceColors, 'edgecolor', 'k')
framem off; gridm off; mlabel off; plabel off

set(ax, 'pos', [-0.02 -0.05 1.15 1.15]);
set(gcf, 'color', 'w');

latlim = getm(ax, 'MapLatLimit');
lonlim = getm(ax, 'MapLonLimit');
lat = [china_province.LabelLat];
lon = [china_province.LabelLon];
tf = ingeoquad(lat, lon, latlim, lonlim);
textm(lat(tf), lon(tf), {china_province(tf).Name}, 'HorizontalAlignment', 'center', 'fontsize', 8, 'fontweight', 'bold', 'color', 'k');
textm(30, 89.5, '(No Data Avialable)', 'HorizontalAlignment', 'center', 'fontsize', 6, 'color', 'k');

textm(52, 100, 'Energy Intensity in 2030 (w/ Policy)', 'HorizontalAlignment', 'center', 'fontsize', 10, 'fontweight', 'bold', 'color', 'k');

% scaleruler('units', 'km', 'MajorTick', 0:500:1000, 'minortick',0:0.1:0.1, 'minorticklabel', '0', ...
%            'yloc', 2.6e6, 'xloc', 8.75e6, 'fontsize', 6);
% scaleruler('units', 'mi', 'MajorTick', 0:500:1000, 'minortick',0:0.1:0.1, 'minorticklabel', '0', ...
%            'TickDir', 'down', 'yloc', 2.55e6, 'xloc', 8.75e6, 'fontsize', 6);

% home-made colorbar (vertical):
ax2 = axes('Position',[0.8450    0.1100    0.0246    0.3948]);

cvec = linspace(0,1,16);
[~, conhand] = contourf(ax2, [0 1]', cvec ,[cvec; cvec]',cvec,'linecolor','none');
set(ax2,'xtick',[],'yaxislocation','right','ytick',cvec,'yticklabel', roundn(linspace(min_tick,max_tick,length(cvec)), -1), 'fontsize', 6);
set(ax2, 'pos', [0.8450    0.1100    0.0246    0.3948]);

p = get(conhand,'children');
thechild = get(p,'CData');   
cdat = cell2mat(thechild);
scaling_color = [interp1(linspace(0, 1,length(z)), z(:,1), cvec)', ...
                 interp1(linspace(0, 1,length(z)), z(:,2), cvec)', ...
                 interp1(linspace(0, 1,length(z)), z(:,3), cvec)'];
for i = 1:length(cvec), set(p(cdat==cvec(i)), 'Facecolor', scaling_color(i,:)); end

% file_name = [file_heading, '_egy_intensity_map_2030_wPolicy'];
% export_fig(file_name, '-painters');


%% regional energy consumption
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

% export_fig('regional_egy_consumption', '-painters');


%% regional coal consumption
figure(7); clf; hold on;

gdx_filename = 'result_default.gdx'; [egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
hb0 = bar(1:30, col_consumption', 'hist');
set(hb0, 'facec', [0.8 0.8 0.8], 'edgecolor', 'none');

gdx_filename = 'result_egyint_n.gdx'; [egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
hb = bar(1:30, col_consumption', 'hist');
color1 = [1 1 1];
color2 = [0 0.5 0];
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
set(gca, 'pos', [0.0569    0.1023    0.9263    0.8560]);my_gridline('y');

legend([hb, hb0(1)], [report_id{2}, 'No Policy'], 'orientation', 'horizontal', 1);
set(legend, 'box', 'off');

my_gridline('y');
% export_fig('regional_coal_consumption', '-painters');


%% national energy consumption
figure(8); clf; hold on; box on;

[report, report_id] = getgdx('result_urban_exo.gdx', 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
egycons_n = sum(egycons,2);
plot(yr, egycons_n, '^-', 'color', [0.5 0.5 0.5], 'markersize', 7, 'linewidth', 1);

[report, report_id] = getgdx('result_egyint_n.gdx', 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
egycons_n = sum(egycons,2);
plot(yr, egycons_n, 'o-', 'color', [0 0.8 0], 'markersize', 7, 'linewidth', 1);

ylim([0 9000]);
set(gca, 'fontsize', 10);
ylabel('National Energy Consumption (mtce)', 'fontsize', 12, 'fontweight', 'bold');
set(gcf, 'unit', 'inch', 'pos', [0.25+4.15    0.7917    4.0000    3.0000]);
legend('No Policy', 'w/ Policy', 2);

my_gridline;
% export_fig national_energy_consumption;


%% national coal consumption
figure(9); clf; hold on; box on;

[egyreport2, egyreport2_id] = getgdx('result_urban_exo', 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
plot(yr, col_consumption_n, '^-', 'color', [0.5 0.5 0.5], 'markersize', 7, 'linewidth', 1);

[egyreport2, egyreport2_id] = getgdx('result_egyint_n', 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
plot(yr, col_consumption_n, 'o-', 'color', [0 0.8 0], 'markersize', 7, 'linewidth', 1);

ylim([0 9000]);
set(gca, 'fontsize', 10);
ylabel('National Coal Consumption (mtce)', 'fontsize', 12, 'fontweight', 'bold');
set(gcf, 'unit', 'inch', 'pos', [0.25+4.15    0.7917    4.0000    3.0000]);
legend('No Policy', 'w/ Policy', 2);

my_gridline;
% export_fig national_coal_consumption;


%% ==========
yr = [2007, 2010:5:2030];
figure(91); clf; hold on; box on;

gdx_filename = 'result_urban_exo.gdx';
[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
nhw_consumption = squeeze(egyreport2(1,:,strcmp('NHW', egyreport2_id{3}),1:30))/0.12*0.356;
nhw_consumption_n = sum(nhw_consumption,2);
[report, report_id] = getgdx(gdx_filename, 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30));
egycons_n = sum(egycons,2);
col_share_n = col_consumption_n./egycons_n; % national coal share
nhw_share_n = nhw_consumption_n./egycons_n;
h1 = plot(yr, col_share_n, '^-', 'color', [0.5 0.5 0.5], 'markersize', 7, 'linewidth', 1);
h2 = plot(yr, nhw_share_n, '^-', 'color', [0.5 0.5 0.5], 'markersize', 7, 'linewidth', 1, 'markerf', [0.5 0.5 0.5]);

gdx_filename = 'result_egyint_n.gdx';
[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
nhw_consumption = squeeze(egyreport2(1,:,strcmp('NHW', egyreport2_id{3}),1:30))/0.12*0.356;
nhw_consumption_n = sum(nhw_consumption,2);
[report, report_id] = getgdx(gdx_filename, 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30));
egycons_n = sum(egycons,2);
col_share_n = col_consumption_n./egycons_n; % national coal share
nhw_share_n = nhw_consumption_n./egycons_n;
h3 = plot(yr, col_share_n, 'o-', 'color', [0 0.8 0], 'markersize', 7, 'linewidth', 1);
h4 = plot(yr, nhw_share_n, 'o-', 'color', [0 0.8 0], 'markersize', 7, 'linewidth', 1, 'markerf', [0 0.8 0]);

set(gca, 'fontsize', 10);
ylabel('National Coal Share', 'fontsize', 12, 'fontweight', 'bold');
set(gcf, 'unit', 'inch', 'pos', [0.25+4.15    0.7917    4.0000    3.0000]);
ylim([0 0.8]);
legend('Coal (No Policy)', 'Coal (w/ Policy)', 'Non-Fossil (No Policy)', 'Non-Fossil (w/ Policy)');
set(legend, 'location', 'west');

my_gridline;
% export_fig national_coal_share;


%% GDP
figure(10); clf; hold on; box on;

[report, report_id] = getgdx('result_urban_exo.gdx', 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
plot(yr, GDP_n, '^-', 'color', [0.5 0.5 0.5], 'markersize', 5);

[report, report_id] = getgdx('result_egyint_n.gdx', 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
plot(yr, GDP_n, 'o-', 'color', [0 0.8 0], 'markersize', 5);

set(gca, 'fontsize', 8);
ylabel('GDP (Billion USD in 2007 value)', 'fontsize', 9);
set(gcf, 'unit', 'inch', 'pos', [0.25+4.15    0.7917    4.0000    3.0000]);
legend('No Policy', 'w/ Policy', 2);

% my_gridline; export_fig GDP;


%% urban emissions
gdx_filename = 'result_urban_exo.gdx';
[urban, urban_id] = getgdx(gdx_filename, 'urban');
urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
for i = 1:length(urban_id{1})
    urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
    urban_CHN(i,:) = sum(urban_extract);
    
    figure(10+i); clf; box on;
    plot(yr, urban_CHN(i,:), '^-', 'color', [0.5 0.5 0.5], 'markersize', 7, 'linewidth', 1);
    set(gca, 'fontsize', 10);
    ylabel('(Tg)', 'fontsize', 12, 'fontweight', 'bold');
    title(urban_id{1}(i), 'fontsize', 12, 'fontweight', 'bold');
    
    set(gcf, 'unit', 'inch', 'pos', [0.25+4.15*(i-1)    4.75    4.0000    3.0000]);
    
    if i == 1, ylim([0 6]); end
    if i == 2, ylim([0 500]); end
    if i == 3, ylim([0 40]); end
    if i == 4, ylim([0 80]); end
    if i == 5, ylim([0 6]); end
    if i == 6, ylim([0 60]); end
    if i == 7, ylim([0 40]); end
    if i == 8, ylim([0 80]); end
    if i == 9, ylim([0 60]); end
end

% ==========
gdx_filename = 'result_egyint_n.gdx';
[urban, urban_id] = getgdx(gdx_filename, 'urban');
urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
for i = 1:length(urban_id{1})
    urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
    urban_CHN(i,:) = sum(urban_extract);
    
    figure(10+i); hold on; box on;
    plot(yr, urban_CHN(i,:), 'o-', 'color', [0 0.8 0], 'markersize', 7, 'linewidth', 1);
    if i == 1
        legend('No Policy', 'w/ Policy', 2);
    end
    
    export_filename = ['fig_', char(urban_id{1}(i))];
    my_gridline;
%     export_fig(export_filename);
end


%% SO2 from ELE sector
yr = [2007, 2010:5:2030];
[urban, urban_id] = getgdx('result_urban_exo.gdx', 'urban');
SO2 = squeeze(urban(strcmp('SO2', urban_id{1}),:,:,:));
SO2_r = squeeze(sum(SO2,2));
SO2_n = sum(SO2_r);

SO2_ele = squeeze(SO2(:,strcmp('ELE',urban_id{3}),:)); % [30]x[6]
SO2_ele_n = sum(SO2_ele);

figure(20); clf; hold on; box on;
line([2005 2032], [1 1]*10, 'color', [0.9 0.9 0.9]);
line([2005 2032], [1 1]*20, 'color', [0.9 0.9 0.9]);
line([2005 2032], [1 1]*30, 'color', [0.9 0.9 0.9]);
line([2005 2032], [1 1]*40, 'color', [0.9 0.9 0.9]);
line([2005 2032], [1 1]*50, 'color', [0.9 0.9 0.9]);
line([2005 2032], [1 1]*60, 'color', [0.9 0.9 0.9]);

hb = bar(yr, [SO2_n-SO2_ele_n;SO2_ele_n]', 'stacked');
set(hb(1), 'facec', [1 0.4 0.4], 'edge', 'none');
set(hb(2), 'facec', [0.3 0.65 1], 'edge', 'none');

axis([2005 2032 0 70]);
set(gca, 'fontsize', 8);
ylabel('SO2 (Tg)');
legend(fliplr(hb), 'Electricity', 'Other Sectors', 2);
set(gcf, 'unit', 'inch', 'pos', [8.8750    5.9167    4.0000    3.0000]);
title('No Policy', 'fontsize', 10);

% export_fig('ELE_SO2', '-painters');

% ==========
yr = [2007, 2010:5:2030];
[urban, urban_id] = getgdx('result_egyint_n.gdx', 'urban');
SO2 = squeeze(urban(strcmp('SO2', urban_id{1}),:,:,:));
SO2_r = squeeze(sum(SO2,2));
SO2_n = sum(SO2_r);

SO2_ele = squeeze(SO2(:,strcmp('ELE',urban_id{3}),:)); % [30]x[6]
SO2_ele_n = sum(SO2_ele);

figure(21); clf; hold on; box on;
line([2005 2032], [1 1]*10, 'color', [0.9 0.9 0.9]);
line([2005 2032], [1 1]*20, 'color', [0.9 0.9 0.9]);
line([2005 2032], [1 1]*30, 'color', [0.9 0.9 0.9]);
line([2005 2032], [1 1]*40, 'color', [0.9 0.9 0.9]);
line([2005 2032], [1 1]*50, 'color', [0.9 0.9 0.9]);
line([2005 2032], [1 1]*60, 'color', [0.9 0.9 0.9]);

hb = bar(yr, [SO2_n-SO2_ele_n;SO2_ele_n]', 'stacked');
set(hb(1), 'facec', [1 0.4 0.4], 'edge', 'none');
set(hb(2), 'facec', [0.3 0.65 1], 'edge', 'none');

axis([2005 2032 0 70]);
set(gca, 'fontsize', 8);
ylabel('SO2 (Tg)');
legend(fliplr(hb), 'Electricity', 'Other Sectors', 2);
set(gcf, 'unit', 'inch', 'pos', [8.8750    5.9167    4.0000    3.0000]);
title('w/ Policy', 'fontsize', 10);

% export_fig('ELE_SO2_wPolicy', '-painters');


