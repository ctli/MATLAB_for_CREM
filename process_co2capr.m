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
gdx_filename = 'result_egyint_n.gdx';
co2_chk = getgdx(gdx_filename, 'co2_chk');
co2_chk_n = sum(co2_chk);
plot(yr, co2_chk_n/1e3, 'o-', 'color', [0 0.8 0], 'markersize', 7, 'linewidth', 1);

% % ==========
% gdx_filename = 'result_ccap_r.gdx';
% co2_chk = getgdx(gdx_filename, 'co2_chk');
% co2_chk_n = sum(co2_chk);
% plot(yr, co2_chk_n/1e3, 'x-', 'color', 'b', 'markersize', 7, 'linewidth', 1);
% pctg = co2_chk_n(2:end)./co2_chk_n(1:end-1) - 1;
% for yn = 3:length(yr), text(yr(yn), co2_chk_n(yn)/1e3-0.85, [num2str(pctg(yn-1)*100, '%2.0f'), '%'], 'fontsize', 8, 'color', 'b', 'horizontalalignment', 'center'); end

legend('No Policy', 'Action Plan', 'Stringent Rgnl CO2 Cap', 2);
set(legend, 'fontsize', 9);
set(gca, 'fontsize', 10);
ylabel('CO2 (Gt)', 'Fontsize', 12, 'fontweight', 'bold');
set(gcf, 'unit', 'inch', 'pos', [0.15    7.35    4.0000    3.0000]);
ylim([0 20]);
set(gca, 'ytick', 0:5:20);

text(2006, 0.75, {'China\primes latest target: CO2 peaks around 2030'}, 'fontsize', 7, 'color', 'b', 'verticalalignment', 'bottom');

my_gridline;
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

plot(yr, co2_int, '^-', 'markersize', 7, 'color', [0.5 0.5 0.5], 'linewidth', 1);

% ==========
gdx_filename = 'result_egyint_n.gdx';
co2_chk = getgdx(gdx_filename, 'co2_chk');
co2_chk_n = sum(co2_chk);
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
co2_int = co2_chk_n'./GDP_n;
pctg = 1-(co2_int(2:end)./co2_int(1:end-1));

plot(yr, co2_int, 'o-', 'color', [0 0.6 0], 'markersize', 7, 'linewidth', 1);
for i = 3:4, text(yr(i)+1.75, co2_int(i), [num2str(-pctg(i-1)*100, '%2.0f'), '%'], 'fontsize', 8, 'horizontalalignment', 'center', 'color', [0 0.6 0]); end

% % ==========
% gdx_filename = 'result_ccap_r.gdx';
% co2_chk = getgdx(gdx_filename, 'co2_chk');
% co2_chk_n = sum(co2_chk);
% [report, report_id] = getgdx(gdx_filename, 'report');
% GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
% GDP_n = sum(GDP,2);
% co2_int = co2_chk_n'./GDP_n;
% pctg = 1-(co2_int(2:end)./co2_int(1:end-1));
% 
% plot(yr, co2_int, 'bx-', 'markersize', 7, 'linewidth', 1);
% for i = 3:6, text(yr(i), co2_int(i)-0.075, [num2str(-pctg(i-1)*100, '%2.0f'), '%'], 'fontsize', 8, 'horizontalalignment', 'center', 'color', 'b'); end

ylim([0 1.8]);
set(gca, 'ytick', 0:0.3:1.8);
set(gca, 'fontsize', 10);
ylabel('CO2 Intensity (ton/1000 USD)', 'Fontsize', 12, 'fontweight', 'bold');
legend('No Policy', 'Action Plan', 'Stringent Rgnl CO2 Cap', 3);
set(gcf, 'unit', 'inch', 'pos', [4.35    7.35    4.0000    3.0000]);
my_gridline;
% export_fig CO2_intensity -painters;


%% energy consumption
figure(3); clf; hold on; box on;

[report, report_id] = getgdx('result_urban_exo.gdx', 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
egycons_n = sum(egycons,2);
plot(yr, egycons_n, '^-', 'color', [0.5 0.5 0.5], 'markersize', 7, 'linewidth', 1);

[report, report_id] = getgdx('result_egyint_n.gdx', 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
egycons_n = sum(egycons,2);
plot(yr, egycons_n, 'o-', 'color', [0 0.8 0], 'markersize', 7, 'linewidth', 1);

% [report, report_id] = getgdx('result_ccap_r.gdx', 'report');
% egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
% egycons_n = sum(egycons,2);
% plot(yr, egycons_n, 'xb-', 'markersize', 7, 'linewidth', 1);

ylim([0 9000]);
set(gca, 'ytick', 0:1500:9000);
set(gca, 'fontsize', 10);
ylabel('N\primetnl Energy Consumption (mtce)', 'fontsize', 12, 'fontweight', 'bold');
legend('No Policy', 'Action Plan', 'Stringent Rgnl CO2 Cap', 2);
set(gcf, 'unit', 'inch', 'pos', [8.55    7.35    4.0000    3.0000]);
my_gridline;
% export_fig EGY_consumption -painters;


%% Energy intensity
figure(4); clf; hold on; box on;

gdx_filename = 'result_urban_exo.gdx';
egy_intensity_n = getgdx(gdx_filename, 'egy_intensity_n');
plot(yr, egy_intensity_n, '^-', 'color', [0.5 0.5 0.5], 'markersize', 7, 'linewidth', 1);

gdx_filename = 'result_egyint_n.gdx';
egy_intensity_n = getgdx(gdx_filename, 'egy_intensity_n');
pctg = (1-egy_intensity_n(2:end)./egy_intensity_n(1:end-1))';
plot(yr, egy_intensity_n, 'o-', 'color', [0 0.6 0], 'markersize', 7, 'linewidth', 1);

pctg(2:3) = 0.2;
for i = 3:6, text(yr(i), egy_intensity_n(i)-0.04, [num2str(-pctg(i-1)*100, '%2.0f'), '%'], 'fontsize', 8, 'horizontalalignment', 'center', 'color', [0 0.6 0]); end

% gdx_filename = 'result_ccap_r.gdx';
% egy_intensity_n = getgdx(gdx_filename, 'egy_intensity_n');
% pctg = (1-egy_intensity_n(2:end)./egy_intensity_n(1:end-1))';
% plot(yr, egy_intensity_n, 'x-', 'color', 'b', 'markersize', 7, 'linewidth', 1);
% for i = 3:6, text(yr(i), egy_intensity_n(i)-0.04, [num2str(-pctg(i-1)*100, '%2.0f'), '%'], 'fontsize', 8, 'horizontalalignment', 'center', 'color', 'b'); end

ylim([0 0.8]);
set(gcf, 'unit', 'inch', 'pos', [12.75    7.35    4.0000    3.0000]);
set(gca, 'fontsize', 10);
ylabel('N\primetnl Energy Intensity (tce/1000 USD)', 'fontsize', 12, 'fontweight', 'bold');
legend('No Policy', 'Action Plan', 'Stringent Rgnl CO2 Cap', 3);
my_gridline;
% export_fig EGY_intensity -painters;


%% Coal consumption
figure(5); clf; hold on; box on;

yr = [2007,2010,2015,2020,2025,2030];
[egyreport2, egyreport2_id] = getgdx('result_urban_exo', 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
plot(yr, col_consumption_n, '^-', 'color', [0.5 0.5 0.5], 'markersize', 7, 'linewidth', 1);
col_consumption_n_BAU = col_consumption_n;

[egyreport2, egyreport2_id] = getgdx('result_egyint_n', 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
plot(yr, col_consumption_n, 'o-', 'color', [0 0.6 0], 'markersize', 7, 'linewidth', 1);
col_consumption_n_AP = col_consumption_n;

% [egyreport2, egyreport2_id] = getgdx('result_ccap_r', 'egyreport2');
% col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
% col_consumption_n = sum(col_consumption,2);
% plot(yr, col_consumption_n, 'xb-', 'markersize', 7, 'linewidth', 1);
% col_consumption_nn = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),31));
% pctg = (1-col_consumption_nn(2:end)./col_consumption_nn(1:end-1))';
% for i = 3:6, text(yr(i), col_consumption_nn(i)-250, [num2str(-pctg(i-1)*100, '%2.0f'), '%'], 'fontsize', 8, 'horizontalalignment', 'center', 'color', 'b'); end

ylim([0 6000]);
set(gca, 'fontsize', 10);
ylabel('National Coal Consumption (mtce)', 'fontsize', 12, 'fontweight', 'bold');
legend('No Policy', 'Action Plan', 'Stringent Rgnl CO2 Cap', 3);
set(gcf, 'unit', 'inch', 'pos', [20.15    7.05    4.0000    3.0000]);
my_gridline;
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
plot(coal_web_data(:,1), coal_web_data(:,2), 'o-', 'color', [0.8 0 0], 'markersize', 4, 'markerf', [0.8 0 0], 'linewidth', 1);
plot(yr, col_consumption_n_BAU/ratio, '^-', 'color', [0.5 0.5 0.5]);
plot(yr, col_consumption_n_AP/ratio, 'o-', 'color', [0 0.8 0]);
% plot(yr, col_consumption_n/ratio, 'x-', 'color', [0 0 1]);

set(gcf, 'unit', 'inch', 'pos', [24.35    7.05    4.0000    3.0000]);
ylabel('Coal Consumption (normalized, 2000 = 100)');
legend('data from web', 'No Policy', 'Action Plan', 'Stringent Rgnl CO2 Cap', 2);
my_gridline;
% export_fig coal_compare -painters;


%% GDP
figure(7); clf; hold on; box on;

gdx_filename = 'result_urban_exo.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
h1  = plot(yr, GDP_n, '^-', 'markersize', 7, 'color', [0.5 0.5 0.5], 'linewidth', 1);
GDP_n_BAU = GDP_n;

% ==============================
gdx_filename = 'result_egyint_n.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
h2 = plot(yr, GDP_n, 'o-', 'markersize', 7, 'color', [0 0.8 0], 'linewidth', 1);

GDP_n_AP = GDP_n;

pctg = GDP_n(end)/GDP_n_BAU(end) - 1;
text(yr(end), GDP_n(end)-800, [num2str(pctg*100, '%2.0f'), '%'], 'fontsize', 8, 'horizontalalignment', 'center'); 
text(yr(end), GDP_n(end)-2100, {'(relative to', ' No Policy)'}, 'fontsize', 7, 'horizontalalignment', 'center'); 

% % ==============================
% gdx_filename = 'result_ccap_r.gdx';
% [report, report_id] = getgdx(gdx_filename, 'report');
% GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
% GDP_n = sum(GDP,2);
% h4= plot(yr, GDP_n, 'xb-', 'markersize', 7, 'linewidth', 1);
% 
% pctg = GDP_n(end)/GDP_n_AP(end) - 1;
% text(yr(end), GDP_n(end)-750, [num2str(pctg*100, '%2.0f'), '%'], 'fontsize', 8, 'horizontalalignment', 'center'); 
% text(yr(end), GDP_n(end)-2000, {'(relative to', 'Action Pan)'}, 'fontsize', 7, 'horizontalalignment', 'center'); 

ylim([0 16000]);
set(gca, 'fontsize', 10);
ylabel('GDP (Bn USD in 2007 value)', 'Fontsize', 12, 'fontweight', 'bold');
set(gcf, 'unit', 'inch', 'pos', [28.55    7.05    4.0000    3.0000]);
legend('No Policy', 'Action Plan', 'Stringent Rgnl CO2 Cap', 2);

my_gridline;
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
plot(yr, GDP_n_BAU/ratio, '^-', 'color', [0.5 0.5 0.5]);
plot(yr, GDP_n_AP/ratio, 'o-', 'color', [0 0.8 0]);
% plot(yr, GDP_n/ratio, 'x-', 'color', [0 0 1]);

ylabel('GDP (normalized, 2000 = 100)');
set(gcf, 'unit', 'inch', 'pos', [32.75    7.05    4.0000    3.0000]);
legend('data from web', 'No Policy', 'Action Plan', 'Stringent Rgnl CO2 Cap', 2);
my_gridline;
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
plot(yr, col_share_n, '^-', 'markersize', 7, 'color', [0.5 0.5 0.5], 'linewidth', 1);

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
plot(yr, col_share_n, 'o-', 'markersize', 7, 'color', [0 0.8 0], 'linewidth', 1);

set(gcf, 'unit', 'inch', 'pos', [4.5833    5.9167    4.0000    3.0000]);
set(gca, 'fontsize', 10);
ylabel('Coal Share (-)', 'Fontsize', 12, 'fontweight', 'bold');
ylim([0 0.8]);
legend('No Policy', 'Action Plan', 3);
my_gridline;

line([2005 2030], [1 1]*0.65, 'linestyle', ':', 'color', 'b');
text(2006, 0.645, {'Action Plan Target:', 'Coal Share below 65% by 2017'}, 'fontsize', 7, 'color', 'b', 'verticalalignment', 'top');

% export_fig coal_share -r300 -painters;


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
plot(yr, nhw_share_n, '^-', 'markersize', 7, 'color', [0.5 0.5 0.5], 'linewidth', 1);

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
plot(yr, nhw_share_n, 'o-', 'markersize', 7, 'color', [0 0.8 0], 'linewidth', 1);

ylim([0 0.8]);
set(gcf, 'unit', 'inch', 'pos', [8.7605    5.9167    4.0000    3.0000]);
set(gca, 'fontsize', 10);
ylabel('Non-Fossil Fuel Share (-)', 'Fontsize', 12, 'fontweight', 'bold');
my_gridline;

line([2005 2030], [1 1]*0.2, 'linestyle', ':', 'color', 'b');
text(2006, 0.20, {'China\primes latest target:', 'Non-Fossil Fuel Share higher than 20% by 2030'}, 'fontsize', 7, 'color', 'b');

% export_fig nhw_share -r300 -painters;


%% urban emissions
% gdx_filename = 'result_urban_exo.gdx';
% [urban, urban_id] = getgdx(gdx_filename, 'urban');
% urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
% for i = 1:length(urban_id{1})
%     urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
%     urban_CHN(i,:) = sum(urban_extract);
%     
%     figure(9+i); clf; box on;
%     plot(yr, urban_CHN(i,:), '^-', 'color', [0.5 0.5 0.5], 'markersize', 7, 'linewidth', 1);
%     set(gca, 'fontsize', 10);
%     ylabel([char(cellstr(urban_id{1}(i))), ' (Tg)'], 'fontsize', 12, 'fontweight', 'bold');
%     
%     set(gcf, 'unit', 'inch', 'pos', [0.25+4.15*(i-1)    3.2    4.0000    3.0000]);
%     
%     if i == 1, ylim([0 3]); end
%     if i == 2, ylim([0 500]); end
%     if i == 3, ylim([0 30]); end
%     if i == 4, ylim([0 80]); end
%     if i == 5, ylim([0 6]); end
%     if i == 6, ylim([0 55]); end
%     if i == 7, ylim([0 40]); end
%     if i == 8, ylim([0 70]); end
%     if i == 9, ylim([0 65]); end
% end
% 
% % ==========
% gdx_filename = 'result_egyint_n.gdx';
% [urban, urban_id] = getgdx(gdx_filename, 'urban');
% urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
% for i = 1:length(urban_id{1})
%     urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
%     urban_CHN(i,:) = sum(urban_extract);
%     
%     figure(9+i); hold on; box on;
%     plot(yr, urban_CHN(i,:), 'o-', 'color', [0 0.6 0], 'markersize', 7, 'linewidth', 1);
% end
% 
% % % ==========
% % gdx_filename = 'result_ccap_r.gdx';
% % [urban, urban_id] = getgdx(gdx_filename, 'urban');
% % urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
% % for i = 1:length(urban_id{1})
% %     urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
% %     urban_CHN(i,:) = sum(urban_extract);
% %     pctg = urban_CHN(i,2:end)./urban_CHN(i,1:end-1) - 1;
% % 
% %     figure(9+i); hold on; box on;
% %     plot(yr, urban_CHN(i,:), 'xb-', 'markersize', 7, 'linewidth', 1);
% %     if i==1, legend('No Policy', 'Action Plan', 'Stringent Rgnl CO2 Cap', 3); end
% %     
% %     for yn = 3:length(yr), text(yr(yn), urban_CHN(i,yn)*0.9, [num2str(pctg(yn-1)*100, '%2.0f'), '%'], 'fontsize', 8, 'color', 'b', 'horizontalalignment', 'center'); end
% % 
% %     my_gridline;
% %     export_filename = ['fig_', char(urban_id{1}(i))];
% % %     export_fig(export_filename);
% % end


