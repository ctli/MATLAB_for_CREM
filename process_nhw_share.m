clear
close all
clc

yr = [2007,2010,2015,2020,2025,2030];

gdx_filename = 'result_urban_exo.gdx';


%% Check NHW share
% Calculation in CREM
[report, report_id] = getgdx(gdx_filename, 'report');
nhw_share_n_v1 = squeeze(report(strcmp('nhw_share', report_id{1}),:,strcmp('CHN', report_id{3})));

% My calculation for douple check
[report, report_id] = getgdx(gdx_filename, 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
egycons_n = sum(egycons,2);

[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
nhw_consumption = squeeze(egyreport2(1,:,strcmp('NHW', egyreport2_id{3}),1:30))/0.12*0.356;
nhw_consumption_n = sum(nhw_consumption,2);
nhw_share_n_v2 = nhw_consumption_n./egycons_n;

% Plot
figure(1); clf; hold on; box on;
plot(yr, nhw_share_n_v1, 'o-', yr, nhw_share_n_v2, 'x-');

ylabel('NWH Share (-)');
legend('Calculation in CREM', 'My calculation for douple check');


%% ========================================================================
gdx_collection = { ...
    'result_cint_n_2.gdx', ...
    'result_cint_n_25.gdx', ...
    'result_cint_n_3.gdx', ...
    'result_cint_n_35.gdx', ...
    'result_cint_n_4.gdx', ...
    'result_cint_n_45.gdx', ...
    'result_cint_n_5.gdx', ...
    'result_cint_n_55.gdx', ...
    'result_cint_n_6.gdx', ...
    };

stringency = -2:-0.5:-6;

for f = 1:length(gdx_collection)
gdx_filename = gdx_collection{f};
    
[report, report_id] = getgdx(gdx_filename, 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30));
egycons_n = sum(egycons,2);

[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
col_share = col_consumption_n./egycons_n;

gas_consumption = squeeze(egyreport2(1,:,strcmp('GAS', egyreport2_id{3}),1:30));
gas_consumption_n = sum(gas_consumption,2);
gas_share = gas_consumption_n./egycons_n;

oil_consumption = squeeze(egyreport2(1,:,strcmp('OIL', egyreport2_id{3}),1:30));
oil_consumption_n = sum(oil_consumption,2);
oil_share = oil_consumption_n./egycons_n;

nhw_consumption = squeeze(egyreport2(1,:,strcmp('NHW', egyreport2_id{3}),1:30))/0.12*0.356;
nhw_consumption_n = sum(nhw_consumption,2);
nhw_share_n = nhw_consumption_n./egycons_n;

total_share = nhw_share_n + col_share + gas_share + oil_share;

figure(f); clf;
plot(yr, col_share, 'x-', ...
     yr, gas_share, 'x-', ... % almost zero all the time
     yr, oil_share, 'x-', ...
     yr, nhw_share_n, 'x-', ...
     yr, total_share, 'kx-');

ylim([0 1.05]);
xlim([2010 2030]);
set(gca, 'xtick', 2010:5:2030);
grid on;
ylabel('Energy Share by Fuel Type (-)');
legend('COL', 'GAS', 'OIL', 'NHW', 'Total');

title(['CO2 Intensity :', num2str(stringency(f)), '% Reducction per Year']);

set(gcf, 'unit', 'inch', 'pos', [0.15+4.15*(f-1)    5.35    4.0000    3.0000]);
end


