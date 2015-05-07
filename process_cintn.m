clear
close all
clc
format compact

r = {'BJ','TJ','HE','SX','SD','NM','LN','JL','HL','SH','JS','ZJ','AH','FJ','HA','HB','HN','JX','SC','CQ','SN','GS','QH','NX','XJ','GD','GX','YN','GZ','HI'};
yr = [2007,2010,2015,2020,2025,2030];

% stringency = -2:-0.5:-6;
% 
% gdx_collection = { ...
%     'result_cint_n_2.gdx', ...
%     'result_cint_n_25.gdx', ...
%     'result_cint_n_3.gdx', ...
%     'result_cint_n_35.gdx', ...
%     'result_cint_n_4.gdx', ...
%     'result_cint_n_45.gdx', ...
%     'result_cint_n_5.gdx', ...
%     'result_cint_n_55.gdx', ...
%     'result_cint_n_6.gdx', ...
%     };

stringency = -2:-1:-5;

gdx_collection = { ...
    'result_cint_n_2.gdx', ...
    'result_cint_n_3.gdx', ...
    'result_cint_n_4.gdx', ...
    'result_cint_n_5.gdx', ...
    };


color_range = [
    0 0 1
    0 1 1
    0 0.7 0];
color_code = [
    interp1(linspace(1,length(gdx_collection), size(color_range,1)), color_range(:,1), 1:length(gdx_collection))
    interp1(linspace(1,length(gdx_collection), size(color_range,1)), color_range(:,2), 1:length(gdx_collection))
    interp1(linspace(1,length(gdx_collection), size(color_range,1)), color_range(:,3), 1:length(gdx_collection))]';

% cd('exogenous');


%% CO2
figure(1); clf; hold on; box on;

gdx_filename = 'result_default.gdx';
% gdx_filename = 'result_urban_exo.gdx';
co2_chk = getgdx(gdx_filename, 'co2_chk');
co2_chk_n = sum(co2_chk);
h1 = plot(yr, co2_chk_n/1e3, 'ks-', 'markersize', 7, 'linewidth', 1);
% ====================
for f = 1:length(gdx_collection)
    gdx_filename = gdx_collection{f};
    co2_chk = getgdx(gdx_filename, 'co2_chk');
    co2_chk_n = sum(co2_chk);
    h(f) = plot(yr, co2_chk_n/1e3, 'x-', 'markersize', 5, 'linewidth', 1, 'color', color_code(f,:));
end
% ====================
gdx_filename = 'result_egyint_n.gdx';
co2_chk = getgdx(gdx_filename, 'co2_chk');
co2_chk_n = sum(co2_chk);
h2 = plot(yr, co2_chk_n/1e3, 'o-', 'markersize', 7, 'linewidth', 1, 'color', [1 0.65 0]);
% ====================
set(gcf, 'unit', 'inch', 'pos', [0.15    7.35    4.0000    3.0000]);
set(gca, 'fontsize', 10);
xlim([2010 2030]);
ylim([0 20]);
set(gca, 'ytick', 0:5:20);
ylabel('CO_2 (Gt)', 'Fontsize', 12, 'fontweight', 'bold');
grid on;

% legend([h1, h2, h(1), h(5), h(9)], 'Business as Usual', 'Action Plan', '2% Red. in CO2 Intensity', '4% Red. in CO2 Intensity', '6% Red. in CO2 Intensity');
% set(legend, 'fontsize', 9, 'pos', [0.138    0.12    0.5228    0.2724]);

text(2010.5, 18.5, {'(China^\primes latest target: CO2 peaks around 2030)'}, 'fontsize', 8, 'color', 'k', 'verticalalignment', 'bottom');

% export_fig('CO2', '-painters');


%% CO2 intensity
figure(2); clf; hold on; box on;

gdx_filename = 'result_default.gdx';
% gdx_filename = 'result_urban_exo.gdx';
co2_intensity_n = getgdx(gdx_filename, 'co2_intensity_n');
h1 = plot(yr, co2_intensity_n, 'ks-', 'markersize', 7, 'linewidth', 1);
% ====================
for f = 1:length(gdx_collection)
    gdx_filename = gdx_collection{f};
    co2_intensity_n = getgdx(gdx_filename, 'co2_intensity_n');
    h(f) = plot(yr, co2_intensity_n, 'x-', 'markersize', 5, 'linewidth', 1, 'color', color_code(f,:));
end
% ====================
gdx_filename = 'result_egyint_n.gdx';
co2_intensity_n = getgdx(gdx_filename, 'co2_intensity_n');
h2 = plot(yr, co2_intensity_n, 'o-', 'markersize', 7, 'linewidth', 1, 'color', [1 0.65 0]);
% ====================
set(gcf, 'unit', 'inch', 'pos', [4.35    7.35    4.0000    3.0000]);
set(gca, 'fontsize', 10);
xlim([2010 2030]);
ylim([0 1.8]);
set(gca, 'ytick', 0:0.3:1.8);
ylabel('CO2 Intensity (ton/k$)', 'Fontsize', 12, 'fontweight', 'bold');
grid on;

% legend([h1, h2, h(1), h(5), h(9)], 'Business as Usual', 'Action Plan', '2% Red. in CO2 Intensity', '4% Red. in CO2 Intensity', '6% Red. in CO2 Intensity');
% set(legend, 'fontsize', 9, 'pos', [0.138    0.12    0.5228    0.2724]);

% export_fig CO2_intensity;


%% Energy intensity
figure(3); clf; hold on; box on;

gdx_filename = 'result_default.gdx';
% gdx_filename = 'result_urban_exo.gdx';
egy_intensity_n = getgdx(gdx_filename, 'egy_intensity_n');
h1 = plot(yr, egy_intensity_n, 'ks-', 'markersize', 7, 'linewidth', 1);
% ====================
for f = 1:length(gdx_collection)
    gdx_filename = gdx_collection{f};
    egy_intensity_n = getgdx(gdx_filename, 'egy_intensity_n');
    h(f) = plot(yr, egy_intensity_n, 'x-', 'markersize', 5, 'linewidth', 1, 'color', color_code(f,:));
end
% ====================
gdx_filename = 'result_egyint_n.gdx';
egy_intensity_n = getgdx(gdx_filename, 'egy_intensity_n');
h2 = plot(yr, egy_intensity_n, 'o-', 'markersize', 7, 'linewidth', 1, 'color', [1 0.65 0]);
% ====================
set(gcf, 'unit', 'inch', 'pos', [8.55    7.35    4.0000    3.0000]);
set(gca, 'fontsize', 10);
xlim([2010 2030]);
ylim([0 0.8]);
ylabel('Energy Intensity (tce/k$)', 'fontsize', 12, 'fontweight', 'bold');
grid on;

% legend([h1, h2, h(1), h(5), h(9)], 'Business as Usual', 'Action Plan', '2% Red. in CO2 Intensity', '4% Red. in CO2 Intensity', '6% Red. in CO2 Intensity');
% set(legend, 'fontsize', 9, 'pos', [0.138    0.12    0.5228    0.2724]);

% export_fig EGY_intensity -painters;


%% GDP
figure(4); clf; hold on; box on;

gdx_filename = 'result_default.gdx';
% gdx_filename = 'result_urban_exo.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
h1  = plot(yr, GDP_n, 'ks-', 'markersize', 7, 'linewidth', 1);
% ====================
for f = 1:length(gdx_collection)
    gdx_filename = gdx_collection{f};
    [report, report_id] = getgdx(gdx_filename, 'report');
    GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
    GDP_n = sum(GDP,2);
    h(f) = plot(yr, GDP_n, 'x-', 'markersize', 5, 'linewidth', 1, 'color', color_code(f,:));
end
% ====================
gdx_filename = 'result_egyint_n.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
h2 = plot(yr, GDP_n, 'o-', 'markersize', 7, 'linewidth', 1, 'color', [1 0.65 0]);
% ====================
set(gcf, 'unit', 'inch', 'pos', [12.7705    7.35    4.0000    3.0000]);
set(gca, 'fontsize', 10);
xlim([2010 2030]);
ylim([0 16000]);
ylabel('GDP (Billion USD in 2007 value)', 'Fontsize', 12, 'fontweight', 'bold');
grid on;

% legend([h1, h2, h(1), h(5), h(9)], 'Business as Usual', 'Action Plan', '2% Red. in CO2 Intensity', '4% Red. in CO2 Intensity', '6% Red. in CO2 Intensity');
% set(legend, 'fontsize', 9, 'pos', [0.374    0.12    0.5228    0.2724]);

% export_fig GDP -painters;


%% Coal share
figure(5); clf; hold on; box on;

gdx_filename = 'result_default.gdx';
% gdx_filename = 'result_urban_exo.gdx';
[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);

[report, report_id] = getgdx(gdx_filename, 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
egycons_n = sum(egycons,2);

col_share_n = col_consumption_n./egycons_n;

h1 = plot(yr, col_share_n, 'ks-', 'markersize', 7, 'linewidth', 1);
% ====================
for f = 1:length(gdx_collection)
    gdx_filename = gdx_collection{f};

    [egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
    col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
    col_consumption_n = sum(col_consumption,2);
    
    [report, report_id] = getgdx(gdx_filename, 'report');
    egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
    egycons_n = sum(egycons,2);
    
    col_share_n = col_consumption_n./egycons_n;
    
    h(f) = plot(yr, col_share_n, 'x-', 'markersize', 5, 'linewidth', 1, 'color', color_code(f,:));
end
% ====================
gdx_filename = 'result_egyint_n.gdx';
[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);

[report, report_id] = getgdx(gdx_filename, 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30));
egycons_n = sum(egycons,2);

col_share_n = col_consumption_n./egycons_n;

h2 = plot(yr, col_share_n, 'o-', 'markersize', 7, 'linewidth', 1, 'color', [1 0.65 0]);
% ====================
set(gcf, 'unit', 'inch', 'pos', [20.1354    6.9167    4.0000    3.0000]);
set(gca, 'fontsize', 10);
ylim([0 0.8]);
xlim([2010 2030]);
ylabel('Coal Share (-)', 'Fontsize', 12, 'fontweight', 'bold');
grid on;

% legend([h1, h2, h(1), h(5), h(9)], 'Business as Usual', 'Action Plan', '2% Red. in CO2 Intensity', '4% Red. in CO2 Intensity', '6% Red. in CO2 Intensity');
% set(legend, 'fontsize', 9, 'pos', [0.138    0.12    0.5228    0.2724]);

line([2005 2030], [1 1]*0.65, 'linestyle', '--', 'color', [0.4 0.4 0.4]);
text(2010.75, 0.52, {'Action Plan Target:', 'Coal Share below 65% by 2017'}, 'fontsize', 8, 'color', [0.4 0.4 0.4], 'verticalalignment', 'top');

axx=[2011.5 2011]+0.2;
axy=[0.525 0.65];
[arrowx,arrowy] = dsxy2figxy(gca, axx, axy);
annotation('arrow',arrowx,arrowy,'headwidth',5,'headlength',5, 'color', [0.4 0.4 0.4]);

% export_fig coal_share -painters;


%% Oil share
figure(6); clf; hold on; box on;

gdx_filename = 'result_default.gdx';
% gdx_filename = 'result_urban_exo.gdx';
[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
oil_consumption = squeeze(egyreport2(1,:,strcmp('OIL', egyreport2_id{3}),1:30));
oil_consumption_n = sum(oil_consumption,2);

[report, report_id] = getgdx(gdx_filename, 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
egycons_n = sum(egycons,2);

oil_share_n = oil_consumption_n./egycons_n;

h1 = plot(yr, oil_share_n, 'ks-', 'markersize', 7, 'linewidth', 1);
% ====================
for f = 1:length(gdx_collection)
    gdx_filename = gdx_collection{f};
    
    [egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
    oil_consumption = squeeze(egyreport2(1,:,strcmp('OIL', egyreport2_id{3}),1:30));
    oil_consumption_n = sum(oil_consumption,2);
    
    [report, report_id] = getgdx(gdx_filename, 'report');
    egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
    egycons_n = sum(egycons,2);
    
    oil_share_n = oil_consumption_n./egycons_n;
    
    h(f) = plot(yr, oil_share_n, 'x-', 'markersize', 5, 'linewidth', 1, 'color', color_code(f,:));
end
% ====================
gdx_filename = 'result_egyint_n.gdx';
[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
oil_consumption = squeeze(egyreport2(1,:,strcmp('OIL', egyreport2_id{3}),1:30));
oil_consumption_n = sum(oil_consumption,2);

[report, report_id] = getgdx(gdx_filename, 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
egycons_n = sum(egycons,2);

oil_share_n = oil_consumption_n./egycons_n;

h2 = plot(yr, oil_share_n, 'o-', 'markersize', 7, 'linewidth', 1, 'color', [1 0.65 0]);
% ====================
set(gcf, 'unit', 'inch', 'pos', [24.3354    6.9167    4.0000    3.0000]);
set(gca, 'fontsize', 10);
ylim([0 0.8]);
xlim([2010 2030]);
ylabel('Oil Share (-)', 'Fontsize', 12, 'fontweight', 'bold');
grid on;

% legend([h1, h2, h(1), h(5), h(9)], 'Business as Usual', 'Action Plan', '2% Red. in CO2 Intensity', '4% Red. in CO2 Intensity', '6% Red. in CO2 Intensity');
% set(legend, 'fontsize', 9, 'pos', [0.138    0.64    0.5228    0.2724]);

% export_fig oil_share -painters;


%% Gas share
figure(7); clf; hold on; box on;

gdx_filename = 'result_default.gdx';
% gdx_filename = 'result_urban_exo.gdx';
[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
gas_consumption = squeeze(egyreport2(1,:,strcmp('GAS', egyreport2_id{3}),1:30));
gas_consumption_n = sum(gas_consumption,2);

[report, report_id] = getgdx(gdx_filename, 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
egycons_n = sum(egycons,2);

gas_share_n = gas_consumption_n./egycons_n;

aa = squeeze(egyreport2);
bb = aa(:,:,end);
cc = sum(bb,2);
gas_share_n_2 = gas_consumption_n./cc

h1 = plot(yr, gas_share_n, 'ks-', 'markersize', 7, 'linewidth', 1);
% ====================
for f = 1:length(gdx_collection)
    gdx_filename = gdx_collection{f};
    
    [egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
    gas_consumption = squeeze(egyreport2(1,:,strcmp('GAS', egyreport2_id{3}),1:30));
    gas_consumption_n = sum(gas_consumption,2);
    
    [report, report_id] = getgdx(gdx_filename, 'report');
    egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
    egycons_n = sum(egycons,2);
    
    gas_share_n = gas_consumption_n./egycons_n;

    h(f) = plot(yr, gas_share_n, 'x-', 'markersize', 5, 'linewidth', 1, 'color', color_code(f,:));
end
% ====================
gdx_filename = 'result_egyint_n.gdx';
[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
gas_consumption = squeeze(egyreport2(1,:,strcmp('GAS', egyreport2_id{3}),1:30));
gas_consumption_n = sum(gas_consumption,2);

[report, report_id] = getgdx(gdx_filename, 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
egycons_n = sum(egycons,2);

gas_share_n = gas_consumption_n./egycons_n;

h2 = plot(yr, gas_share_n, 'o-', 'markersize', 7, 'linewidth', 1, 'color', [1 0.65 0]);
% ====================
set(gcf, 'unit', 'inch', 'pos', [28.5354    6.9167    4.0000    3.0000]);
set(gca, 'fontsize', 10);
ylim([0 0.8]);
xlim([2010 2030]);
ylabel('Gas Share (-)', 'Fontsize', 12, 'fontweight', 'bold');
grid on;

% legend([h1, h2, h(1), h(5), h(9)], 'Business as Usual', 'Action Plan', '2% Red. in CO2 Intensity', '4% Red. in CO2 Intensity', '6% Red. in CO2 Intensity');
% set(legend, 'fontsize', 9, 'pos', [0.138    0.64    0.5228    0.2724]);

% export_fig gas_share -painters;

% ylim([0 0.05]);
% set(legend, 'fontsize', 9, 'pos', [0.138    0.12    0.5228    0.2724]);


%% NHW share
figure(8); clf; hold on; box on;

gdx_filename = 'result_default.gdx';
% gdx_filename = 'result_urban_exo.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
nhw_share = squeeze(report(strcmp('nhw_share', report_id{1}),:,strcmp('CHN', report_id{3})));
h1 = plot(yr, nhw_share, 'ks-', 'markersize', 7, 'linewidth', 1);
% ====================
gdx_filename = 'result_egyint_n.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
nhw_share = squeeze(report(strcmp('nhw_share', report_id{1}),:,strcmp('CHN', report_id{3})));
h2 = plot(yr, nhw_share, 'o-', 'markersize', 7, 'linewidth', 1, 'color', [1 0.65 0]);
% ====================
for f = 1:length(gdx_collection)
    gdx_filename = gdx_collection{f};
    [report, report_id] = getgdx(gdx_filename, 'report');
    nhw_share = squeeze(report(strcmp('nhw_share', report_id{1}),:,strcmp('CHN', report_id{3})));
    h(f) = plot(yr, nhw_share, 'x-', 'markersize', 5, 'linewidth', 1, 'color', color_code(f,:));
end
% ====================
set(gcf, 'unit', 'inch', 'pos', [32.7354    6.9167    4.0000    3.0000]);
set(gca, 'fontsize', 10);
ylim([0 0.8]);
xlim([2010 2030]);
ylabel('Non-Fossil Fuel Share (-)', 'Fontsize', 12, 'fontweight', 'bold');
grid on;

% legend([h1, h2, h(1), h(5), h(9)], 'Business as Usual', 'Action Plan', '2% Red. in CO2 Intensity', '4% Red. in CO2 Intensity', '6% Red. in CO2 Intensity');
% set(legend, 'fontsize', 9, 'pos', [0.138    0.64   0.5228    0.2724]);

line([2005 2030], [1 1]*0.2, 'linestyle', '--', 'color', [0.4 0.4 0.4]);
text(2010.75, 0.25, {'China\primes latest target: non-fossil fuel share', ' higher than 20% by 2030'}, 'fontsize', 8, 'color', [0.4 0.4 0.4]);

% export_fig nhw_share -r300 -painters;


%% energy consumption
figure(9); clf; hold on; box on;

[report, report_id] = getgdx('result_default.gdx', 'report');
% [report, report_id] = getgdx('result_urban_exo.gdx', 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
egycons_n = sum(egycons,2);
h1 = plot(yr, egycons_n, 'ks-', 'markersize', 7, 'linewidth', 1);
% ====================
for f = 1:length(gdx_collection)
    gdx_filename = gdx_collection{f};
    [report, report_id] = getgdx(gdx_filename, 'report');
    egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
    egycons_n = sum(egycons,2);
    h(f) = plot(yr, egycons_n, 'x-', 'markersize', 5, 'linewidth', 1, 'color', color_code(f,:));
end
% ====================
[report, report_id] = getgdx('result_egyint_n.gdx', 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
egycons_n = sum(egycons,2);
h2 = plot(yr, egycons_n, 'o-', 'markersize', 7, 'linewidth', 1, 'color', [1 0.65 0]);
% ====================
set(gcf, 'unit', 'inch', 'pos', [20.1354   2.9    4.0000    3.0000]);
set(gca, 'fontsize', 10);
xlim([2010 2030]);
ylim([0 9000]);
set(gca, 'ytick', 0:1500:9000);
ylabel('Energy Consumption (mtce)', 'fontsize', 12, 'fontweight', 'bold');

% legend([h1, h2, h(1), h(5), h(9)], 'Business as Usual', 'Action Plan', '2% Red. in CO2 Intensity', '4% Red. in CO2 Intensity', '6% Red. in CO2 Intensity');
% set(legend, 'fontsize', 9, 'pos', [0.1562    0.1226    0.5228    0.2724]);

my_gridline;

% export_fig EGY_consumption -painters;


%% energy consumption by type
figure(10); clf; hold on; box on;
gdx_filename = 'result_default.gdx';
% gdx_filename = 'result_urban_exo';
[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
gas_consumption = squeeze(egyreport2(1,:,strcmp('GAS', egyreport2_id{3}),1:30));
gas_consumption_n = sum(gas_consumption,2);
oil_consumption = squeeze(egyreport2(1,:,strcmp('OIL', egyreport2_id{3}),1:30));
oil_consumption_n = sum(oil_consumption,2);
nhw_consumption = squeeze(egyreport2(1,:,strcmp('NHW', egyreport2_id{3}),1:30))/0.12*0.356;
nhw_consumption_n = sum(nhw_consumption,2);
ha = area(yr, [col_consumption_n, gas_consumption_n, oil_consumption_n, nhw_consumption_n], 'linestyle', 'none');
set(ha(1), 'facec', [1 0 0]);
set(ha(2), 'facec', [1 1 0]);
set(ha(3), 'facec', [1 0.6 0.6]);
set(ha(4), 'facec', [0.6 1 0]);

text(2028, mean(col_consumption_n(end-1:end)/2), 'Coal', 'fontsize', 8, 'horizontalalignment', 'center');
text(2028, mean(col_consumption_n(end-1:end)+gas_consumption_n(end-1:end)/2), 'Gas', 'fontsize', 8, 'horizontalalignment', 'center');
text(2028, mean(col_consumption_n(end-1:end)+gas_consumption_n(end-1:end)+oil_consumption_n(end-1:end)/2), 'Oil', 'fontsize', 8, 'horizontalalignment', 'center');
text(2028, mean(col_consumption_n(end-1:end)+gas_consumption_n(end-1:end)+oil_consumption_n(end-1:end)+nhw_consumption_n(end-1:end)/2), 'Non-Fossil', 'fontsize', 8, 'horizontalalignment', 'center');

set(gcf, 'unit', 'inch', 'pos', [24.3354   2.9    4.0000    3.0000]);
set(gca, 'fontsize', 10);
xlim([2010 2030]);
ylim([0 9000]);
set(gca, 'layer', 'top');
my_gridline('front');
ylabel('Energy Consumption (mtce)', 'fontsize', 12, 'fontweight', 'bold');
title('Business as Usual');

% export_fig egy_area;

%% ====================
figure(11); clf; hold on; box on;
gdx_filename = 'result_egyint_n';
[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
gas_consumption = squeeze(egyreport2(1,:,strcmp('GAS', egyreport2_id{3}),1:30));
gas_consumption_n = sum(gas_consumption,2);
oil_consumption = squeeze(egyreport2(1,:,strcmp('OIL', egyreport2_id{3}),1:30));
oil_consumption_n = sum(oil_consumption,2);
nhw_consumption = squeeze(egyreport2(1,:,strcmp('NHW', egyreport2_id{3}),1:30))/0.12*0.356;
nhw_consumption_n = sum(nhw_consumption,2);
ha = area(yr, [col_consumption_n, gas_consumption_n, oil_consumption_n, nhw_consumption_n], 'linestyle', 'none');
set(ha(1), 'facec', [1 0 0]);
set(ha(2), 'facec', [1 1 0]);
set(ha(3), 'facec', [1 0.6 0.6]);
set(ha(4), 'facec', [0.6 1 0]);

text(2028, mean(col_consumption_n(end-1:end)/2), 'Coal', 'fontsize', 8, 'horizontalalignment', 'center');
text(2028, mean(col_consumption_n(end-1:end)+gas_consumption_n(end-1:end)/2), 'Gas', 'fontsize', 8, 'horizontalalignment', 'center');
text(2028, mean(col_consumption_n(end-1:end)+gas_consumption_n(end-1:end)+oil_consumption_n(end-1:end)/2), 'Oil', 'fontsize', 8, 'horizontalalignment', 'center');
text(2028, mean(col_consumption_n(end-1:end)+gas_consumption_n(end-1:end)+oil_consumption_n(end-1:end)+nhw_consumption_n(end-1:end)/2), 'Non-Fossil', 'fontsize', 8, 'horizontalalignment', 'center');

set(gcf, 'unit', 'inch', 'pos', [28.5354   2.9    4.0000    3.0000]);
set(gca, 'fontsize', 10);
xlim([2010 2030]);
ylim([0 9000]);
set(gca, 'layer', 'top');
my_gridline('front');
title('Action Plan', 'color', [1 0.65 0]);

%% ====================
figure(12); clf; hold on; box on;
gdx_filename = 'result_cint_n_4.gdx';
[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
gas_consumption = squeeze(egyreport2(1,:,strcmp('GAS', egyreport2_id{3}),1:30));
gas_consumption_n = sum(gas_consumption,2);
oil_consumption = squeeze(egyreport2(1,:,strcmp('OIL', egyreport2_id{3}),1:30));
oil_consumption_n = sum(oil_consumption,2);
nhw_consumption = squeeze(egyreport2(1,:,strcmp('NHW', egyreport2_id{3}),1:30))/0.12*0.356;
nhw_consumption_n = sum(nhw_consumption,2);
ha = area(yr, [col_consumption_n, gas_consumption_n, oil_consumption_n, nhw_consumption_n], 'linestyle', 'none');
set(ha(1), 'facec', [1 0 0]);
set(ha(2), 'facec', [1 1 0]);
set(ha(3), 'facec', [1 0.6 0.6]);
set(ha(4), 'facec', [0.6 1 0]);

text(2028, mean(col_consumption_n(end-1:end)/2), 'Coal', 'fontsize', 8, 'horizontalalignment', 'center');
text(2028, mean(col_consumption_n(end-1:end)+gas_consumption_n(end-1:end)/2), 'Gas', 'fontsize', 8, 'horizontalalignment', 'center');
text(2028, mean(col_consumption_n(end-1:end)+gas_consumption_n(end-1:end)+oil_consumption_n(end-1:end)/2), 'Oil', 'fontsize', 8, 'horizontalalignment', 'center');
text(2028, mean(col_consumption_n(end-1:end)+gas_consumption_n(end-1:end)+oil_consumption_n(end-1:end)+nhw_consumption_n(end-1:end)/2), 'Non-Fossil', 'fontsize', 8, 'horizontalalignment', 'center');

set(gcf, 'unit', 'inch', 'pos', [32.7354   2.9    4.0000    3.0000]);
set(gca, 'fontsize', 10);
xlim([2010 2030]);
ylim([0 9000]);
set(gca, 'layer', 'top');
my_gridline('front');
title('4% Reduction in CO2 Intensity (per annum)', 'color', [0 1 1]);


%% urban emissions
fini = 10;
gdx_filename = 'result_default.gdx';
% gdx_filename = 'result_urban_exo.gdx';
[urban, urban_id] = getgdx(gdx_filename, 'urban');
urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
for i = 1:length(urban_id{1})%[3,4,8,9]
    urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
    urban_CHN(i,:) = sum(urban_extract);
    
    figure(fini+i); clf; box on;
    h1 = plot(yr, urban_CHN(i,:), 'ks-', 'markersize', 7, 'linewidth', 1);
    set(gca, 'fontsize', 10);
    ylabel([char(cellstr(urban_id{1}(i))), ' (Tg)'], 'fontsize', 12, 'fontweight', 'bold');
    
    set(gcf, 'unit', 'inch', 'pos', [0.25+4.15*(i-1)    3.2    4.0000    3.0000]);
%     set(gcf, 'unit', 'inch', 'pos', [0.25+0.15*(i-1)    3.2    4.0000    3.0000]);
    xlim([2010 2030]);
    grid on;
    
%     if i == 1, ylim([0 3]); end
%     if i == 2, ylim([0 500]); end
%     if i == 3, ylim([0 30]); end
%     if i == 4, ylim([0 80]); end
%     if i == 5, ylim([0 6]); end
%     if i == 6, ylim([0 55]); end
%     if i == 7, ylim([0 40]); end
%     if i == 8, ylim([0 70]); end
%     if i == 9, ylim([0 60]); end
end

% ==========
for f = 1:length(gdx_collection)
    gdx_filename = gdx_collection{f};
    
    [urban, urban_id] = getgdx(gdx_filename, 'urban');
    urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
    for i = 1:length(urban_id{1})%[3,4,8,9]
        urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
        urban_CHN(i,:) = sum(urban_extract);
        
        figure(fini+i); hold on; box on;
        h(f) = plot(yr, urban_CHN(i,:), 'x-', 'markersize', 5, 'linewidth', 1, 'color', color_code(f,:));

        export_filename = ['fig_', char(urban_id{1}(i))];
        %export_fig(export_filename);
    end
end

% ==========
gdx_filename = 'result_egyint_n.gdx';
[urban, urban_id] = getgdx(gdx_filename, 'urban');
urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
for i = 1:length(urban_id{1})%[3,4,8,9]
    urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
    urban_CHN(i,:) = sum(urban_extract);
    
    figure(fini+i); hold on; box on;
    h2 = plot(yr, urban_CHN(i,:), 'o-', 'markersize', 7, 'linewidth', 1, 'color', [1 0.65 0]);
    
%     legend([h1, h2, h(1), h(5), h(9)], 'Business as Usual', 'Action Plan', '2% Red. in CO2 Intensity', '4% Red. in CO2 Intensity', '6% Red. in CO2 Intensity');
    % set(legend, 'fontsize', 9, 'pos', [0.137    0.64    0.5228    0.2724]);
    % set(legend, 'fontsize', 9, 'pos', [0.137    0.1226    0.5228    0.2724]);

    export_filename = ['fig_', char(urban_id{1}(i))];
%     export_fig(export_filename, '-painters');
end


%% Return of CO2 policy
% figure(100+i); hold on;
% plot(stringency(f), urban_CHN(i,end)/urban_CHN(i,2), 'x', 'color', color_code(f,:));
% title([char(cellstr(urban_id{1}(i))),], 'fontsize', 12, 'fontweight', 'bold');
% ylim([0 2]);
% defaultratio;
% grid on;
% xlabel('CO2 Intensity Stringency (% Red. per year)');
% ylabel('Level of 2030/2010');
% 



