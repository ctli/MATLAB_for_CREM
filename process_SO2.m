clear all
close all
clc
format compact

yr = [2007, 2010:5:2030];

r = {'BJ','TJ','HE','SX','SD','NM','LN','JL','HL','SH','JS','ZJ','AH','FJ','HA','HB','HN','JX','SC','CQ','SN','GS','QH','NX','XJ','GD','GX','YN','GZ','HI'};


%% GDP
gdx_filename = 'result_urban_exo.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
figure(1); clf; hold on; box on;
plot(yr, GDP_n, '^-', 'markersize', 7, 'color', [0.5 0.5 0.5], 'linewidth', 1);
ylim([0 16000]);
set(gca, 'fontsize', 10);
ylabel('GDP (bn USD in 2007 value)', 'Fontsize', 12, 'fontweight', 'bold');
set(gcf, 'unit', 'inch', 'pos', [0.0833    5.8333    4.0000    3.0000]);

% ==============================
gdx_filename = 'result_egyint_n_old.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
plot(yr, GDP_n, 'o-', 'markersize', 7, 'color', [0 0.8 0], 'linewidth', 1);

% ==============================
gdx_filename = 'result_egyint_n.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
plot(yr, GDP_n, 'rs-', 'markersize', 7, 'linewidth', 1);

my_gridline;


%% CO2
figure(2); clf; hold on; box on;

gdx_filename = 'result_urban_exo.gdx';
[report2, report2_id] = getgdx(gdx_filename, 'report2');
co2 = squeeze(report2(strcmp('CO2emis', report2_id{1}),:,1:13,1:30));
co2_r = squeeze(sum(co2,2));
co2_n = squeeze(sum(co2_r,2));
plot(yr, co2_n/1e3, '^-', 'markersize', 7, 'color', [0.5 0.5 0.5], 'linewidth', 1);

gdx_filename = 'result_egyint_n_old.gdx';
[report2, report2_id] = getgdx(gdx_filename, 'report2');
co2 = squeeze(report2(strcmp('CO2emis', report2_id{1}),:,1:13,1:30));
co2_r = squeeze(sum(co2,2));
co2_n = squeeze(sum(co2_r,2));
plot(yr, co2_n/1e3, 'o-', 'markersize', 7, 'color', [0 0.8 0], 'linewidth', 1);
disp('CO2:');
sum(co2_n(3:end)/1e3)

gdx_filename = 'result_egyint_n.gdx';
[report2, report2_id] = getgdx(gdx_filename, 'report2');
co2 = squeeze(report2(strcmp('CO2emis', report2_id{1}),:,1:13,1:30));
co2_r = squeeze(sum(co2,2));
co2_n = squeeze(sum(co2_r,2));
plot(yr, co2_n/1e3, 'rs-', 'markersize', 7, 'linewidth', 1);
sum(co2_n(3:end)/1e3)

set(gca, 'fontsize', 10);
ylabel('CO2 (Billion tons)', 'Fontsize', 12, 'fontweight', 'bold');
set(gcf, 'unit', 'inch', 'pos', [4.3229    5.8333    4.0000    3.0000]);
ylim([0 20]);
set(gca, 'yminortick', 'on');
set(gca, 'ytick', 0:5:20);
my_gridline;


%% CO2 intensity
disp('==============================');
figure(3); clf; hold on; box on;

gdx_filename = 'result_urban_exo.gdx';
[report2, report2_id] = getgdx(gdx_filename, 'report2');
co2 = squeeze(report2(strcmp('CO2emis', report2_id{1}),:,1:13,1:30));
co2_r = squeeze(sum(co2,2));
co2_n = squeeze(sum(co2_r,2));

[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);

co2_int = co2_n./GDP_n;
plot(yr, co2_int, '^-', 'markersize', 7, 'color', [0.5 0.5 0.5], 'linewidth', 1);

% ==============================
gdx_filename = 'result_egyint_n_old.gdx';
[report2, report2_id] = getgdx(gdx_filename, 'report2');
co2 = squeeze(report2(strcmp('CO2emis', report2_id{1}),:,1:13,1:30));
co2_r = squeeze(sum(co2,2));
co2_n = squeeze(sum(co2_r,2));

[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);

co2_int = co2_n./GDP_n;
plot(yr, co2_int, 'o-', 'markersize', 7, 'color', [0 0.8 0], 'linewidth', 1);

disp('CO2 intensity:');
pctg = (1-co2_int(2:end)./co2_int(1:end-1))'
for i = 3:4, text(yr(i)+1.75, co2_int(i), [num2str(-pctg(i-1)*100, '%2.0f'), '%'], 'fontsize', 8, 'horizontalalignment', 'center'); end

% ==============================
gdx_filename = 'result_egyint_n.gdx';
[report2, report2_id] = getgdx(gdx_filename, 'report2');
co2 = squeeze(report2(strcmp('CO2emis', report2_id{1}),:,1:13,1:30));
co2_r = squeeze(sum(co2,2));
co2_n = squeeze(sum(co2_r,2));

[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);

co2_int = co2_n./GDP_n;
pctg = (1-co2_int(2:end)./co2_int(1:end-1))'
plot(yr, co2_int, 'rs-', 'markersize', 7, 'linewidth', 1);
for i = 3:4, text(yr(i), co2_int(i)-0.075, [num2str(-pctg(i-1)*100, '%2.0f'), '%'], 'fontsize', 8, 'horizontalalignment', 'center'); end

ylim([0 1.8]);
set(gca, 'fontsize', 10);
ylabel('CO2 Intensity', 'Fontsize', 12, 'fontweight', 'bold');
set(gcf, 'unit', 'inch', 'pos', [4.3229    1.8229    4.0000    3.0000]);
my_gridline;


%% national energy consumption
disp('==============================');
figure(4); clf; hold on; box on;

[report, report_id] = getgdx('result_urban_exo.gdx', 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
egycons_n = sum(egycons,2);
plot(yr, egycons_n, '^-', 'color', [0.5 0.5 0.5], 'markersize', 7, 'linewidth', 1);

[report, report_id] = getgdx('result_egyint_n_old.gdx', 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
egycons_n = sum(egycons,2);
plot(yr, egycons_n, 'o-', 'color', [0 0.8 0], 'markersize', 7, 'linewidth', 1);

disp('Total energy:');
sum(egycons_n(3:6))

[report, report_id] = getgdx('result_egyint_n.gdx', 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
egycons_n = sum(egycons,2);
plot(yr, egycons_n, 'rs-', 'markersize', 7, 'linewidth', 1);

sum(egycons_n(3:6))

ylim([0 9000]);
set(gca, 'fontsize', 10);
ylabel('National Energy Consumption (mtce)', 'fontsize', 12, 'fontweight', 'bold');
set(gcf, 'unit', 'inch', 'pos', [8.5104    5.8438    4.0000    3.0000]);
legend('No Policy', 'w/ Policy', 2);

my_gridline;
% export_fig national_energy_consumption;


%% national energy intensity
figure(5); clf; hold on; box on;

egy_intensity_n = getgdx('result_urban_exo.gdx', 'egy_intensity_n');
plot(yr, egy_intensity_n, '^-', 'color', [0.5 0.5 0.5], 'markersize', 7, 'linewidth', 1);
egy_intensity_n = getgdx('result_egyint_n_old.gdx', 'egy_intensity_n');
plot(yr, egy_intensity_n, 'o-', 'color', [0 0.8 0], 'markersize', 7, 'linewidth', 1);
pctg = 1 - egy_intensity_n(2:end)./egy_intensity_n(1:end-1);
% for i = 3:6, text(yr(i)+0.5, egy_intensity_n(i), [num2str(-pctg(i-1)*100, '%2.0f'), '%'], 'fontsize', 8); end
for i = 3:4, text(yr(i)+0.5, egy_intensity_n(i), '-20%', 'fontsize', 8); end

egy_intensity_n = getgdx('result_egyint_n.gdx', 'egy_intensity_n');
pctg = 1 - egy_intensity_n(2:end)./egy_intensity_n(1:end-1);
plot(yr, egy_intensity_n, 'rs-', 'markersize', 7, 'linewidth', 1);
for i = 3:4, text(yr(i), egy_intensity_n(i)-0.04, [num2str(-pctg(i-1)*100, '%2.0f'), '%'], 'fontsize', 8, 'horizontalalignment', 'center'); end

ylim([0 0.8]);
set(gca, 'fontsize', 10);
ylabel('National Energy Intensity', 'fontsize', 12, 'fontweight', 'bold');
set(gcf, 'unit', 'inch', 'pos', [8.5521    1.8229    4.0000    3.0000]);
legend('No Policy', 'Action Plan Egy Int Target', '12th FYP SO2 Target', 3);

my_gridline;
% export_fig egy_int_n;


%% national coal consumption
disp('==============================');
figure(6); clf; hold on; box on;

[egyreport2, egyreport2_id] = getgdx('result_urban_exo', 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
plot(yr, col_consumption_n, '^-', 'color', [0.5 0.5 0.5], 'markersize', 7, 'linewidth', 1);

[egyreport2, egyreport2_id] = getgdx('result_egyint_n_old', 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
plot(yr, col_consumption_n, 'o-', 'color', [0 0.8 0], 'markersize', 7, 'linewidth', 1);

disp('Coal:');
sum(col_consumption_n(3:6))

[egyreport2, egyreport2_id] = getgdx('result_egyint_n', 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
plot(yr, col_consumption_n, 'rs-', 'markersize', 7, 'linewidth', 1);
sum(col_consumption_n(3:6))

ylim([0 9000]);
set(gca, 'fontsize', 10);
ylabel('National Coal Consumption (mtce)', 'fontsize', 12, 'fontweight', 'bold');
set(gcf, 'unit', 'inch', 'pos', [12.7083    5.8438    4.0000    3.0000]);
legend('No Policy', 'w/ Policy', 2);

my_gridline;
% export_fig national_coal_consumption;


%% SO2
disp('==============================');
figure(7); clf; hold on; box on;

gdx_filename = 'result_urban_exo.gdx';
[urban, urban_id] = getgdx(gdx_filename, 'urban');
urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
i = 8;
urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
urban_CHN(i,:) = sum(urban_extract);
plot(yr, urban_CHN(i,:), '^-', 'color', [0.5 0.5 0.5], 'markersize', 7, 'linewidth', 1);

% ==============================
gdx_filename = 'result_egyint_n_old.gdx';
[urban, urban_id] = getgdx(gdx_filename, 'urban');
urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
i = 8;
urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
urban_CHN(i,:) = sum(urban_extract);
plot(yr, urban_CHN(i,:), 'o-', 'markersize', 7, 'color', [0 0.8 0], 'linewidth', 1);

disp('SO2:');
sum(urban_CHN(i,3:end))

% ==============================
gdx_filename = 'result_egyint_n.gdx';
[urban, urban_id] = getgdx(gdx_filename, 'urban');
urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
i = 8;
urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
urban_CHN(i,:) = sum(urban_extract);
plot(yr, urban_CHN(i,:), 'rs-', 'markersize', 7, 'linewidth', 1);

sum(urban_CHN(i,3:end))
pctg = 1-urban_CHN(i,2:end)./urban_CHN(i,1:end-1)
for i = 3:4, text(yr(i)+0.5, urban_CHN(8,i)-4.5, [num2str(-pctg(i-1)*100, '%2.0f'), '%'], 'fontsize', 8, 'horizontalalignment', 'center'); end

legend('No Policy', 'Action Plan Egy Int Target', '12th FYP SO2 Target', 2);

set(gca, 'fontsize', 10);
ylabel('SO2 (Tg)', 'fontsize', 12, 'fontweight', 'bold');
set(gcf, 'unit', 'inch', 'pos', [12.7500    1.8333    4.0000    3.0000]);
ylim([0 70]);
my_gridline;


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

gdx_filename = 'result_egyint_n_old.gdx';
[urban, urban_id] = getgdx(gdx_filename, 'urban');
urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
for i = 1:length(urban_id{1})
    urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
    urban_CHN(i,:) = sum(urban_extract);
    
    figure(10+i); hold on; box on;
    plot(yr, urban_CHN(i,:), 'o-', 'color', [0 0.8 0], 'markersize', 7, 'linewidth', 1);
end

gdx_filename = 'result_egyint_n.gdx';
[urban, urban_id] = getgdx(gdx_filename, 'urban');
urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
for i = 1:length(urban_id{1})
    urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
    urban_CHN(i,:) = sum(urban_extract);
    
    figure(10+i); hold on; box on;
    plot(yr, urban_CHN(i,:), 'rs-', 'markersize', 7, 'linewidth', 1);
    if i == 1
        legend('No Policy', 'Action Plan Egy Int Target', '12th FYP SO2 Target', 2);
    end
    
    disp('==============================');
    disp(urban_id{1}(i));
    urban_2012 = interp1(yr, urban_CHN(i,:), 2012)
    urban_2017 = interp1(yr, urban_CHN(i,:), 2017)
    pctg = (urban_2017-urban_2012)/urban_2012
    
    text(2007, urban_CHN(i,1)*0.7, ['change in 2012-2017: ', num2str(pctg*100, '%2.0f'), '%'], 'color', 'r');
    
    export_filename = ['fig_', char(urban_id{1}(i))];
    my_gridline;
%     export_fig(export_filename);
end

