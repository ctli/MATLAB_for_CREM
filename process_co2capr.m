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
gdx_filename = 'result_egyint_n_old.gdx';
co2_chk = getgdx(gdx_filename, 'co2_chk');
co2_chk_n = sum(co2_chk);
plot(yr, co2_chk_n/1e3, 'o-', 'color', [0 0.8 0], 'markersize', 7, 'linewidth', 1);

% ==========
gdx_filename = 'result_egyint_n.gdx';
co2_chk = getgdx(gdx_filename, 'co2_chk');
co2_chk_n = sum(co2_chk);
plot(yr, co2_chk_n/1e3, 's-', 'color', 'r', 'markersize', 7, 'linewidth', 1);

% ==========
gdx_filename = 'result_ccap_r_new.gdx';
co2_chk = getgdx(gdx_filename, 'co2_chk');
co2_chk_n = sum(co2_chk);
plot(yr, co2_chk_n/1e3, 'x-', 'color', 'b', 'markersize', 7, 'linewidth', 1);
pctg = co2_chk_n(2:end)./co2_chk_n(1:end-1) - 1;
for yn = 3:length(yr), text(yr(yn), co2_chk_n(yn)/1e3-0.85, [num2str(pctg(yn-1)*100, '%2.0f'), '%'], 'fontsize', 8, 'color', 'b', 'horizontalalignment', 'center'); end

legend('No Policy', 'Action Plan', '12th FYP' ,'More Stringent Scenario', 2);
set(legend, 'fontsize', 9);
set(gca, 'fontsize', 10);
ylabel('CO2 (Billion tons)', 'Fontsize', 12, 'fontweight', 'bold');
set(gcf, 'unit', 'inch', 'pos', [5.3958    4.7604    4.0000    3.0000]);
ylim([0 20]);
set(gca, 'ytick', 0:5:20);

legend('No Policy', 'Action Plan', '12th FYP' ,'More Stringent Scenario', 2);
set(legend, 'fontsize', 9);
set(gca, 'fontsize', 10);
ylabel('CO2 (Billion tons)', 'Fontsize', 12, 'fontweight', 'bold');
set(gcf, 'unit', 'inch', 'pos', [5.3958    4.7604    4.0000    3.0000]);
ylim([0 20]);
set(gca, 'ytick', 0:5:20);

my_gridline;


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

% ==============================
gdx_filename = 'result_egyint_n_old.gdx';
co2_chk = getgdx(gdx_filename, 'co2_chk');
co2_chk_n = sum(co2_chk);
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
co2_int = co2_chk_n'./GDP_n;
pctg = 1-(co2_int(2:end)./co2_int(1:end-1));

plot(yr, co2_int, 'o-', 'markersize', 7, 'color', [0 0.8 0], 'linewidth', 1);
for i = 3:4, text(yr(i)+1.75, co2_int(i), [num2str(-pctg(i-1)*100, '%2.0f'), '%'], 'fontsize', 8, 'horizontalalignment', 'center', 'color', [0 0.8 0]); end

% ==============================
gdx_filename = 'result_egyint_n.gdx';
co2_chk = getgdx(gdx_filename, 'co2_chk');
co2_chk_n = sum(co2_chk);
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
co2_int = co2_chk_n'./GDP_n;
pctg = 1-(co2_int(2:end)./co2_int(1:end-1));

plot(yr, co2_int, 'rs-', 'markersize', 7, 'linewidth', 1);
for i = 3:4, text(yr(i)+1.75, co2_int(i), [num2str(-pctg(i-1)*100, '%2.0f'), '%'], 'fontsize', 8, 'horizontalalignment', 'center', 'color', [1 0 0]); end

% ==============================
gdx_filename = 'result_ccap_r_new.gdx';
co2_chk = getgdx(gdx_filename, 'co2_chk');
co2_chk_n = sum(co2_chk);
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
co2_int = co2_chk_n'./GDP_n;
pctg = 1-(co2_int(2:end)./co2_int(1:end-1));

plot(yr, co2_int, 'bx-', 'markersize', 7, 'linewidth', 1);
for i = 3:6, text(yr(i), co2_int(i)-0.075, [num2str(-pctg(i-1)*100, '%2.0f'), '%'], 'fontsize', 8, 'horizontalalignment', 'center', 'color', 'b'); end

ylim([0 1.8]);
set(gca, 'fontsize', 10);
ylabel('CO2 Intensity (ton/1000 USD)', 'Fontsize', 12, 'fontweight', 'bold');
set(gcf, 'unit', 'inch', 'pos', [4.3229    1.8229    4.0000    3.0000]);
my_gridline;


%% Energy intensity
figure(3); clf; hold on; box on;

gdx_filename = 'result_urban_exo.gdx';
egy_intensity_n = getgdx(gdx_filename, 'egy_intensity_n');
plot(yr, egy_intensity_n, '^-', 'color', [0.5 0.5 0.5], 'markersize', 7, 'linewidth', 1);

gdx_filename = 'result_egyint_n_old.gdx';
egy_intensity_n = getgdx(gdx_filename, 'egy_intensity_n');
pctg = (1-egy_intensity_n(2:end)./egy_intensity_n(1:end-1))';
plot(yr, egy_intensity_n, 'o-', 'color', [0 0.8 0], 'markersize', 7, 'linewidth', 1);
for i = 3:4, text(yr(i)+1.75, egy_intensity_n(i), '-20%', 'fontsize', 8, 'horizontalalignment', 'center', 'color', [0 0.8 0]); end

gdx_filename = 'result_egyint_n.gdx';
egy_intensity_n = getgdx(gdx_filename, 'egy_intensity_n');
pctg = (1-egy_intensity_n(2:end)./egy_intensity_n(1:end-1))';
plot(yr, egy_intensity_n, 's-', 'color', [1 0 0], 'markersize', 7, 'linewidth', 1);
for i = 3:4, text(yr(i)+1.75, egy_intensity_n(i), [num2str(-pctg(i-1)*100, '%2.0f'), '%'], 'fontsize', 8, 'horizontalalignment', 'center', 'color', [1 0 0]); end

gdx_filename = 'result_ccap_r_new.gdx';
egy_intensity_n = getgdx(gdx_filename, 'egy_intensity_n');
pctg = (1-egy_intensity_n(2:end)./egy_intensity_n(1:end-1))';
plot(yr, egy_intensity_n, 'x-', 'color', 'b', 'markersize', 7, 'linewidth', 1);
for i = 3:4, text(yr(i), egy_intensity_n(i)-0.03, [num2str(-pctg(i-1)*100, '%2.0f'), '%'], 'fontsize', 8, 'horizontalalignment', 'center', 'color', 'b'); end

ylim([0 0.8]);
set(gcf, 'unit', 'inch', 'pos', [6.8958    4.7604    4.0000    3.0000]);
set(gca, 'fontsize', 10);
ylabel('National Energy Intensity', 'fontsize', 12, 'fontweight', 'bold');
my_gridline;


%% Coal consumption
figure(4); clf; hold on; box on;

yr = [2007,2010,2015,2020,2025,2030];
[egyreport2, egyreport2_id] = getgdx('result_urban_exo', 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
plot(yr, col_consumption_n, '^-', 'color', [0.5 0.5 0.5], 'markersize', 7, 'linewidth', 1);
col_consumption_n_BAU = col_consumption_n;

[egyreport2, egyreport2_id] = getgdx('result_egyint_n_old', 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
plot(yr, col_consumption_n, 'o-', 'color', [0 0.8 0], 'markersize', 7, 'linewidth', 1);
col_consumption_n_AP = col_consumption_n;

[egyreport2, egyreport2_id] = getgdx('result_egyint_n', 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
plot(yr, col_consumption_n, 'rs-', 'markersize', 7, 'linewidth', 1);
col_consumption_n_FYP = col_consumption_n;

[egyreport2, egyreport2_id] = getgdx('result_ccap_r_new', 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
plot(yr, col_consumption_n, 'xb-', 'markersize', 7, 'linewidth', 1);
col_consumption_nn = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),31));
pctg = (1-col_consumption_nn(2:end)./col_consumption_nn(1:end-1))';
for i = 3:6, text(yr(i), col_consumption_nn(i)-250, [num2str(-pctg(i-1)*100, '%2.0f'), '%'], 'fontsize', 8, 'horizontalalignment', 'center', 'color', 'b'); end

ylim([0 6000]);
set(gca, 'fontsize', 10);
ylabel('National Coal Consumption (mtce)', 'fontsize', 12, 'fontweight', 'bold');
set(gcf, 'unit', 'inch', 'pos', [7.8958    4.7604    4.0000    3.0000]);
my_gridline;

%% Coal consumption varification; http://cleantechnica.com/2014/08/26/chinas-coal-consumption-finally-decreased/
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
figure(41); clf; hold on; box on;
plot(coal_web_data(:,1), coal_web_data(:,2), 'o-', 'color', [0.8 0 0], 'markersize', 4, 'markerf', [0.8 0 0], 'linewidth', 1);
plot(yr, col_consumption_n_BAU/ratio, '^-', 'color', [0.5 0.5 0.5]);
plot(yr, col_consumption_n_AP/ratio, 'o-', 'color', [0 0.8 0]);
plot(yr, col_consumption_n_FYP/ratio, 's-', 'color', [1 0 0]);
plot(yr, col_consumption_n/ratio, 'x-', 'color', [0 0 1]);

ylabel('Coal Consumption (normalized, 2000 = 100)');
legend('data from web', 'No Policy', 'Action Plan', '12th FYP' ,'More Stringent Scenario', 2);
my_gridline;
% export_fig coal_compare -painters;




%% energy consumption
figure(5); clf; hold on; box on;

[report, report_id] = getgdx('result_urban_exo.gdx', 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
egycons_n = sum(egycons,2);
plot(yr, egycons_n, '^-', 'color', [0.5 0.5 0.5], 'markersize', 7, 'linewidth', 1);

[report, report_id] = getgdx('result_egyint_n_old.gdx', 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
egycons_n = sum(egycons,2);
plot(yr, egycons_n, 'o-', 'color', [0 0.8 0], 'markersize', 7, 'linewidth', 1);

[report, report_id] = getgdx('result_egyint_n.gdx', 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
egycons_n = sum(egycons,2);
plot(yr, egycons_n, '^-', 'color', [1 0 0], 'markersize', 7, 'linewidth', 1);

[report, report_id] = getgdx('result_ccap_r_new.gdx', 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
egycons_n = sum(egycons,2);
plot(yr, egycons_n, 'xb-', 'markersize', 7, 'linewidth', 1);

ylim([0 9000]);
set(gca, 'fontsize', 10);
ylabel('National Energy Consumption (mtce)', 'fontsize', 12, 'fontweight', 'bold');
set(gcf, 'unit', 'inch', 'pos', [0.25+4.15    0.7917    4.0000    3.0000]);
my_gridline;


%% SO2
figure(6); clf; hold on; box on;

gdx_filename = 'result_urban_exo.gdx';
[urban, urban_id] = getgdx(gdx_filename, 'urban');
urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
i = 8;
urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
urban_CHN(i,:) = sum(urban_extract);
plot(yr, urban_CHN(i,:), '^-', 'markersize', 7, 'color', [0.5 0.5 0.5], 'linewidth', 1);

gdx_filename = 'result_egyint_n_old.gdx';
[urban, urban_id] = getgdx(gdx_filename, 'urban');
urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
i = 8;
urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
urban_CHN(i,:) = sum(urban_extract);
plot(yr, urban_CHN(i,:), 'o-', 'color', [0 0.8 0], 'markersize', 7, 'linewidth', 1);

gdx_filename = 'result_egyint_n.gdx';
[urban, urban_id] = getgdx(gdx_filename, 'urban');
urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
i = 8;
urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
urban_CHN(i,:) = sum(urban_extract);
plot(yr, urban_CHN(i,:), 'o-', 'color', [1 0 0], 'markersize', 7, 'linewidth', 1);
pctg = urban_CHN(i,2:end)./urban_CHN(i,1:end-1) - 1;
for yn = 3:length(yr), text(yr(yn)+1.5, urban_CHN(i,yn), [num2str(pctg(yn-1)*100, '%2.0f'), '%'], 'fontsize', 8, 'color', 'r', 'horizontalalignment', 'center'); end

gdx_filename = 'result_ccap_r_new.gdx';
[urban, urban_id] = getgdx(gdx_filename, 'urban');
urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
i = 8;
urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
urban_CHN(i,:) = sum(urban_extract);
plot(yr, urban_CHN(i,:), 'x-', 'color', 'b', 'markersize', 7, 'linewidth', 1);
pctg = urban_CHN(i,2:end)./urban_CHN(i,1:end-1) - 1;
for yn = 3:length(yr), text(yr(yn), urban_CHN(i,yn)-3, [num2str(pctg(yn-1)*100, '%2.0f'), '%'], 'fontsize', 8, 'color', 'b', 'horizontalalignment', 'center'); end

ylim([0 70]);
set(gca, 'fontsize', 10);
set(gcf, 'unit', 'inch', 'pos', [6.2396    2.6667    4.0000    3.0000]);
ylabel('SO2 (Tg)', 'fontsize', 12, 'fontweight', 'bold');
my_gridline;


%% GDP
figure(7); clf; hold on; box on;

gdx_filename = 'result_urban_exo.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
h1  = plot(yr, GDP_n, '^-', 'markersize', 7, 'color', [0.5 0.5 0.5], 'linewidth', 1);
GDP_n_BAU = GDP_n;

% ==============================
gdx_filename = 'result_egyint_n_old.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
h2 = plot(yr, GDP_n, 'o-', 'markersize', 7, 'color', [0 0.8 0], 'linewidth', 1);

GDP_n_AP = GDP_n;

% ==============================
gdx_filename = 'result_egyint_n.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
h3 = plot(yr, GDP_n, 's-', 'markersize', 7, 'color', 'r', 'linewidth', 1);

GDP_n_FYP = GDP_n;

% ==============================
gdx_filename = 'result_ccap_r_new.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
h4= plot(yr, GDP_n, 'xb-', 'markersize', 7, 'linewidth', 1);

pctg = GDP_n(end)/GDP_n_AP(end) - 1;
text(yr(end), GDP_n(end)-750, [num2str(pctg*100, '%2.0f'), '%'], 'fontsize', 8, 'horizontalalignment', 'center'); 
text(yr(end), GDP_n(end)-2000, {'(relative to', 'Action Pan)'}, 'fontsize', 7, 'horizontalalignment', 'center'); 


ylim([0 16000]);
set(gca, 'fontsize', 10);
ylabel('GDP (Bn USD in 2007 value)', 'Fontsize', 12, 'fontweight', 'bold');
set(gcf, 'unit', 'inch', 'pos', [8.1875    5.2292    4.0000    3.0000]);

my_gridline;

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
plot(yr, GDP_n_FYP/ratio, 's-', 'color', [1 0 0]);
plot(yr, GDP_n/ratio, 'x-', 'color', [0 0 1]);

ylabel('GDP (normalized, 2000 = 100)');
legend('data from web', 'No Policy', 'Action Plan', '12th FYP' ,'More Stringent Scenario', 2);
my_gridline;
% export_fig GDP_compare -painters;


% %% urban emissions
% gdx_filename = 'result_urban_exo.gdx';
% [urban, urban_id] = getgdx(gdx_filename, 'urban');
% urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
% for i = 1:length(urban_id{1})
%     urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
%     urban_CHN(i,:) = sum(urban_extract);
%     
%     figure(7+i); clf; box on;
%     plot(yr, urban_CHN(i,:), '^-', 'color', [0.5 0.5 0.5], 'markersize', 7, 'linewidth', 1);
%     set(gca, 'fontsize', 10);
%     ylabel([char(cellstr(urban_id{1}(i))), ' (Tg)'], 'fontsize', 12, 'fontweight', 'bold');
%     
%     set(gcf, 'unit', 'inch', 'pos', [0.25+4.15*(i-1)    4.75    4.0000    3.0000]);
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
% gdx_filename = 'result_egyint_n_old.gdx';
% [urban, urban_id] = getgdx(gdx_filename, 'urban');
% urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
% for i = 1:length(urban_id{1})
%     urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
%     urban_CHN(i,:) = sum(urban_extract);
%     
%     figure(7+i); hold on; box on;
%     plot(yr, urban_CHN(i,:), 'o-', 'color', [0 0.8 0], 'markersize', 7, 'linewidth', 1);
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
%     figure(7+i); hold on; box on;
%     plot(yr, urban_CHN(i,:), 's-', 'color', [1 0 0], 'markersize', 7, 'linewidth', 1);
% end
% 
% % ==========
% gdx_filename = 'result_ccap_r_new.gdx';
% [urban, urban_id] = getgdx(gdx_filename, 'urban');
% urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
% for i = 1:length(urban_id{1})
%     urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
%     urban_CHN(i,:) = sum(urban_extract);
%     
%     figure(7+i); hold on; box on;
%     plot(yr, urban_CHN(i,:), 'xb-', 'markersize', 7, 'linewidth', 1);
%     if i==1, legend('No Policy', 'Action Plan', '12th FYP' ,'More Stringent Scenario', 3); end
%     my_gridline;
%     export_filename = ['fig_', char(urban_id{1}(i))];
%     %export_fig(export_filename);
% end


%% Urban emission breakdown (combustion emission vs. process emission)
[urban_c, urban_c_id] = getgdx('result_urban_exo.gdx', 'urban_c'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[8]x[6]
[urban_o, urban_o_id] = getgdx('result_urban_exo.gdx', 'urban_o'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[10]x[6]
for i = 1:length(urban_id{1})
SO2_c = squeeze(urban_c(strcmp(urban_c_id{1}(i), urban_c_id{1}),:,:,:)); % [30]x[8]x[6]
SO2_c_g = squeeze(sum(SO2_c,2)); % [30]x[6]
SO2_c_n = sum(SO2_c_g); % [1]x[6]

SO2_o = squeeze(urban_o(strcmp(urban_o_id{1}(i), urban_o_id{1}),:,:,:)); % [30]x[8]x[6]
SO2_o_g = squeeze(sum(SO2_o,2)); % [30]x[6]
SO2_o_n = sum(SO2_o_g); % [1]x[6]

figure(400+i); clf; hold on; box on;
hb0 = bar(yr-0.5, [SO2_c_n; SO2_o_n]', 0.3, 'stacked', 'edge', 'none', 'linewidth', 2);
set(hb0(1), 'facec', [0.8 0 0]); %combustion
set(hb0(2), 'facec', [1 1 0]); %process
hb = bar(yr-0.5, [SO2_c_n; SO2_o_n]', 0.3, 'stacked', 'edge', [0.5 0.5 0.5], 'linewidth', 2);
set(hb(1), 'facec', [0.8 0 0]); %combustion
set(hb(2), 'facec', [1 1 0]); %process

set(gca, 'fontsize', 10);
set(gca, 'layer', 'top');
set(gcf, 'unit', 'inch', 'pos', [0.25+4.15*(i-1)    4.25    4.0000    3.0000]);
ylabel([char(cellstr(urban_id{1}(i))), ' (Tg)'], 'fontsize', 12, 'fontweight', 'bold');
xlim([2005 2031.5]);
legend(fliplr(hb0), 'Process', 'Combustion', 2);
% legend((hb), 'Combustion', 'Process', 2);

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

[urban_c, urban_c_id] = getgdx('result_ccap_r_new.gdx', 'urban_c'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[8]x[6]
[urban_o, urban_o_id] = getgdx('result_ccap_r_new.gdx', 'urban_o'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[10]x[6]
for i = 1:length(urban_id{1})
SO2_c = squeeze(urban_c(strcmp(urban_c_id{1}(i), urban_c_id{1}),:,:,:)); % [30]x[8]x[6]
SO2_c_g = squeeze(sum(SO2_c,2)); % [30]x[6]
SO2_c_n = sum(SO2_c_g); % [1]x[6]

SO2_o = squeeze(urban_o(strcmp(urban_c_id{1}(i), urban_o_id{1}),:,:,:)); % [30]x[8]x[6]
SO2_o_g = squeeze(sum(SO2_o,2)); % [30]x[6]
SO2_o_n = sum(SO2_o_g); % [1]x[6]

figure(400+i); 
hb = bar(yr+0.5, [SO2_c_n; SO2_o_n]', 0.3, 'stacked', 'edge', 'b', 'linewidth', 2);
set(hb(1), 'facec', [0.8 0 0]); %combustion
set(hb(2), 'facec', [1 1 0]); %process

end
