clear all
close all
clc
format compact

yr = [2007, 2010:5:2030];

r = {'BJ','TJ','HE','SX','SD','NM','LN','JL','HL','SH','JS','ZJ','AH','FJ','HA','HB','HN','JX','SC','CQ','SN','GS','QH','NX','XJ','GD','GX','YN','GZ','HI'};


%% No policy
gdx_filename = 'result_urban_exo.gdx';
[urban, urban_id] = getgdx(gdx_filename, 'urban');
urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
for i = 1:length(urban_id{1})
    urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
    urban_CHN(i,:) = sum(urban_extract);
    
    figure(i); hold on; box on;
    plot(yr, urban_CHN(i,:), 'r^-', 'markersize', 5);
    set(gca, 'fontsize', 8);
    ylabel('Urban pollution emissions (Tg)');
    title(urban_id{1}(i), 'fontsize', 10, 'fontweight', 'bold');
    set(gcf, 'unit', 'inch', 'pos', [0.25+4.15*(i-1)    4.75    4.0000    3.0000]);
end

% ==============================
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
figure(10); hold on;
plot(yr, GDP_n, 'r^-', 'markersize', 5);
set(gca, 'fontsize', 8);
ylabel('GDP, Billion US Dollor (2007 Value)');
set(gcf, 'unit', 'inch', 'pos', [0.25    0.7917    4.0000    3.0000]);

egy_intensity_n = getgdx(gdx_filename, 'egy_intensity_n');
figure(11); hold on;
plot(yr, egy_intensity_n, 'r^-', 'markersize', 5);
set(gca, 'fontsize', 8);
ylim([0.3 0.8]);
ylabel('National Energy Intensity');
set(gcf, 'unit', 'inch', 'pos', [0.25+4.15    0.7917    4.0000    3.0000]);

[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
figure(12); hold on;
plot(yr, col_consumption_n, 'r^-', 'markersize', 5);
set(gca, 'fontsize', 8);
ylabel('Coal Consumption (mtce)');
set(gcf, 'unit', 'inch', 'pos', [0.25+4.15*2    0.7917    4.0000    3.0000]);

[report2, report2_id] = getgdx(gdx_filename, 'report2');
% report2_id{1} %Wchange/welfare/CO2emis
% report2_id{2} %2007/2010/2015/2020/2025/2030
% report2_id{3} %AGR/COL/...
% report2_id{4} %r+s+CHN
co2 = squeeze(report2(strcmp('CO2emis', report2_id{1}),:,1:13,1:30));
co2_r = squeeze(sum(co2,2));
co2_n = squeeze(sum(co2_r,2));

figure(13); clf; box off;
hb = bar(1:30, co2_r', 'hist');
set(hb, 'facec', [0.8 0.8 0.8], 'edgecolor', 'none');

set(gca, 'fontsize', 7);
xlim([0.4 30.6]);
set(gca, 'xtick', 1:30, 'xticklabel', r);
set(gca, 'tickdir', 'out');
set(gca, 'ticklength', [0.005 0.005]);
ylabel('CO2 (?)', 'Fontsize', 9);
set(gcf, 'units', 'inch', 'pos', [0.7292    6.7292    9.35    2]);
set(gca, 'pos', [0.0569    0.1023    0.9263    0.8560]);

figure(14); clf;
plot(yr, co2_n/1e3, 'r^-', 'markersize', 5);
set(gca, 'fontsize', 8);
ylabel('CO2 (billion tons)', 'Fontsize', 9);
set(gcf, 'unit', 'inch', 'pos', [0.25+4.15*3    0.7917    4.0000    3.0000]);
for yn = 3:length(yr)
    text(yr(yn), co2_n(yn)/1e3+0.5, num2str(co2_n(yn)/1e3, '%2.1f'), 'fontsize', 8, 'horizontalalignment', 'center');
end


%% policy scenario: national energy intensity
gdx_filename = 'result_egyint_n.gdx';
[urban, urban_id] = getgdx(gdx_filename, 'urban');
urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
for i = 1:length(urban_id{1})
    urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
    urban_CHN(i,:) = sum(urban_extract);
    
    figure(i); hold on;
    plot(yr, urban_CHN(i,:), 'go-', 'markersize', 5);
    if i == 1, legend('No Policy', 'w/ Policy', 2); end
    
    export_filename = ['fig_', char(urban_id{1}(i))];
    % my_gridline; export_fig(export_filename);
end

% ==============================
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
figure(10); hold on;
plot(yr, GDP_n, 'go-', 'markersize', 5);
box on;

egy_intensity_n = getgdx(gdx_filename, 'egy_intensity_n');
figure(11); hold on;
plot(yr, egy_intensity_n, 'go-', 'markersize', 5);
box on;

[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
figure(12); hold on;
plot(yr, col_consumption_n, 'go-', 'markersize', 5);
box on;

[report2, report2_id] = getgdx(gdx_filename, 'report2');
co2 = squeeze(report2(strcmp('CO2emis', report2_id{1}),:,1:13,1:30));
co2_r = squeeze(sum(co2,2));
co2_n = squeeze(sum(co2_r,2));

figure(13); hold on;
hb = bar(1:30, co2_r', 'hist');
color1 = [1 1 1];
color2 = [0 0.5 0];
cc = [linspace(color1(1),color2(1),size(report,2))
      linspace(color1(2),color2(2),size(report,2))
      linspace(color1(3),color2(3),size(report,2))]';
for c = 1:size(report,2), set(hb(c), 'facec', cc(c,:), 'edgecolor', 'k'); end

figure(14); hold on;
plot(yr, co2_n/1e3, 'go-', 'markersize', 5);
legend('No Policy', 'w/ Policy', 2);
for yn = 1:length(yr)
    text(yr(yn), co2_n(yn)/1e3+0.5, num2str(co2_n(yn)/1e3, '%2.1f'), 'fontsize', 8, 'horizontalalignment', 'center');
end

% my_gridline; export_fig CO2;

