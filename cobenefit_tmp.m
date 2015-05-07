clear
close all
clc
format compact

yr = [2007,2010,2015,2020,2025,2030];

gdx_collection = { ...
    'result_cint_n_2_ex', ...
    'result_cint_n_3_ex', ...
    'result_cint_n_4_ex', ...
    'result_cint_n_5_ex', ...
    'result_cint_n_6_ex', ...
};

%%
color_code = [
1 0 0
1 0.5 0.7
1 0.65 0.2
0 0.8 0
0 0.5 1
];

% CO2
figure(1); clf; hold on; box on;

gdx_filename = 'result_default.gdx'; 
co2_chk = getgdx(gdx_filename, 'co2_chk');
co2_chk_n = sum(co2_chk);
plot(yr, co2_chk_n/1e3, 'ko-', 'markersize', 6, 'linewidth', 1);
% ====================
for f = 1:length(gdx_collection)
    gdx_filename = gdx_collection{f};
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


%%
ini = 1;

gdx_filename = 'result_cint_n_2_ex';
[urban, urban_id] = getgdx(gdx_filename, 'urban');
urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
for i = 1:length(urban_id{1})
    urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
    urban_CHN(i,:) = sum(urban_extract);
end

for i = 1:length(urban_id{1})
figure(i+ini); clf;
plot(yr, urban_CHN(i,:), 's-', 'color', [1 0.65 0.2], 'markerf', [1 0.65 0.2]);
set(gcf, 'unit', 'inch', 'pos', [0.3+0.3*i    4.3-0.3*i    4.0000    3.0000]);
end


gdx_filename = 'result_cint_n_2_no';
[urban, urban_id] = getgdx(gdx_filename, 'urban');
urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
for i = 1:length(urban_id{1})
    urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
    urban_CHN(i,:) = sum(urban_extract);
end

for i = 1:length(urban_id{1})
figure(i+ini); hold on;
plot(yr, urban_CHN(i,:), 's--', 'color', [1 0.65 0.2], 'markerf', [1 0.65 0.2]);
set(gca, 'fontsize', 8);
ylabel([char(urban_id{1}(i)) ' Emissions (mmt)'], 'fontsize', 10);
set(gcf, 'unit', 'inch', 'pos', [0.3+0.3*i    4.3-0.3*i    4.0000    3.0000]);
xlim([2010 2030]);
grid on;

legend('Constant Emission Factor', 'Time-envolving Emission Factor');
set(legend, 'location', 'southeast', 'fontsize', 10);
end

% export_fig tmp;

