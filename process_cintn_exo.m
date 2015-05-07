clear
close all
clc
format compact

r = {'BJ','TJ','HE','SX','SD','NM','LN','JL','HL','SH','JS','ZJ','AH','FJ','HA','HB','HN','JX','SC','CQ','SN','GS','QH','NX','XJ','GD','GX','YN','GZ','HI'};
yr = [2007,2010,2015,2020,2025,2030];

gdx_collection = { ...
    'result_cint_n_2', ...
    'result_cint_n_25', ...
    'result_cint_n_3', ...
    'result_cint_n_35', ...
    'result_cint_n_4', ...
    'result_cint_n_45', ...
    'result_cint_n_5', ...
    'result_cint_n_55', ...
    'result_cint_n_6', ...
};

color_range = [
    0 0 1
    0 1 1
    0 0.7 0];
color_code = [
    interp1(linspace(1,length(gdx_collection), size(color_range,1)), color_range(:,1), 1:length(gdx_collection))
    interp1(linspace(1,length(gdx_collection), size(color_range,1)), color_range(:,2), 1:length(gdx_collection))
    interp1(linspace(1,length(gdx_collection), size(color_range,1)), color_range(:,3), 1:length(gdx_collection))]';


%% CO2
figure(1); clf; hold on; box on;

gdx_filename = 'result_default.gdx'; 
co2_chk = getgdx(gdx_filename, 'co2_chk');
co2_chk_n = sum(co2_chk);
plot(yr, co2_chk_n/1e3, 'ks-', 'markersize', 7, 'linewidth', 1);
% ====================
gdx_filename = 'result_urban_exo.gdx'; 
co2_chk = getgdx(gdx_filename, 'co2_chk');
co2_chk_n = sum(co2_chk);
plot(yr, co2_chk_n/1e3, 'kx-', 'markersize', 7, 'linewidth', 1);
% ====================
for f = 1:length(gdx_collection)
    gdx_filename = [gdx_collection{f}, '_no.gdx'];
    co2_chk = getgdx(gdx_filename, 'co2_chk');
    co2_chk_n = sum(co2_chk);
    h(f) = plot(yr, co2_chk_n/1e3, 's-', 'markersize', 5, 'linewidth', 1, 'color', color_code(f,:));
end
% ====================
for f = 1:length(gdx_collection)
    gdx_filename = [gdx_collection{f}, '_ex'];
    co2_chk = getgdx(gdx_filename, 'co2_chk');
    co2_chk_n = sum(co2_chk);
    h(f) = plot(yr, co2_chk_n/1e3, 'x-', 'markersize', 5, 'linewidth', 1, 'color', color_code(f,:));
end

set(gcf, 'unit', 'inch', 'pos', [0.15    7.35    4.0000    3.0000]);
set(gca, 'fontsize', 10);
xlim([2010 2030]);
ylim([0 20]);
set(gca, 'ytick', 0:5:20);
ylabel('CO_2 (Gt)', 'Fontsize', 12, 'fontweight', 'bold');
grid on;

% export_fig('CO2', '-painters');


%% GDP
figure(2); clf; hold on; box on;

gdx_filename = 'result_default.gdx'; 
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
plot(yr, GDP_n, 'ks-', 'markersize', 7, 'linewidth', 1);
% ====================
gdx_filename = 'result_urban_exo.gdx'; 
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
plot(yr, GDP_n, 'kx-', 'markersize', 7, 'linewidth', 1);
% ====================
for f = 1:length(gdx_collection)
    gdx_filename = [gdx_collection{f}, '_no.gdx'];
    [report, report_id] = getgdx(gdx_filename, 'report');
    GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
    GDP_n = sum(GDP,2);
    h(f) = plot(yr, GDP_n, 's-', 'markersize', 5, 'linewidth', 1, 'color', color_code(f,:));
end
% ====================
for f = 1:length(gdx_collection)
    gdx_filename = [gdx_collection{f}, '_ex'];
    [report, report_id] = getgdx(gdx_filename, 'report');
    GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
    GDP_n = sum(GDP,2);
    h(f) = plot(yr, GDP_n, 'x-', 'markersize', 5, 'linewidth', 1, 'color', color_code(f,:));
end

ylabel('GDP');


%% Urban emission
fini = 3;

gdx_filename = 'result_default.gdx';
[urban, urban_id] = getgdx(gdx_filename, 'urban');
urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
for i = 9%1:length(urban_id{1})
    urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
    urban_CHN(i,:) = sum(urban_extract);
    
    figure(fini+i); hold on; box on;
    h(f) = plot(yr, urban_CHN(i,:), 'ks-', 'markersize', 5, 'linewidth', 1);
end
% ====================
gdx_filename = 'result_urban_exo.gdx';
[urban, urban_id] = getgdx(gdx_filename, 'urban');
urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
for i = 9%1:length(urban_id{1})
    urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
    urban_CHN(i,:) = sum(urban_extract);
    
    figure(fini+i); hold on; box on;
    h(f) = plot(yr, urban_CHN(i,:), 'kx-', 'markersize', 5, 'linewidth', 1);
end
% ====================
for f = 1:length(gdx_collection)
    gdx_filename = [gdx_collection{f}, '_no.gdx'];
    [urban, urban_id] = getgdx(gdx_filename, 'urban');
    urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
    for i = 9%1:length(urban_id{1})
        urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
        urban_CHN(i,:) = sum(urban_extract);
        
        figure(fini+i); hold on; box on;
        h(f) = plot(yr, urban_CHN(i,:), 's-', 'markersize', 5, 'linewidth', 1, 'color', color_code(f,:));
    end
end
% ====================
for f = 1:length(gdx_collection)
    gdx_filename = [gdx_collection{f}, '_ex.gdx'];
    [urban, urban_id] = getgdx(gdx_filename, 'urban');
    urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
    for i = 9%1:length(urban_id{1})
        urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
        urban_CHN(i,:) = sum(urban_extract);
        
        figure(fini+i); hold on; box on;
        h(f) = plot(yr, urban_CHN(i,:), 'x-', 'markersize', 5, 'linewidth', 1, 'color', color_code(f,:));
    end
end

