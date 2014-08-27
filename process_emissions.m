clear all
close all
clc
format compact

r = {'BJ','TJ','HE','SX','SD','NM','LN','JL','HL','SH','JS','ZJ','AH','FJ','HA','HB','HN','JX','SC','CQ','SN','GS','QH','NX','XJ','GD','GX','YN','GZ','HI'};

% gdx_filename = 'result_default.gdx'; file_heading = 'default'; title_name = 'No Policy'; 
gdx_filename = 'result_egyint_n.gdx'; file_heading = 'egyint'; title_name = 'Energy Intensity in 2017 is 20% less than in 2012';
% gdx_filename = 'result_egyint_n_coaltax.gdx'; file_heading = 'egyintNcoaltax'; title_name = 'Energy Intensity in 2017 is 20% less than in 2012';


%% national energy consumption
[report, report_id] = getgdx(gdx_filename, 'report'); % [7]x[6]x[35]
% report_id{1}; % COL/GAS/OIL/GDP/egycons/GDPperCapita/consCO2emis
% report_id{2}; % 2007/2010/2015/2020/2025/2030
% report_id{3}; % r+s+CHN

egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); % 2007~2020

% figure(1); clf; hold on;
% x = repmat(str2double(report_id{2}),30,1);
% y = 1:30;
% z = egycons';
% options.barwidth = 0.001;
% options.ColormapWall = 'jet';
% options.Edgecolor = 'none';
% options.LegendSym = 'none';
% area3(x,y,z, options);
% set(gca, 'fontsize', 8);
% set(gca, 'ydir', 'reverse');
% set(gca, 'ticklength', [0.005 0.005]);
% grid on
% ylim([0.4 30.6]);
% zlim([0 600]);
% xlim(str2double(report_id{2}([1, end])));
% set(gca, 'xtick', str2double(report_id{2}));
% set(gca, 'ytick', 1:30, 'yticklabel', r);
% zlabel('Energy Consumption (mtce)');
% title(title_name, 'fontsize', 10, 'fontweight', 'bold');
% 
% set(gcf, 'units', 'inch', 'pos', [0.3854    6.2917    14.6146    3.2604]);
% set(gca, 'pos', [0.0635    0.0972    0.9064    0.8007]);
% view(-92,8);
% 
% file_name = [file_heading, '_egycons_area3'];
% export_fig(file_name, '-painters');

% ==============================
figure(11); clf;
hb = bar(1:30, egycons', 'hist');
cc = linspace(1,0.25,size(report,2));
for c = 1:size(report,2), set(hb(c), 'facec', [1 1 1]*cc(c), 'edgecolor', 'k'); end
set(gca, 'fontsize', 7);
xlim([0.4 30.6]);
ylim([0 600]);
set(gca, 'xtick', 1:30, 'xticklabel', r);
set(gca, 'tickdir', 'out');
set(gca, 'ticklength', [0.005 0.005]);
box off;
ylabel('Energy Consumption, 2007-2030 (mtce)');
title(title_name, 'fontsize', 10, 'fontweight', 'bold');
set(gcf, 'units', 'inch', 'pos', [0.7292    6.7292    9.35    2]);
set(gca, 'pos', [0.0569    0.1023    0.9263    0.7883]);
legend(hb, report_id{2}, 'orientation', 'horizontal');
set(legend, 'box', 'off');
my_gridline('y');

% file_name = [file_heading, '_egycons'];
% export_fig(file_name, '-painters');


%% regional energy intensity (2007 - 2030)
egy_intensity_r = getgdx(gdx_filename, 'egy_intensity_r'); % [r]x[t]

figure(2); clf;
hb = bar(1:30, egy_intensity_r, 'hist');
cc = linspace(1,0.25,size(report,2));
for c = 1:size(report,2), set(hb(c), 'facec', [1 1 1]*cc(c), 'edgecolor', 'k'); end
set(gca, 'fontsize', 7);
xlim([0.4 30.6]);
ylim([0 3]);
set(gca, 'xtick', 1:30, 'xticklabel', r);
set(gca, 'tickdir', 'out');
set(gca, 'ticklength', [0.005 0.005]);
box off;
ylabel('Energy Intensity, 2007-2030');
title(title_name, 'fontsize', 10, 'fontweight', 'bold');
set(gcf, 'units', 'inch', 'pos', [0.7292    3.7500    9.35    2]);
set(gca, 'pos', [0.0569    0.1023    0.9263    0.7883]);
legend(hb, report_id{2}, 'orientation', 'horizontal', 2);
set(legend, 'box', 'off');
my_gridline('y');

% file_name = [file_heading, '_egy_intensity'];
% export_fig(file_name, '-painters');


%% regional energy intensity (only 2007)
egy_intensity_2017 = 3/5*egy_intensity_r(:,3) + 2/5*egy_intensity_r(:,4);
egy_intensity_2017 = egy_intensity_2017';

figure(21); clf;
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
max_tick = 2.5;
scaling_color = [interp1(linspace(min_tick, max_tick, length(z)), z(:,1), egy_intensity_2017)', ...
                 interp1(linspace(min_tick, max_tick, length(z)), z(:,2), egy_intensity_2017)', ...
                 interp1(linspace(min_tick, max_tick, length(z)), z(:,3), egy_intensity_2017)'];
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
%textm(30, 89.5, '(No Data Avialable)', 'HorizontalAlignment', 'center', 'fontsize', 7, 'color', 'k');

textm(52, 100, 'Energy Intensity in 2017', 'HorizontalAlignment', 'center', 'fontsize', 10, 'fontweight', 'bold', 'color', 'k');

scaleruler('units', 'km', 'MajorTick', 0:500:1000, 'minortick',0:0.1:0.1, 'minorticklabel', '0', ...
           'yloc', 2.6e6, 'xloc', 8.75e6, 'fontsize', 6);
scaleruler('units', 'mi', 'MajorTick', 0:500:1000, 'minortick',0:0.1:0.1, 'minorticklabel', '0', ...
           'TickDir', 'down', 'yloc', 2.55e6, 'xloc', 8.75e6, 'fontsize', 6);

% home-made colorbar (vertical):
ax2 = axes('Position',[0.8804    0.1100    0.0246    0.3948]);

cvec = 0:0.1:1;
[~, conhand] = contourf(ax2, [0 1]', cvec ,[cvec; cvec]',cvec,'linecolor','none');
set(ax2,'xtick',[],'yaxislocation','right','ytick',cvec,'yticklabel', roundn(linspace(min_tick,max_tick,length(cvec)), -1), 'fontsize', 7);
set(ax2, 'pos', [0.8804    0.1100    0.0246    0.3948]);

p = get(conhand,'children');
thechild = get(p,'CData');   
cdat = cell2mat(thechild);
scaling_color = [interp1(linspace(0, 1,length(z)), z(:,1), cvec)', ...
                 interp1(linspace(0, 1,length(z)), z(:,2), cvec)', ...
                 interp1(linspace(0, 1,length(z)), z(:,3), cvec)'];
for i = 1:length(cvec), set(p(cdat==cvec(i)), 'Facecolor', scaling_color(i,:)); end

% file_name = [file_heading, '_egy_intensity_map'];
% export_fig(file_name, '-painters');


%% Resional coal consumption (2007-2030)
[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
coal_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30)); % 2007~2020

figure(3); clf; hold on;
hb = bar(1:30, coal_consumption', 'hist');
cc = linspace(1,0.25,size(report,2));
for c = 1:size(report,2), set(hb(c), 'facec', [1 1 1]*cc(c)); end
set(gca, 'fontsize', 7);
xlim([0.4 30.6]);
ylim([0 500]);
set(gca, 'xtick', 1:30, 'xticklabel', r);
set(gca, 'tickdir', 'out');
set(gca, 'ticklength', [0.005 0.005]);
ylabel('Coal Consumption,2007-2030 (mtce)');
title(title_name, 'fontsize', 10, 'fontweight', 'bold');
set(gcf, 'units', 'inch', 'pos', [0.7292    0.770    9.35    2]);
set(gca, 'pos', [0.0569    0.1023    0.9263    0.7883]);
legend(hb, report_id{2}, 'orientation', 'horizontal');
set(legend, 'box', 'off');
my_gridline('y');

% file_name = [file_heading, '_coal_consumption'];
% export_fig(file_name, '-painters');


%% CHN total final fossile energy consumption (only 2017, final year in the Action Plan)
oil_consumption = squeeze(egyreport2(1,:,strcmp('OIL', egyreport2_id{3}),1:30));
gas_consumption = squeeze(egyreport2(1,:,strcmp('GAS', egyreport2_id{3}),1:30));
ele_nhw = getgdx(gdx_filename, 'ele_nhw')'; % [Mtce]

coal_consumption_2017 = 3/5*coal_consumption(3,:) + 2/5*coal_consumption(4,:);
oil_consumption_2017 = 3/5*oil_consumption(3,:) + 2/5*oil_consumption(4,:);
gas_consumption_2017 = 3/5*gas_consumption(3,:) + 2/5*gas_consumption(4,:);
ele_nhw_2017 = 3/5*ele_nhw(3,:) + 2/5*ele_nhw(4,:);
total_evd_CHN = [sum(coal_consumption_2017), sum(oil_consumption_2017), sum(gas_consumption_2017), sum(ele_nhw_2017)];

figure(4); clf;
bar(total_evd_CHN, 0.7, 'facec', [0.3 0.65 1], 'edge', 'none');
set(gca, 'fontsize', 7);
set(gca, 'tickdir', 'out');
set(gca, 'xtick', 1:4, 'xticklabel', {'COL', 'OIL', 'GAS', 'NHW'});
xlim([0.4 4.55]);
ylim([0 5000]);
box off;
ylabel({'Final Energy Consumption', 'in China in 2017 (mtce)'});
set(gcf, 'units', 'inch', 'pos', [9.0625    1.9583    2    2]);
set(gca, 'pos', [0.0555    0.1023    0.6737    0.7883]);
set(gca, 'yaxislocation', 'right');
set(gca, 'xcolor', 'b', 'ycolor', 'b');

pctg = total_evd_CHN/sum(total_evd_CHN);
text(1, total_evd_CHN(1)+250, num2str(pctg(1), '%2.2f'), 'fontsize', 8, 'horizontalalignment', 'center');
text(2, total_evd_CHN(2)+250, num2str(pctg(2), '%2.2f'), 'fontsize', 8, 'horizontalalignment', 'center');
text(3, total_evd_CHN(3)+250, num2str(pctg(3), '%2.2f'), 'fontsize', 8, 'horizontalalignment', 'center');
text(4, total_evd_CHN(4)+250, num2str(pctg(4), '%2.2f'), 'fontsize', 8, 'horizontalalignment', 'center');

% file_name = [file_heading, '_FinalEgy_consumption'];
% export_fig(file_name, '-painters');


%% total urban emissions
[turban, turban_id] = getgdx(gdx_filename, 'turban');
turban_2017 = 3/5*turban(:,:,3) + 2/5*turban(:,:,4);

PM10 = turban_2017(strcmp('PM10',turban_id{1}),:);
PM25 = turban_2017(strcmp('PM25',turban_id{1}),:);

figure(5); clf; hold on;
bar((1:30)-0.2, PM10, 0.4, 'facec', [0.52 0.35 0], 'edgecolor', 'none');
bar((1:30)+0.2, PM25, 0.4, 'facec', [0.9 0 0], 'edgecolor', 'none');

xlim([0.3 30.6]);
set(gca, 'fontsize', 7);
set(gca, 'layer', 'top');
set(gca, 'xtick', 1:30);
set(gca, 'xticklabel', r);
ylabel({'Non-GHG Urban Pollution Specices', '(Absolute Quantity)'});
box off
set(gca, 'tickdir', 'out');
set(gca, 'ticklength', [0.005 0.005]);
title('Non-GHG Urban Pollution Specices in 2017 (No Policy)', 'fontsize', 10, 'fontweight', 'bold');
set(gcf, 'units', 'inch', 'pos', [10.2708    0.770    9.35    2]);
set(gca, 'pos', [0.0569    0.1023    0.9263    0.7883]);
my_gridline('y');

% legend('PM10', 'PM25');
text(0.83, PM10(1), ' PM10', 'rotation', 90, 'fontsize', 8, 'fontweight', 'bold');
text(1.25, PM25(1), ' PM2.5', 'rotation', 90, 'fontsize', 8, 'fontweight', 'bold');

% file_name = [file_heading, '_PM_barchart'];
% export_fig(file_name, '-painters');

% ==========
figure(41); clf;
set(gcf, 'units', 'inch', 'pos', [20.2708    5.4167    5.0000    3.7500]);
ax = worldmap('world');

latlim = [15 57];
lonlim = [70 140];
setm(ax, 'MapLatLimit', latlim);
setm(ax, 'MapLonLimit', lonlim);
setm(ax, 'MapProjection', 'miller');

z = [1.0  1    0.6; % light yellow
     1.0  0.65 0.0; % orange
     0.5  0    0.0];% red
min_tick = 0;
max_tick = 4.8e6;
scaling_color = [interp1(linspace(min_tick, max_tick,length(z)), z(:,1), PM10)', ...
                 interp1(linspace(min_tick, max_tick,length(z)), z(:,2), PM10)', ...
                 interp1(linspace(min_tick, max_tick,length(z)), z(:,3), PM10)'];
scaling_color = [scaling_color;[1 1 1]]; % add XZ as white mannually
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

textm(52, 100, 'PM10 (Absolute Quantity)', 'HorizontalAlignment', 'center', 'fontsize', 10, 'fontweight', 'bold', 'color', 'k');

scaleruler('units', 'km', 'MajorTick', 0:500:1000, 'minortick',0:0.1:0.1, 'minorticklabel', '0', ...
           'yloc', 2.5e6, 'xloc', 9.25e6, 'RulerStyle', 'patches');

% home-made colorbar (vertical):
ax2 = axes('Position',[0.8804    0.1100    0.0246    0.3948]);

cvec = 0:0.1:1;
[~, conhand] = contourf(ax2, [0 1]', cvec ,[cvec; cvec]',cvec,'linecolor','none');
set(ax2,'xtick',[],'yaxislocation','right','ytick',cvec,'yticklabel', roundn(linspace(min_tick,max_tick,length(cvec))/1e6, -1), 'fontsize', 7);
set(ax2, 'pos', [0.8804    0.1100    0.0246    0.3948]);
title(ax2, '  (x10^6)', 'fontsize', 8);

p = get(conhand,'children');
thechild = get(p,'CData');   
cdat = cell2mat(thechild);
scaling_color = [interp1(linspace(0, 1,length(z)), z(:,1), cvec)', ...
                 interp1(linspace(0, 1,length(z)), z(:,2), cvec)', ...
                 interp1(linspace(0, 1,length(z)), z(:,3), cvec)'];
for i = 1:length(cvec), set(p(cdat==cvec(i)), 'Facecolor', scaling_color(i,:)); end

% file_name = [file_heading, '_PM10'];
% export_fig(file_name, '-painters');

% ==========
figure(42); clf;
set(gcf, 'units', 'inch', 'pos', [20.2708    0.6354    5.0000    3.7500]);
ax = worldmap('world');

latlim = [15 57];
lonlim = [70 140];
setm(ax, 'MapLatLimit', latlim);
setm(ax, 'MapLonLimit', lonlim);
setm(ax, 'MapProjection', 'miller');

z = [1.0 0.8 0.8;% light red
     1.0 0   0;  % red
     0.7 0   0]; % dark red
min_tick = 0;
max_tick = max(PM25);
scaling_color = [interp1(linspace(min_tick, max_tick,length(z)), z(:,1), PM25)', ...
                 interp1(linspace(min_tick, max_tick,length(z)), z(:,2), PM25)', ...
                 interp1(linspace(min_tick, max_tick,length(z)), z(:,3), PM25)'];
scaling_color = [scaling_color;[1 1 1]]; % add XZ as white mannually
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

textm(52, 100, 'PM2.5 (Absolute Quantity)', 'HorizontalAlignment', 'center', 'fontsize', 10, 'fontweight', 'bold', 'color', 'k');

scaleruler('units', 'km', 'MajorTick', 0:500:1000, 'minortick',0:0.1:0.1, 'minorticklabel', '0', ...
           'yloc', 2.5e6, 'xloc', 9.25e6, 'RulerStyle', 'patches');

% home-made colorbar (vertical):
ax2 = axes('Position',[0.8804    0.1100    0.0246    0.3948]);

cvec = 0:0.1:1;
[~, conhand] = contourf(ax2, [0 1]', cvec ,[cvec; cvec]',cvec,'linecolor','none');
set(ax2,'xtick',[],'yaxislocation','right','ytick',cvec,'yticklabel', roundn(linspace(min_tick,max_tick,length(cvec))/1e6, -1), 'fontsize', 7);
set(ax2, 'pos', [0.8804    0.1100    0.0246    0.3948]);
title(ax2, '  (x10^6)', 'fontsize', 8);

p = get(conhand,'children');
thechild = get(p,'CData');   
cdat = cell2mat(thechild);
scaling_color = [interp1(linspace(0, 1,length(z)), z(:,1), cvec)', ...
                 interp1(linspace(0, 1,length(z)), z(:,2), cvec)', ...
                 interp1(linspace(0, 1,length(z)), z(:,3), cvec)'];
for i = 1:length(cvec), set(p(cdat==cvec(i)), 'Facecolor', scaling_color(i,:)); end

% file_name = [file_heading, '_PM25'];
% export_fig(file_name, '-painters');

