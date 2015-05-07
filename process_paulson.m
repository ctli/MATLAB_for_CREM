clear
close all
clc
format compact

yr = [2007,2010,2015,2020,2025,2030];


%% CO2
figure(1); clf; hold on; box on;

gdx_filename = 'result_urban_exo.gdx';
co2_chk = getgdx(gdx_filename, 'co2_chk');
co2_chk_n = sum(co2_chk);
plot(yr, co2_chk_n/1e3, 'k^-', 'markersize', 7, 'linewidth', 1);

% ==========
gdx_filename = 'result_ccap_n.gdx';
co2_chk = getgdx(gdx_filename, 'co2_chk');
co2_chk_n = sum(co2_chk);
plot(yr, co2_chk_n/1e3, 'bo-', 'markersize', 7, 'linewidth', 1, 'color', [0.2 0.5 1]);

legend('Business as Usual', 'w/ CO2 Price'); % font in Chinese
set(legend, 'fontsize', 9, 'location', 'northwest');
set(gca, 'fontsize', 10);
ylabel('CO_2 (Gt)', 'Fontsize', 12, 'fontweight', 'bol');
set(gcf, 'unit', 'inch', 'pos', [0.15    7.35    4.0000    3.0000]);
xlim([2010 2030]);
ylim([0 20]);
set(gca, 'ytick', 0:5:20);
% my_gridline;

% text(2006, 0.75, {'(China^\primes latest target: CO2 peaks around 2030)'}, 'fontsize', 8, 'color', [0.4 0.4 0.4], 'verticalalignment', 'bottom');

% export_fig CO2 -painters;


%% Energy intensity
figure(2); clf; hold on; box on;

gdx_filename = 'result_urban_exo.gdx';
egy_intensity_n = getgdx(gdx_filename, 'egy_intensity_n');
plot(yr, egy_intensity_n, 'k^-', 'markersize', 7, 'linewidth', 1);

gdx_filename = 'result_ccap_n.gdx';
egy_intensity_n = getgdx(gdx_filename, 'egy_intensity_n');
pctg = (1-egy_intensity_n(2:end)./egy_intensity_n(1:end-1))';
plot(yr, egy_intensity_n, 'bo-', 'markersize', 7, 'linewidth', 1, 'color', [0.2 0.5 1]);

% pctg(2:3) = 0.2;
for i = 3:6, text(yr(i), egy_intensity_n(i)-0.04, [num2str(-pctg(i-1)*100, '%2.0f'), '%'], 'fontsize', 8, 'horizontalalignment', 'center', 'color', [0.2 0.5 1]); end

xlim([2010 2030]);
ylim([0 0.8]);
set(gcf, 'unit', 'inch', 'pos', [4.36    7.35    4.0000    3.0000]);
set(gca, 'fontsize', 10);
ylabel('Energy Intensity (tce/k$)', 'fontsize', 12, 'fontweight', 'bold');
legend('Business as Usual', 'w/ CO2 Price');
set(legend, 'location', 'southwest');
my_gridline;

% export_fig EGY_intensity -painters;


%% GDP
figure(3); clf; hold on; box on;

gdx_filename = 'result_urban_exo.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
h1  = plot(yr, GDP_n, 'k^-', 'markersize', 7, 'linewidth', 1);
GDP_n_BAU = GDP_n;

% ==============================
gdx_filename = 'result_ccap_n.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
h2 = plot(yr, GDP_n, 'bo-', 'markersize', 7, 'linewidth', 1, 'color', [0.2 0.5 1]);

GDP_n_AP = GDP_n;

pctg = GDP_n(end)/GDP_n_BAU(end) - 1;
text(yr(end), GDP_n(end)-800, [num2str(pctg*100, '%2.0f'), '%'], 'fontsize', 8, 'horizontalalignment', 'center', 'color', 'b'); 
text(yr(end), GDP_n(end)-2100, {'(relative to', ' BAU)'}, 'fontsize', 7, 'horizontalalignment', 'center', 'color', 'b'); 

xlim([2010 2030]);
ylim([0 16000]);
set(gca, 'fontsize', 10);
ylabel('GDP (Billion USD in 2007 value)', 'Fontsize', 12, 'fontweight', 'bold');
set(gcf, 'unit', 'inch', 'pos', [8.55    7.35    4.0000    3.0000]);
legend('Business as Usual', 'w/ CO2 Price');
set(legend, 'location', 'northwest');
my_gridline;

% export_fig GDP -painters;


%% Urban emission breakdown barchart (combustion emission vs. process emission)
[urban_c, urban_c_id] = getgdx('result_urban_exo.gdx', 'urban_c'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[8]x[6]
[urban_o, urban_o_id] = getgdx('result_urban_exo.gdx', 'urban_o'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[11]x[6]

wd = 0.15;
sf = 0.41;

for i = 1:length(urban_c_id{1})
urb_c = squeeze(urban_c(strcmp(urban_c_id{1}(i), urban_c_id{1}),:,:,:)); % [30]x[8]x[6]
urb_c_g = squeeze(sum(urb_c,2)); % [30]x[6]
urb_c_n = sum(urb_c_g); % [1]x[6]

urb_o = squeeze(urban_o(strcmp(urban_o_id{1}(i), urban_o_id{1}),:,:,:)); % [30]x[8]x[6]
urb_o_g = squeeze(sum(urb_o(:,1:end-1,:),2)); % [30]x[6]
urb_o_n = sum(urb_o_g); % [1]x[6]
urb_o_b = squeeze(sum(urb_o(:,end,:))); % biomass burning

figure(i+3); clf; hold on; box on;
hb0 = bar(yr(2:end)-sf, [urb_c_n(2:end); urb_o_n(2:end); urb_o_b(2:end)']', wd, 'stacked', 'edgecolor', 'none');
colormap copper
set(hb0(1), 'facec', [0.5 0 0]); %biomass burning

hb1 = bar(yr(2:end)-sf, sum([urb_c_n(2:end); urb_o_n(2:end); urb_o_b(2:end)']), wd, 'stacked', 'facec', 'none', 'edgecolor', 'k', 'linewidth', 1);

set(gca, 'fontsize', 10);
set(gca, 'layer', 'top');
set(gcf, 'unit', 'inch', 'pos', [0.25+4.15*(i-1)    2.865    4.0000    3.0000]);
set(gca, 'pos', [0.1458    0.1100    0.7722    0.8150]);
set(gca, 'layer', 'bottom');
ylabel([char(cellstr(urban_c_id{1}(i))), ' (Tg)'], 'fontsize', 12, 'fontweight', 'bold');
xlim([2009 2031]);
% legend(fliplr(hb0), 'Biomass Burning & Other', 'Industrial Process', 'Fossil Fuel Combustion');
legend(fliplr(hb0), '生物?燃?或其他', '工??程', '化石燃料燃?');
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
if i == 9, ylim([0 60]); end
end

% ==========
[urban_c, urban_c_id] = getgdx('result_ccap_n.gdx', 'urban_c'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[8]x[6]
[urban_o, urban_o_id] = getgdx('result_ccap_n.gdx', 'urban_o'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[10]x[6]
for i = 1:length(urban_c_id{1})
urb_c = squeeze(urban_c(strcmp(urban_c_id{1}(i), urban_c_id{1}),:,:,:)); % [30]x[8]x[6]
urb_c_g = squeeze(sum(urb_c,2)); % [30]x[6]
urb_c_n = sum(urb_c_g); % [1]x[6]

urb_o = squeeze(urban_o(strcmp(urban_o_id{1}(i), urban_o_id{1}),:,:,:)); % [30]x[8]x[6]
urb_o_g = squeeze(sum(urb_o(:,1:end-1,:),2)); % [30]x[6]
urb_o_n = sum(urb_o_g); % [1]x[6]
urb_o_b = squeeze(sum(urb_o(:,end,:))); % biomass burning

figure(i+3); 
hb0 = bar(yr(2:end)+sf, [urb_c_n(2:end); urb_o_n(2:end); urb_o_b(2:end)']', wd, 'stacked', 'edgecolor', 'none', 'linewidth', 2);
set(hb0(1), 'facec', [0.5 0 0]); %biomass burning
hb1 = bar(yr(2:end)+sf, sum([urb_c_n(2:end); urb_o_n(2:end); urb_o_b(2:end)']), wd, 'stacked', 'facec', 'none', 'edgecolor', [0.2 0.5 1], 'linewidth', 1);

% annotation('textbox',...
%     [0.20 0.916666666666666 0.5 0.0892777777777762],...
%     'String',{'Black: Business as Usual;'},...
%     'FitBoxToText','off', 'linestyle', 'none', 'fontsize', 9);
% 
% annotation('textbox',...
%     [0.585 0.916666666666666 0.5 0.0892777777777762],...
%     'String',{'Blue: w/ CO2 Price'},...
%     'FitBoxToText','off', 'linestyle', 'none', 'fontsize', 9, 'color', [0.2 0.5 1]);

annotation('textbox',...
    [0.30 0.906666666666666 0.5 0.0892777777777762],...
    'String',{'黑：基准情景'},...
    'FitBoxToText','off', 'linestyle', 'none', 'fontsize', 9);

annotation('textbox',...
    [0.52 0.906666666666666 0.5 0.0892777777777762],...
    'String',{'?：有碳价格'},...
    'FitBoxToText','off', 'linestyle', 'none', 'fontsize', 9, 'color', [0.2 0.5 1]);

file_name = ['bar_', char(cellstr(urban_c_id{1}(i)))];
% export_fig(file_name);

end


%% Chinese labeling

% Chinese labels
figure(1); % co2
ylabel('二氧化碳（十?吨）');
legend('基准情景', '有碳价格'); % font in Chinese
set(legend, 'location', 'northwest');
my_gridline;
% export_fig CO2_chinese -painters;

figure(6); % bar for NH3
ylabel('氨气 (太克)');
% export_fig NH3_chinese -painters;

figure(7); % bar for NOx
ylabel('氮氧化物 (太克)');
% export_fig NOx_chinese -painters;

figure(11); % bar for SO2
ylabel('二氧化硫 (太克)');
% export_fig SO2_chinese -painters;

figure(12); % bar for VOC
ylabel('??性有机化合物 (太克)');
% export_fig VOC_chinese -painters;


