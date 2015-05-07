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
plot(yr, co2_chk_n/1e3, 'k^-', 'markersize', 7, 'linewidth', 1);

% ==========
gdx_filename = 'result_egyint_n.gdx';
co2_chk = getgdx(gdx_filename, 'co2_chk');
co2_chk_n = sum(co2_chk);
plot(yr, co2_chk_n/1e3, 'ro-', 'markersize', 7, 'linewidth', 1);

legend('BAU', 'POL');
set(legend, 'fontsize', 9, 'location', 'northwest');
set(gca, 'fontsize', 10);
ylabel('CO2 (Gt)', 'Fontsize', 12, 'fontweight', 'bold');
set(gcf, 'unit', 'inch', 'pos', [0.15    7.35    4.0000    3.0000]);
ylim([0 20]);
set(gca, 'ytick', 0:5:20);
grid on;

text(2006, 0.75, {'(China^\primes latest target: CO2 peaks around 2030)'}, 'fontsize', 8, 'color', [0.4 0.4 0.4], 'verticalalignment', 'bottom');

% export_fig CO2 -painters;


%% CO2 intensity
figure(2); clf; hold on; box on;

gdx_filename = 'result_urban_exo.gdx';
co2_chk = getgdx(gdx_filename, 'co2_chk');
co2_chk_n = sum(co2_chk);
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
co2_int = co2_chk_n'./GDP_n;

plot(yr, co2_int, 'k^-', 'markersize', 7, 'linewidth', 1);

% ==========
gdx_filename = 'result_egyint_n.gdx';
co2_chk = getgdx(gdx_filename, 'co2_chk');
co2_chk_n = sum(co2_chk);
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
co2_int = co2_chk_n'./GDP_n;
pctg = 1-(co2_int(2:end)./co2_int(1:end-1));

plot(yr, co2_int, 'ro-', 'markersize', 7, 'linewidth', 1);

ylim([0 1.8]);
set(gca, 'ytick', 0:0.3:1.8);
set(gca, 'fontsize', 10);
ylabel('CO2 Intensity (ton/1000 USD)', 'Fontsize', 12, 'fontweight', 'bold');
legend('BAU', 'POL');
set(legend, 'fontsize', 9, 'location', 'southwest');
set(gcf, 'unit', 'inch', 'pos', [4.35    7.35    4.0000    3.0000]);
grid on;

% export_fig CO2_intensity;


%% energy consumption
figure(3); clf; hold on; box on;

[report, report_id] = getgdx('result_urban_exo.gdx', 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
egycons_n = sum(egycons,2);
plot(yr, egycons_n, 'k^-', 'markersize', 7, 'linewidth', 1);

[report, report_id] = getgdx('result_egyint_n.gdx', 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
egycons_n = sum(egycons,2);
plot(yr, egycons_n, 'ro-', 'markersize', 7, 'linewidth', 1);

ylim([0 9000]);
set(gca, 'ytick', 0:1500:9000);
set(gca, 'fontsize', 10);
ylabel('Energy Consumption (mtce)', 'fontsize', 12, 'fontweight', 'bold');
legend('BAL', 'POL');
set(legend, 'location', 'northwest');
set(gcf, 'unit', 'inch', 'pos', [8.55    7.35    4.0000    3.0000]);
my_gridline;
% export_fig EGY_consumption -painters;


%% Energy intensity
figure(4); clf; hold on; box on;

gdx_filename = 'result_urban_exo.gdx';
egy_intensity_n = getgdx(gdx_filename, 'egy_intensity_n');
plot(yr, egy_intensity_n, 'k^-', 'markersize', 7, 'linewidth', 1);

gdx_filename = 'result_egyint_n.gdx';
egy_intensity_n = getgdx(gdx_filename, 'egy_intensity_n');
pctg = (1-egy_intensity_n(2:end)./egy_intensity_n(1:end-1))';
plot(yr, egy_intensity_n, 'ro-', 'markersize', 7, 'linewidth', 1);

pctg(2:3) = 0.2;
for i = 3:6, text(yr(i), egy_intensity_n(i)-0.04, [num2str(-pctg(i-1)*100, '%2.0f'), '%'], 'fontsize', 8, 'horizontalalignment', 'center', 'color', 'r'); end

ylim([0 0.8]);
set(gcf, 'unit', 'inch', 'pos', [12.75    7.35    4.0000    3.0000]);
set(gca, 'fontsize', 10);
ylabel('Energy Intensity (tce/1000 USD)', 'fontsize', 12, 'fontweight', 'bold');
legend('BAL', 'POL');
set(legend, 'location', 'southwest');
grid on;
% export_fig EGY_intensity -painters;


%% Coal consumption
figure(5); clf; hold on; box on;

yr = [2007,2010,2015,2020,2025,2030];
[egyreport2, egyreport2_id] = getgdx('result_urban_exo', 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
plot(yr, col_consumption_n, 'k^-', 'markersize', 7, 'linewidth', 1);
col_consumption_n_BAU = col_consumption_n;

[egyreport2, egyreport2_id] = getgdx('result_egyint_n', 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
plot(yr, col_consumption_n, 'ro-', 'markersize', 7, 'linewidth', 1);
col_consumption_n_AP = col_consumption_n;

ylim([0 6000]);
set(gca, 'fontsize', 10);
ylabel('Coal Consumption (mtce)', 'fontsize', 12, 'fontweight', 'bold');
legend('BAL', 'POL');
set(legend, 'location', 'southwest');
set(gcf, 'unit', 'inch', 'pos', [20.15    7.05    4.0000    3.0000]);
grid on;
% export_fig coal -painters;


% Coal consumption varification; http://cleantechnica.com/2014/08/26/chinas-coal-consumption-finally-decreased/
coal_web_data = [
2000	100.000
2001	102.326
2002	106.047
2003	128.372
2004	145.116
2005	163.721
2006	180.465
2007	197.209
2008	200.93
2009	215.000
2010	217.674
2011	238.14
2012	241.86
2013	249.302
2014	249.302
];

ratio = col_consumption_n_BAU(1)/coal_web_data(8,2);
figure(51); clf; hold on; box on;
plot(coal_web_data(:,1), coal_web_data(:,2), 'o-', 'color', [0.3 0.65 1], 'markersize', 4, 'markerf', [0.3 0.65 1], 'linewidth', 1);
plot(yr, col_consumption_n_BAU/ratio, 'k^-');
plot(yr, col_consumption_n_AP/ratio, 'ro-');

set(gcf, 'unit', 'inch', 'pos', [24.35    7.05    4.0000    3.0000]);
ylabel('Coal Consumption (normalized, 2000 = 100)');
legend('data from web', 'BAU', 'POL');
set(legend, 'location', 'northwest');
grid on;

% export_fig coal_compare -painters;


%% GDP
figure(7); clf; hold on; box on;

gdx_filename = 'result_urban_exo.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
h1  = plot(yr, GDP_n, 'k^-', 'markersize', 7, 'linewidth', 1);
GDP_n_BAU = GDP_n;

% ==============================
gdx_filename = 'result_egyint_n.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
h2 = plot(yr, GDP_n, 'ro-', 'markersize', 7, 'linewidth', 1);

GDP_n_AP = GDP_n;

pctg = GDP_n(end)/GDP_n_BAU(end) - 1;
text(yr(end), GDP_n(end)-800, [num2str(pctg*100, '%2.0f'), '%'], 'fontsize', 8, 'horizontalalignment', 'center', 'color', 'r'); 
text(yr(end), GDP_n(end)-2100, {'(relative to', ' No Policy)'}, 'fontsize', 7, 'horizontalalignment', 'center', 'color', 'r'); 

ylim([0 16000]);
set(gca, 'fontsize', 10);
ylabel('GDP (Billion USD in 2007 value)', 'Fontsize', 12, 'fontweight', 'bold');
set(gcf, 'unit', 'inch', 'pos', [28.55    7.05    4.0000    3.0000]);
legend('BAU', 'POL');
set(legend, 'location', 'northwest');
grid on;

% export_fig GDP -painters;

% ==============================
% GDP varification; http://cleantechnica.com/2014/08/26/chinas-coal-consumption-finally-decreased/
GDP_web_data = [
2000	100.000 % normalized, 2000 = 100
2001	107.907
2002	117.209
2003	130.233
2004	141.395
2005	156.279
2006	178.605
2007	201.780
2008	223.256
2009	247.442
2010	271.628
2011	295.814
2012	318.140
2013	346.047
2014	370.233
];

ratio = GDP_n_BAU(1)/GDP_web_data(8,2);
figure(71); clf; hold on; box on;
plot(GDP_web_data(:,1), GDP_web_data(:,2), 'o-', 'color', [0.3 0.65 1], 'markersize', 4, 'markerf', [0.3 0.65 1], 'linewidth', 1);
plot(yr, GDP_n_BAU/ratio, 'k^-');
plot(yr, GDP_n_AP/ratio, 'ro-');

ylabel('GDP (normalized, 2000 = 100)');
set(gcf, 'unit', 'inch', 'pos', [32.75    7.05    4.0000    3.0000]);
legend('data from web', 'BAU', 'POL');
set(legend, 'location', 'northwest');
grid on;
% export_fig GDP_compare -painters;


%% coal share
gdx_filename = 'result_urban_exo.gdx';
[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);

[report, report_id] = getgdx(gdx_filename, 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
egycons_n = sum(egycons,2);

col_share_n = col_consumption_n./egycons_n;

figure(8); clf;
plot(yr, col_share_n, 'k^-', 'markersize', 7, 'linewidth', 1);

% ==============================
gdx_filename = 'result_egyint_n.gdx';
[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);

[report, report_id] = getgdx(gdx_filename, 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
egycons_n = sum(egycons,2);

col_share_n = col_consumption_n./egycons_n; % national coal share

figure(8); hold on;
plot(yr, col_share_n, 'ro-', 'markersize', 7, 'linewidth', 1);

set(gcf, 'unit', 'inch', 'pos', [4.5833    5.9167    4.0000    3.0000]);
set(gca, 'fontsize', 10);
ylabel('Coal Share (-)', 'Fontsize', 12, 'fontweight', 'bold');
ylim([0 0.8]);
legend('BAU', 'POL');
set(legend, 'location', 'southwest');
grid on;

line([2005 2030], [1 1]*0.65, 'linestyle', '--', 'color', [0.4 0.4 0.4]);
text(2005.75, 0.64, {'Action Plan Target:', 'Coal Share below 65% by 2017'}, 'fontsize', 8, 'color', [0.4 0.4 0.4], 'verticalalignment', 'top');

% export_fig coal_share -painters;


%% NHW share
gdx_filename = 'result_urban_exo.gdx';
[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
nhw_consumption = squeeze(egyreport2(1,:,strcmp('NHW', egyreport2_id{3}),1:30))/0.12*0.356;
nhw_consumption_n = sum(nhw_consumption,2);

[report, report_id] = getgdx(gdx_filename, 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
egycons_n = sum(egycons,2);

nhw_share_n = nhw_consumption_n./egycons_n;

figure(9); clf;
plot(yr, nhw_share_n, 'k^-', 'markersize', 7, 'linewidth', 1);

% ==============================
gdx_filename = 'result_egyint_n.gdx';
[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
nhw_consumption = squeeze(egyreport2(1,:,strcmp('NHW', egyreport2_id{3}),1:30))/0.12*0.356;
nhw_consumption_n = sum(nhw_consumption,2);

[report, report_id] = getgdx(gdx_filename, 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
egycons_n = sum(egycons,2);

nhw_share_n = nhw_consumption_n./egycons_n;

figure(9); hold on;
plot(yr, nhw_share_n, 'ro-', 'markersize', 7, 'linewidth', 1);

ylim([0 0.8]);
set(gcf, 'unit', 'inch', 'pos', [8.7605    5.9167    4.0000    3.0000]);
set(gca, 'fontsize', 10);
ylabel('Non-Fossil Fuel Share (-)', 'Fontsize', 12, 'fontweight', 'bold');
legend('BAU', 'POL');
set(legend, 'location', 'northwest');
grid on;

line([2005 2030], [1 1]*0.2, 'linestyle', '--', 'color', [0.4 0.4 0.4]);
text(2005.75, 0.25, {'China\primes latest target:', 'Non-Fossil Fuel Share higher than 20% by 2030'}, 'fontsize', 8, 'color', [0.4 0.4 0.4]);

% export_fig nhw_share -r300 -painters;


%% urban emissions
gdx_filename = 'result_urban_exo.gdx';
[urban, urban_id] = getgdx(gdx_filename, 'urban');
urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
for i = 1:length(urban_id{1})
    urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
    urban_CHN(i,:) = sum(urban_extract);
    
    figure(9+i); clf; box on;
    plot(yr, urban_CHN(i,:), 'k^-', 'markersize', 7, 'linewidth', 1);
    set(gca, 'fontsize', 10);
    ylabel([char(cellstr(urban_id{1}(i))), ' (Tg)'], 'fontsize', 12, 'fontweight', 'bold');
    
    set(gcf, 'unit', 'inch', 'pos', [0.25+4.15*(i-1)    3.2    4.0000    3.0000]);
    
    if i == 1, ylim([0 3]); end
    if i == 2, ylim([0 500]); end
    if i == 3, ylim([0 30]); end
    if i == 4, ylim([0 80]); end
    if i == 5, ylim([0 6]); end
    if i == 6, ylim([0 55]); end
    if i == 7, ylim([0 40]); end
    if i == 8, ylim([0 70]); end
    if i == 9, ylim([0 65]); end
end

% ==========
gdx_filename = 'result_egyint_n.gdx';
[urban, urban_id] = getgdx(gdx_filename, 'urban');
urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
for i = 1:length(urban_id{1})
    urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
    urban_CHN(i,:) = sum(urban_extract);
    
    figure(9+i); hold on; box on;
    plot(yr, urban_CHN(i,:), 'ro-', 'markersize', 7, 'linewidth', 1);

    if i==1, legend('BAU', 'POL'); set(legend, 'location', 'northwest'); end
    grid on;
    export_filename = ['fig_', char(urban_id{1}(i))];
    %export_fig(export_filename);
end


%% Urban emission breakdown barchart (combustion emission vs. process emission)
[urban_c, urban_c_id] = getgdx('result_urban_exo.gdx', 'urban_c'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[8]x[6]
[urban_o, urban_o_id] = getgdx('result_urban_exo.gdx', 'urban_o'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[11]x[6]
for i = 1:length(urban_c_id{1})
urb_c = squeeze(urban_c(strcmp(urban_c_id{1}(i), urban_c_id{1}),:,:,:)); % [30]x[8]x[6]
urb_c_g = squeeze(sum(urb_c,2)); % [30]x[6]
urb_c_n = sum(urb_c_g); % [1]x[6]

urb_o = squeeze(urban_o(strcmp(urban_o_id{1}(i), urban_o_id{1}),:,:,:)); % [30]x[8]x[6]
urb_o_g = squeeze(sum(urb_o(:,1:end-1,:),2)); % [30]x[6]
urb_o_n = sum(urb_o_g); % [1]x[6]
urb_o_b = squeeze(sum(urb_o(:,end,:))); % biomass burning

figure(i+18); clf; hold on; box on;
hb0 = bar(yr-0.42, [urb_c_n; urb_o_n; urb_o_b']', 0.25, 'stacked', 'edgecolor', 'none');
colormap copper
set(hb0(1), 'facec', [0.5 0 0]); %biomass burning

hb1 = bar(yr-0.42, sum([urb_c_n; urb_o_n; urb_o_b']), 0.25, 'stacked', 'facec', 'none', 'edgecolor', 'k', 'linewidth', 1);

set(gca, 'fontsize', 10);
set(gca, 'layer', 'top');
set(gcf, 'unit', 'inch', 'pos', [0.25+4.15*(i-1)    2.865    4.0000    3.0000]);
set(gca, 'pos', [0.1458    0.1100    0.7722    0.8150]);
set(gca, 'layer', 'bottom');
ylabel([char(cellstr(urban_c_id{1}(i))), ' (Tg)'], 'fontsize', 12, 'fontweight', 'bold');
xlim([2005 2031.5]);
legend(fliplr(hb0), 'Biomass Burning & Other', 'Industrial Process', 'Fossil Fuel Combustion');
set(legend, 'location', 'northwest');
set(legend, 'fontsize', 8);

if i == 1, ylim([0 3]); end
if i == 2, ylim([0 500]); end
if i == 3, ylim([0 30]); end
if i == 4, ylim([0 80]); end
if i == 5, ylim([0 6]); end
if i == 6, ylim([0 55]); end
if i == 7, ylim([0 40]); end
if i == 8, ylim([0 70]); end
if i == 9, ylim([0 65]); end
end

% ==========
[urban_c, urban_c_id] = getgdx('result_egyint_n.gdx', 'urban_c'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[8]x[6]
[urban_o, urban_o_id] = getgdx('result_egyint_n.gdx', 'urban_o'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[10]x[6]
for i = 1:length(urban_c_id{1})
urb_c = squeeze(urban_c(strcmp(urban_c_id{1}(i), urban_c_id{1}),:,:,:)); % [30]x[8]x[6]
urb_c_g = squeeze(sum(urb_c,2)); % [30]x[6]
urb_c_n = sum(urb_c_g); % [1]x[6]

urb_o = squeeze(urban_o(strcmp(urban_o_id{1}(i), urban_o_id{1}),:,:,:)); % [30]x[8]x[6]
urb_o_g = squeeze(sum(urb_o(:,1:end-1,:),2)); % [30]x[6]
urb_o_n = sum(urb_o_g); % [1]x[6]
urb_o_b = squeeze(sum(urb_o(:,end,:))); % biomass burning

figure(i+18); 
hb0 = bar(yr+0.42, [urb_c_n; urb_o_n; urb_o_b']', 0.25, 'stacked', 'edgecolor', 'none');
set(hb0(1), 'facec', [0.5 0 0]); %biomass burning
hb1 = bar(yr+0.42, sum([urb_c_n; urb_o_n; urb_o_b']), 0.25, 'stacked', 'facec', 'none', 'edgecolor', 'r', 'linewidth', 1);

if i == 1
    text(2012.1, 3.15, 'Black: BAU; ', 'fontsize', 8, 'color', 'k');
    text(2018, 3.15, 'Red: POL', 'fontsize', 8, 'color', 'r');
end

file_name = ['bar_', char(cellstr(urban_c_id{1}(i)))];
% export_fig(file_name);

end
