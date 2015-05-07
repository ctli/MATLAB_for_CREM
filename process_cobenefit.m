clear
close all
clc
format compact

r = {'BJ','TJ','HE','SX','SD','NM','LN','JL','HL','SH','JS','ZJ','AH','FJ','HA','HB','HN','JX','SC','CQ','SN','GS','QH','NX','XJ','GD','GX','YN','GZ','HI'};
yr = [2007,2010,2015,2020,2025,2030];

stringency = -2:-1:-6;

% % Consant emission factor
% gdx_bau = 'result_default.gdx';
% gdx_collection = { ...
%     'result_cint_n_2_no.gdx', ...
%     'result_cint_n_3_no.gdx', ...
%     'result_cint_n_4_no.gdx', ...
%     'result_cint_n_5_no.gdx', ...
%     'result_cint_n_6_no.gdx', ...
%     };

% Exogenous emission factor
gdx_bau = 'result_urban_exo.gdx';
gdx_collection = { ...
    'result_cint_n_2_ex.gdx', ...
    'result_cint_n_3_ex.gdx', ...
    'result_cint_n_4_ex.gdx', ...
    'result_cint_n_5_ex.gdx', ...
    'result_cint_n_6_ex.gdx', ...
    };

%%blue-green gradient
% color_range = [
%     0 0 1
%     0 1 1
%     0 0.7 0];
% color_code = [
%     interp1(linspace(1,length(gdx_collection), size(color_range,1)), color_range(:,1), 1:length(gdx_collection))
%     interp1(linspace(1,length(gdx_collection), size(color_range,1)), color_range(:,2), 1:length(gdx_collection))
%     interp1(linspace(1,length(gdx_collection), size(color_range,1)), color_range(:,3), 1:length(gdx_collection))]';

%%rainbow color
% color_code = [1 0 0
%               1 0.65 0
%               1 1 0 % yellow
%               0 0.75 0
%               0 0.35 1];

color_code = [
1 0 0      %red
1 0.5 0.9  %pink
1 0.65 0.2 %orange 
0 0.8 0    %green
0 0.5 1    %blue
];

marker_symbol = {'^', 'x', 's', '*', 'v'};


%% CO2
figure(1); clf; hold on; box on;

gdx_filename = gdx_bau;
co2_chk = getgdx(gdx_filename, 'co2_chk');
co2_chk_n = sum(co2_chk);
h1 = plot(yr, co2_chk_n/1e3, 'ko-', 'markerf', 'k', 'linewidth', 1);
% ====================
for f = 1:length(gdx_collection)
    gdx_filename = gdx_collection{f};
    co2_chk = getgdx(gdx_filename, 'co2_chk');
    co2_chk_n = sum(co2_chk);
    h(f) = plot(yr, co2_chk_n/1e3, 'x-', 'linewidth', 1, 'color', color_code(f,:), 'markerf', color_code(f,:));
    set(h(f), 'marker', char(marker_symbol(f)));
end

% ====================
set(gcf, 'unit', 'inch', 'pos', [0.15    2.55    5.0000    3.7500]);
set(gca, 'fontsize', 10);
xlim([2010 2030]);
ylim([0 20]);
set(gca, 'ytick', 0:5:20);
ylabel('CO2 (bmt)', 'Fontsize', 12, 'fontweight', 'bold');
grid on;

legend([h1, h], 'Reference','2%/yr Reduction in CO2 Intensity', '3%/yr Reduction in CO2 Intensity', '4%/yr Reduction in CO2 Intensity', '5%/yr Reduction in CO2 Intensity', '6%/yr Reduction in CO2 Intensity');
% set(legend, 'location', 'northwest');
set(legend, 'pos', [0.155    0.1237    0.4583    0.2726]);
text(2010.5, 19.5, {'(China^\primes latest carbon target:', 'peak CO2 around 2030)'}, 'fontsize', 11, 'color', [0.4 0.4 0.4], 'verticalalignment', 'top', 'horizontalalignment', 'left');

% export_fig('CO2', '-painters');


%% CO2 intensity
figure(2); clf; hold on; box on;

gdx_filename = gdx_bau;
co2_intensity_n = getgdx(gdx_filename, 'co2_intensity_n');
h1 = plot(yr, co2_intensity_n, 'ko-', 'markerf', 'k', 'markersize', 5, 'linewidth', 1);
% ====================
for f = 1:length(gdx_collection)
    gdx_filename = gdx_collection{f};
    co2_intensity_n = getgdx(gdx_filename, 'co2_intensity_n');
    h(f) = plot(yr, co2_intensity_n, 'x-', 'linewidth', 1, 'color', color_code(f,:), 'markerf', color_code(f,:));
    set(h(f), 'marker', char(marker_symbol(f)));
end
% ====================
set(gcf, 'unit', 'inch', 'pos', [5.35    6.55    5.000    3.7500]);
set(gca, 'fontsize', 10);
xlim([2010 2030]);
ylim([0 1.8]);
set(gca, 'ytick', 0:0.3:1.8);
ylabel('CO2 Intensity (tCO2/kUSD)', 'Fontsize', 12, 'fontweight', 'bold');
grid on;

legend([h1, h], 'Reference','2%/yr Reduction in CO2 Intensity', '3%/yr Reduction in CO2 Intensity', '4%/yr Reduction in CO2 Intensity', '5%/yr Reduction in CO2 Intensity', '6%/yr Reduction in CO2 Intensity');
set(legend, 'fontsize', 10);
set(legend, 'pos', [0.16    0.13    0.4855    0.2827]);
% set(legend, 'location', 'southwest');

% export_fig CO2_intensity -crop


%% GDP
figure(3); clf; hold on; box on;

gdx_filename = gdx_bau;
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
h1  = plot(yr, GDP_n/1d3, 'ko-', 'markerf', 'k', 'linewidth', 1);
% ====================
for f = 1:length(gdx_collection)
    gdx_filename = gdx_collection{f};
    [report, report_id] = getgdx(gdx_filename, 'report');
    GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
    GDP_n = sum(GDP,2);
    h(f) = plot(yr, GDP_n/1e3, 'x-', 'linewidth', 1, 'color', color_code(f,:), 'markerf', color_code(f,:));
    set(h(f), 'marker', char(marker_symbol(f)));
end
% ====================
set(gcf, 'unit', 'inch', 'pos', [10.55   6.55    5.0000    3.7500]);
set(gca, 'fontsize', 10);
xlim([2010 2030]);
ylim([0 16]);
ylabel('GDP (Trillion USD in 2007 Value)', 'Fontsize', 12, 'fontweight', 'bold');
grid on;

legend([h1, h], 'Reference','2%/yr Reduction in CO2 Intensity', '3%/yr Reduction in CO2 Intensity', '4%/yr Reduction in CO2 Intensity', '5%/yr Reduction in CO2 Intensity', '6%/yr Reduction in CO2 Intensity');
% set(legend, 'location', 'southeast');
set(legend, 'fontsize', 9, 'pos', [0.452    0.1263    0.3974    0.2589]);

% export_fig GDP -painters;


%% urban emissions
figure(4); clf;
set(gcf, 'unit', 'inch', 'pos', [0.35   2.00   10.00    8]);

gdx_filename = gdx_bau;
[urban, urban_id] = getgdx(gdx_filename, 'urban');
urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));

fig_order = [8, 4, 3, 2, 9, 1, 5, 6, 7];
for i = 1:length(urban_id{1})
    urban_extract = squeeze(sum(squeeze(urban(fig_order(i),:,:,:)),2));
    urban_CHN(fig_order(i),:) = sum(urban_extract);
    
    subplot(3,3,i); hold on; box on;
    plot(yr, urban_CHN(fig_order(i),:), 'ko-', 'markerf', 'k', 'linewidth', 1);
    set(gca, 'fontsize', 10);
    if i<9
        ylabel([char(cellstr(urban_id{1}(fig_order(i)))), ' Emission (mmt)'], 'fontsize', 12, 'fontweight', 'bold');
    else
        ylabel('PM2.5 Emission (mmt)', 'fontsize', 12, 'fontweight', 'bold');
    end
    
    xlim([2010 2030]);
    
    if fig_order(i) == 1, ylim([0 2.4]); set(gca, 'ytick', 0:0.4:2.4); end
    if fig_order(i) == 2, ylim([0 500]); end
    if fig_order(i) == 3, ylim([0 30]); end
    if fig_order(i) == 4, ylim([0 60]); end
    if fig_order(i) == 5, ylim([0 4]); end
    if fig_order(i) == 6, ylim([0 50]); end
    if fig_order(i) == 7, ylim([0 30]); end
    if fig_order(i) == 8, ylim([0 80]); end
    if fig_order(i) == 9, ylim([0 60]); end
end

% ==========
text_color = [0.7 0.7 0.7];
for f = 1:length(gdx_collection)
    gdx_filename = gdx_collection{f};
    
    [urban, urban_id] = getgdx(gdx_filename, 'urban');
    urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
    for i = 1:length(urban_id{1})
        urban_extract = squeeze(sum(squeeze(urban(fig_order(i),:,:,:)),2));
        urban_CHN(fig_order(i),:) = sum(urban_extract);
        
        subplot(3,3,i);
        h(f) = plot(yr, urban_CHN(fig_order(i),:), 'x-', 'linewidth', 1, 'color', color_code(f,:), 'markerf', color_code(f,:));
        set(h(f), 'marker', char(marker_symbol(f)));
        
        if strcmp(urban_id{1}(fig_order(i)), 'SO2')
            plot (yr(2:end),  urban_CHN(fig_order(i),2)*[0.92^0, 0.92^1, 0.92^2, 0.92^3, 0.92^4], '--', 'color', [0.6 0.6 0.6]);
            text(2016.5, 20, {'12th FYP target:'}, 'color', text_color, 'fontsize', 8, 'rotation', -0, 'horizontalalignment', 'center');
            text(2019, 19-5.5, {'8% SO2 reduction in 2011-2015'}, 'color', text_color, 'fontsize', 8, 'rotation', -0, 'horizontalalignment', 'center');
        end
        
        if strcmp(urban_id{1}(fig_order(i)), 'NOX')
            plot (yr(2:end),  urban_CHN(fig_order(i),2)*[0.9^0, 0.9^1, 0.9^2, 0.9^3, 0.9^4], '--', 'color', text_color);
            text(2016.5, 17.7, {'12th FYP target:'}, 'color', text_color, 'fontsize', 8, 'rotation', -0, 'horizontalalignment', 'center');
            text(2019, 13, {'10% NOx reduction in 2011-2015'}, 'color', text_color, 'fontsize', 8, 'rotation', -0, 'horizontalalignment', 'center');
        end
        
        if (i==3) && (f==length(gdx_collection))
            legend('Reference','2%/yr Reduction in CO2 Intensity', '3%/yr Reduction in CO2 Intensity', '4%/yr Reduction in CO2 Intensity', '5%/yr Reduction in CO2 Intensity', '6%/yr Reduction in CO2 Intensity');
            set(legend, 'fontsize', 7);
            set(legend ,'location', 'south');
            set(legend, 'pos', [0.6947    0.715    0.2015    0.1000]);
        end
        if (f==length(gdx_collection))
            my_gridline([0.9 0.9 0.9]);
        end
    end
end
% export_fig 'fig_emission';


%% urban emissions (constant emission factor vs. time-varying emissin factor)
figure(5); clf;
set(gcf, 'unit', 'inch', 'pos', [0.35   2.00   10.00    8]);

gdx_prefix = { ...
    'result_cint_n_2', ...
    'result_cint_n_3', ...
    'result_cint_n_4', ...
    'result_cint_n_5', ...
    'result_cint_n_6', ...
    };

fig_order = [8, 4, 3, 2, 9, 1, 5, 6, 7];
for f = 3
    gdx_filename = [gdx_prefix{f} ,'_ex.gdx'];
    
    [urban, urban_id] = getgdx(gdx_filename, 'urban');
    urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
    for i = 1:length(urban_id{1})
    urban_extract = squeeze(sum(squeeze(urban(fig_order(i),:,:,:)),2));
    urban_CHN(fig_order(i),:) = sum(urban_extract);
        
        subplot(3,3,i); hold on; box on;
        h(f) = plot(yr, urban_CHN(fig_order(i),:), 'x-', 'linewidth', 1, 'color', color_code(f,:), 'markerf', color_code(f,:));
        set(h(f), 'marker', char(marker_symbol(f)));

        xlim([2010 2030]);
        if i<9
            ylabel([char(cellstr(urban_id{1}(fig_order(i)))), ' Emission (mmt)'], 'fontsize', 12, 'fontweight', 'bold');
        else
            ylabel('PM2.5 Emission (mmt)', 'fontsize', 12, 'fontweight', 'bold');
        end
        
        if fig_order(i) == 1, ylim([0 4]); set(gca, 'ytick', 0:1:4); end
        if fig_order(i) == 2, ylim([0 400]); set(gca, 'ytick', 0:100:400); end
        if fig_order(i) == 3, ylim([0 50]); end
        if fig_order(i) == 4, ylim([0 60]); end
        if fig_order(i) == 5, ylim([0 10]); end
        if fig_order(i) == 6, ylim([0 60]); end
        if fig_order(i) == 7, ylim([0 40]); set(gca, 'ytick', 0:10:40); end
        if fig_order(i) == 8, ylim([0 50]); end
        if fig_order(i) == 9, ylim([0 80]); set(gca, 'ytick', 0:20:80); end
    end
    
    gdx_filename = [gdx_prefix{f} ,'_no.gdx'];
    [urban, urban_id] = getgdx(gdx_filename, 'urban');
    urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
    for i = 1:length(urban_id{1})
        urban_extract = squeeze(sum(squeeze(urban(fig_order(i),:,:,:)),2));
        urban_CHN(fig_order(i),:) = sum(urban_extract);
        
        subplot(3,3,i);
        h(f) = plot(yr, urban_CHN(fig_order(i),:), 'x--', 'linewidth', 1, 'color', color_code(f,:));
        set(h(f), 'marker', char(marker_symbol(f)));
        
        if i==9
            legend('w/ Time-Evolving Emission Factor', 'w/ Constant Emission Factor');
            set(legend, 'orientation', 'horizontal');
            set(legend, 'fontsize', 9);
            set(legend, 'pos', [0.265   0.05    0.5    0.02]);
        end
        
        my_gridline([0.9 0.9 0.9]);
    end
end
% export_fig 'compare_emission';

%% ==========
figure(51); clf;
set(gcf, 'unit', 'inch', 'pos', [0.35   2.00   10.00    8]);

fig_order = [8, 4, 3, 2, 9, 1, 5, 6, 7];
for f = 3
    gdx_filename = 'result_urban_exo.gdx';
    
    [urban, urban_id] = getgdx(gdx_filename, 'urban');
    urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
    for i = 1:length(urban_id{1})
    urban_extract = squeeze(sum(squeeze(urban(fig_order(i),:,:,:)),2));
    urban_CHN(fig_order(i),:) = sum(urban_extract);
        
        subplot(3,3,i); hold on; box on;
        h(f) = plot(yr, urban_CHN(fig_order(i),:), 'ko-', 'linewidth', 1, 'markerf', 'k');
        
        xlim([2010 2030]);
        if i<9
            ylabel([char(cellstr(urban_id{1}(fig_order(i)))), ' Emission (mmt)'], 'fontsize', 12, 'fontweight', 'bold');
        else
            ylabel('PM2.5 Emission (mmt)', 'fontsize', 12, 'fontweight', 'bold');
        end
        
        if i == 1, ylim([0 120]); end
        if i == 2, ylim([0 100]); end
        if i == 3, ylim([0 50]); end
        if i == 4, ylim([0 800]); end
        if i == 5, ylim([0 100]); end
        if i == 6, ylim([0 6]); end
        if i == 7, ylim([0 12]); end
        if i == 8, ylim([0 80]); end
        if i == 9, ylim([0 60]); end
    end
    
    gdx_filename = 'result_default';
    [urban, urban_id] = getgdx(gdx_filename, 'urban');
    urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
    for i = 1:length(urban_id{1})
        urban_extract = squeeze(sum(squeeze(urban(fig_order(i),:,:,:)),2));
        urban_CHN(fig_order(i),:) = sum(urban_extract);
        
        subplot(3,3,i);
        h(f) = plot(yr, urban_CHN(fig_order(i),:), 'ko-', 'linewidth', 1, 'color', 'k', 'markerf', 'w');

        if i==9
            legend('w/ Time-Evolving Emission Factor', 'w/ Constant Emission Factor');
            set(legend, 'orientation', 'horizontal');
            set(legend, 'fontsize', 9);
            set(legend, 'pos', [0.265   0.05    0.5    0.02]);
        end
        
        my_gridline([0.9 0.9 0.9]);
    end
end
% export_fig 'compare_emission_bau';


%% Return of CO2 policy
% figure(6); hold on;
% plot(stringency(f), urban_CHN(i,end)/urban_CHN(i,2), 'x', 'color', color_code(f,:));
% title([char(cellstr(urban_id{1}(i))),], 'fontsize', 12, 'fontweight', 'bold');
% ylim([0 2]);
% defaultratio;
% grid on;
% xlabel('CO2 Intensity Stringency (% Red. per year)');
% ylabel('Level of 2030/2010');
% 


%% Coal share
figure(7); clf; hold on; box on;

gdx_filename = gdx_bau;
[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);

[report, report_id] = getgdx(gdx_filename, 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
egycons_n = sum(egycons,2);

col_share_n = col_consumption_n./egycons_n;

h1 = plot(yr, col_share_n, 'ko-', 'markerf', 'k', 'linewidth', 1);
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
    
    h(f) = plot(yr, col_share_n, 'x-', 'linewidth', 1, 'color', color_code(f,:),  'markerf', color_code(f,:));
    set(h(f), 'marker', char(marker_symbol(f)));
end
% ====================
set(gcf, 'unit', 'inch', 'pos', [20.1354    6.15    5.0000    3.7500]);
set(gca, 'fontsize', 10);
ylim([0 0.8]);
xlim([2010 2030]);
ylabel('Coal Share (-)', 'Fontsize', 12, 'fontweight', 'bold');
grid on;

legend([h1, h], 'Reference','2%/yr Reduction in CO2 Intensity', '3%/yr Reduction in CO2 Intensity', '4%/yr Reduction in CO2 Intensity', '5%/yr Reduction in CO2 Intensity', '6%/yr Reduction in CO2 Intensity');
% set(legend, 'location', 'southeast');
set(legend, 'fontsize', 9, 'pos', [0.465    0.1263    0.3974    0.2589]);

line([2005 2030], [1 1]*0.65, 'linestyle', '--', 'color', [0.4 0.4 0.4]);
text(2010.75, 0.52, {'Air Pollution Action Plan Target:', 'Coal Share below 65% by 2017'}, 'fontsize', 10, 'color', [0.4 0.4 0.4], 'verticalalignment', 'top');

axx=[2011.5 2011]+0.2;
axy=[0.525 0.65];
[arrowx,arrowy] = dsxy2figxy(gca, axx, axy);
annotation('arrow',arrowx,arrowy,'headwidth',5,'headlength',5, 'color', [0.4 0.4 0.4]);

% export_fig coal_share -painters;


%% Oil share
figure(7); clf; hold on; box on;

gdx_filename = gdx_bau;
[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
oil_consumption = squeeze(egyreport2(1,:,strcmp('OIL', egyreport2_id{3}),1:30));
oil_consumption_n = sum(oil_consumption,2);

[report, report_id] = getgdx(gdx_filename, 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
egycons_n = sum(egycons,2);

oil_share_n = oil_consumption_n./egycons_n;

h1 = plot(yr, oil_share_n, 'ko-', 'markerf', 'k', 'linewidth', 1);
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
    
    h(f) = plot(yr, oil_share_n, 'x-', 'linewidth', 1, 'color', color_code(f,:),  'markerf', color_code(f,:));
    set(h(f), 'marker', char(marker_symbol(f)));
end
% ====================
set(gcf, 'unit', 'inch', 'pos', [25.35    6.15    5.0000    3.7500]);
set(gca, 'fontsize', 10);
ylim([0 0.8]);
xlim([2010 2030]);
ylabel('Oil Share (-)', 'Fontsize', 12, 'fontweight', 'bold');
grid on;

% export_fig oil_share -painters;


%% Gas share
figure(7); clf; hold on; box on;

gdx_filename = gdx_bau;
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

h1 = plot(yr, gas_share_n, 'ko-', 'markerf', 'k', 'linewidth', 1);
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

    h(f) = plot(yr, gas_share_n, 'x-', 'linewidth', 1, 'color', color_code(f,:),  'markerf', color_code(f,:));
    set(h(f), 'marker', char(marker_symbol(f)));
end
% ====================
set(gcf, 'unit', 'inch', 'pos', [30.55    6.15    5.0000    3.7500]);
set(gca, 'fontsize', 10);
ylim([0 0.8]);
xlim([2010 2030]);
ylabel('Gas Share (-)', 'Fontsize', 12, 'fontweight', 'bold');
grid on;

% export_fig gas_share -painters;

% ylim([0 0.05]);
% set(legend, 'fontsize', 9, 'pos', [0.138    0.12    0.5228    0.2724]);


%% NHW share
figure(10); clf; hold on; box on;

gdx_filename = gdx_bau;
[report, report_id] = getgdx(gdx_filename, 'report');
nhw_share = squeeze(report(strcmp('nhw_share', report_id{1}),:,strcmp('CHN', report_id{3})));
h1 = plot(yr, nhw_share, 'ko-', 'markerf', 'k', 'linewidth', 1);
% ====================
for f = 1:length(gdx_collection)
    gdx_filename = gdx_collection{f};
    [report, report_id] = getgdx(gdx_filename, 'report');
    nhw_share = squeeze(report(strcmp('nhw_share', report_id{1}),:,strcmp('CHN', report_id{3})));
    h(f) = plot(yr, nhw_share, 'x-', 'linewidth', 1, 'color', color_code(f,:),  'markerf', color_code(f,:));
    set(h(f), 'marker', char(marker_symbol(f)));
end
% ====================
set(gcf, 'unit', 'inch', 'pos', [30.55    1.375    5.0000    3.7500]);
set(gca, 'fontsize', 10);
ylim([0 0.8]);
xlim([2010 2030]);
ylabel('Non-Fossil Fuel Share (-)', 'Fontsize', 12, 'fontweight', 'bold');
grid on;

line([2005 2030], [1 1]*0.2, 'linestyle', '--', 'color', [0.4 0.4 0.4]);
text(2010.75, 0.25, {'China\primes target in Air Pollution Action Plan:' ,'non-fossil fuel share higher than 20% by 2030'}, 'fontsize', 10, 'color', [0.4 0.4 0.4]);

% export_fig nhw_share -r300 -painters;


%% energy consumption
figure(11); clf; hold on; box on;
[report, report_id] = getgdx('result_default.gdx', 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
egycons_n = sum(egycons,2);
h1 = plot(yr, egycons_n, 'ko-', 'markerf', 'k', 'linewidth', 1);
% ====================
for f = 1:length(gdx_collection)
    gdx_filename = gdx_collection{f};
    [report, report_id] = getgdx(gdx_filename, 'report');
    egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
    egycons_n = sum(egycons,2);
    h(f) = plot(yr, egycons_n, 'x-', 'linewidth', 1, 'color', color_code(f,:),  'markerf', color_code(f,:));
    set(h(f), 'marker', char(marker_symbol(f)));
end
% ====================
set(gcf, 'unit', 'inch', 'pos', [20.1354   1.35    5.0000    3.7500]);
set(gca, 'fontsize', 10);
xlim([2010 2030]);
ylim([0 9000]);
set(gca, 'ytick', 0:1500:9000);
ylabel('Energy Consumption (mtce)', 'fontsize', 12, 'fontweight', 'bold');
grid on;

% export_fig EGY_consumption -painters;


%% energy consumption by type
figure(12); clf; hold on; box on;
gdx_filename = gdx_bau;
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

set(gcf, 'unit', 'inch', 'pos', [24.3354   1.375    4.0000    3.0000]);
set(gca, 'fontsize', 10);
xlim([2010 2030]);
ylim([0 9000]);
set(gca, 'layer', 'top');
my_gridline('front');
ylabel('Energy Consumption (mtce)', 'fontsize', 12, 'fontweight', 'bold');
title('Business as Usual');

% export_fig egy_area;

%% ====================
figure(13); clf; hold on; box on;
gdx_filename = 'result_cint_n_4_ex.gdx';
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

set(gcf, 'unit', 'inch', 'pos', [32.7354   1.375    4.0000    3.0000]);
set(gca, 'fontsize', 10);
xlim([2010 2030]);
ylim([0 9000]);
set(gca, 'layer', 'top');
my_gridline('front');
title('4%/yr Reduction in CO2 Intensity (per annum)', 'color', [0 1 1]);


%% carbon tax
ptcarb = [
1	0.003844869	0.006945987	0.008335406	0.008630983
1	0.009127046	0.01733625	0.02289573	0.026507300
1	0.015128827	0.030256924	0.04330576	0.054126882
1	0.021957343	0.046672668	0.071200952	0.094562658
1	0.029723685	0.067116392	0.108451561	0.151349237
];

figure(14); clf;
h = plot(yr(3:end), ptcarb(:,2:end)'*1000, 'x-');
ylabel('CO2 Tax (USD/tCO2)', 'fontweight', 'bold');
xlim([2010 2030]);
set(gca, 'xtick', 2010:5:2030);
set(gcf, 'unit', 'inch', 'pos', [10.5500    3.5500    5.0000    3.7500]);
for i = 1:length(h)
    set(h(i), 'color', color_code(i,:), 'marker', char(marker_symbol(i)), 'markerf', color_code(i,:));
end

legend('2%/yr Reduction in CO2 Intensity', '3%/yr Reduction in CO2 Intensity', '4%/yr Reduction in CO2 Intensity', '5%/yr Reduction in CO2 Intensity', '6%/yr Reduction in CO2 Intensity');
set(legend, 'fontsize', 10);
set(legend, 'pos', [0.155    0.68    0.4571    0.2179]);
my_gridline([0.9 0.9 0.9]);

% export_fig CO2tax;

