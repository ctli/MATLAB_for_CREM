clear all
close all
clc
format compact

R = {'BJ','TJ','HE','SX','SD','NM','LN','JL','HL','SH','JS','ZJ','AH','FJ','HA','HB','HN','JX','SC','CQ','SN','GS','QH','NX','XJ','GD','GX','YN','GZ','HI'};
r = 1:30;

rs = {'BJ','TJ','HE','SX','SD','NM','LN','JL','HL','SH','JS','ZJ','AH','FJ','HA','HB','HN','JX','SC','CQ','SN','GS','QH','NX','XJ','GD','GX','YN','GZ','HI', 'USA', 'EUR', 'ODC', 'ROW'};


%% Government tax income
TAXREVa = getgdx('result_egyint_n.gdx', 'TAXREV');
TAXREVb = getgdx('result_egyint_n_coaltax.gdx', 'TAXREV');
dTAXREV = (TAXREVb - TAXREVa)./TAXREVa;

figure(1); clf;
hb = bar(r,[TAXREVa(r),TAXREVb(r)], 'hist');
set(hb(1), 'facec', [1 0.5 0.5], 'edgecolor', 'none');
set(hb(2), 'facec', [0 0.75 0], 'edgecolor', 'none');
xlim([0.4 30.6]);
set(gca, 'fontsize', 7);
ylabel('Government Tax Income in 2030');
set(gca, 'xtick', 1:30);
set(gca, 'xticklabel', R);
set(gca, 'ticklength', [0.005 0.005]);
set(gcf, 'units', 'inch', 'pos', [0.7292    6.7292    9.35    2.45]);
set(gca, 'pos', [0.0569    0.1023    0.9263    0.7883]);
legend('w/ Nat\primel Egy. Int. Target', 'w/ Nat\primel Egy. Int. Target + 20% Coal Tax in 3 Key Regions');
for rn = 1:30, text(rn+0.15, TAXREVb(rn)+2, [num2str(dTAXREV(rn)*100, '%1.2f'), '%'], 'fontsize', 6, 'rotation', 90); end
text(1+0.15, 100, ' (Change in percentage)', 'fontsize', 6, 'rotation', 90);
% export_fig gov_tax_income -painters

figure(2); clf;
bar(r, dTAXREV(r)*100, 0.5, 'facec', [0 0.75 0], 'edgecolor', 'none');
xlim([0.4 30.6]);
ylim([-0.016 0.016]*100);
set(gca, 'ytick', (-0.016:0.004:0.016)*100);
set(gca, 'fontsize', 7);
set(gca, 'xtick', 1:30);
set(gca, 'xticklabel', []);
set(gca, 'ticklength', [0.005 0.005]);
set(gca, 'yminortick', 'on');
set(gcf, 'units', 'inch', 'pos', [0.7292    3.3021    9.35    2.45]);
set(gca, 'pos', [0.0569    0.1023    0.9263    0.7883]);
ylabel('Change in Government Tax Income in 2030 (%)');
for rn = 1:30, text(rn, -0.15, R(rn), 'fontsize', 7, 'horizontalalignment', 'center'); end
my_gridline('y');
% export_fig gov_tax_income_chg -painters


%% National energy consumption
gdx_filename = 'result_egyint_n.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
egycons_n = sum(egycons,2);
fosegycons = squeeze(report(strcmp('fosegycons', report_id{1}),:,1:30));
fosegycons_n = sum(fosegycons,2);
ele_trade = squeeze(report(strcmp('exportELE', report_id{1}),:,1:30));
ele_trade_n = sum(ele_trade,2);

[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
gas_consumption = squeeze(egyreport2(1,:,strcmp('GAS', egyreport2_id{3}),1:30));
gas_consumption_n = sum(gas_consumption,2);
oil_consumption = squeeze(egyreport2(1,:,strcmp('OIL', egyreport2_id{3}),1:30));
oil_consumption_n = sum(oil_consumption,2);
nhw_consumption = squeeze(egyreport2(1,:,strcmp('NHW', egyreport2_id{3}),1:30))/0.12*0.356;
nhw_consumption_n = sum(nhw_consumption,2);

yr = [2007, 2010,2015,2020,2025,2030];

dx = 0.46;
b = 0.3;
figure(3); clf; hold on;
tmp = [fosegycons_n, nhw_consumption_n, -ele_trade_n];
hb = bar(yr-dx, tmp, b, 'stacked', 'edge','none'); hold on;
set(hb(1), 'facec', [0.8 0.8 0.8], 'edge','none');
set(hb(2), 'facec', [0.675 1 0.675], 'edge','none');
set(hb(3), 'facec', 'none', 'edge','k');
bar(yr-dx, egycons_n, b, 'facec', 'none', 'edge', 'b', 'linewidth', 1);
set(gcf, 'units', 'inch', 'pos', [0.7292    3.3021    9.35    2.45]);
set(gca, 'pos', [0.0569    0.1023    0.9263    0.7883]);
set(gca, 'fontsize', 8);
ylabel('Energy Consumption (mtce)');
legend('Fossil Fuel', 'Non-Fossil Fuel (NHW)', 'Ele Exports', 2, 'orientation', 'horizontal');
xlim([2005 2031.2])
box on;

tmp = [col_consumption_n, gas_consumption_n, oil_consumption_n];
hb = bar(yr-dx, tmp, 0.2, 'stacked', 'edge','none'); hold on;
set(hb(1), 'facec', [0.7 0 0]);
set(hb(2), 'facec', [1 1 0]);
set(hb(3), 'facec', [1 0.6 0.6]);
text(yr(1)-dx, col_consumption_n(1)/2, 'COL', 'horizontalalignment', 'center', 'fontsize', 8);
text(yr(1)-dx, col_consumption_n(1)+gas_consumption_n(1)/2, 'GAS', 'horizontalalignment', 'center', 'fontsize', 8);
text(yr(1)-dx, col_consumption_n(1)+gas_consumption_n(1)+oil_consumption_n(1)/2, 'OIL', 'horizontalalignment', 'center', 'fontsize', 8);

% ==========
gdx_filename = 'result_egyint_n_coaltax.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
egycons_n = sum(egycons,2);
fosegycons = squeeze(report(strcmp('fosegycons', report_id{1}),:,1:30));
fosegycons_n = sum(fosegycons,2);
ele_trade = squeeze(report(strcmp('exportELE', report_id{1}),:,1:30));
ele_trade_n = sum(ele_trade,2);

[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
gas_consumption = squeeze(egyreport2(1,:,strcmp('GAS', egyreport2_id{3}),1:30));
gas_consumption_n = sum(gas_consumption,2);
oil_consumption = squeeze(egyreport2(1,:,strcmp('OIL', egyreport2_id{3}),1:30));
oil_consumption_n = sum(oil_consumption,2);
nhw_consumption = squeeze(egyreport2(1,:,strcmp('NHW', egyreport2_id{3}),1:30))/0.12*0.356;
nhw_consumption_n = sum(nhw_consumption,2);

figure(3); hold on;
tmp = [fosegycons_n, nhw_consumption_n, -ele_trade_n];
hb = bar(yr+dx, tmp, b, 'stacked', 'edge','none'); hold on;
set(hb(1), 'facec', [0.8 0.8 0.8], 'edge','none');
set(hb(2), 'facec', [0.675 1 0.675], 'edge','none');
set(hb(3), 'facec', 'none', 'edge','k');
bar(yr+dx, egycons_n, b, 'facec', 'none', 'edge', 'r', 'linewidth', 1);

tmp = [col_consumption_n, gas_consumption_n, oil_consumption_n];
hb = bar(yr+dx, tmp, 0.2, 'stacked', 'edge','none'); hold on;
set(hb(1), 'facec', [0.7 0 0]);
set(hb(2), 'facec', [1 1 0]);
set(hb(3), 'facec', [1 0.6 0.6]);

% export_fig egycons -painters;


%% Regional coal consumption
gdx_filename = 'result_egyint_n.gdx';
[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));

figure(4); clf;
hb = bar(1:30, col_consumption', 'hist');
color1 = [0.8 0.8 0.8];
color2 = [0.1 0.1 0.1];
interval_count = size(egyreport2_id{2},2);
cc = [linspace(color1(1),color2(1),interval_count); linspace(color1(2),color2(2),interval_count); linspace(color1(3),color2(3),interval_count)]';
for c = 1:interval_count, set(hb(c), 'facec', cc(c,:), 'edgecolor', 'k'); end
set(gcf, 'units', 'inch', 'pos', [0.3021    6.6667   18.7292    2.4479]);
set(gca, 'pos', [0.0569    0.1023    0.9263    0.7883]);
xlim([0.4 30.6]);
set(gca, 'fontsize', 7);
set(gca, 'xtick', 1:30);
set(gca, 'xticklabel', R);
set(gca, 'ticklength', [0.005 0.005]);
ylabel('Coal Consumption in 2007-2013 (mtce)');

% ==========
gdx_filename = 'result_egyint_n_coaltax.gdx';
[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));

figure(4); hold on;
hb = bar(1:30, col_consumption', 'hist');
for c = 1:size(egyreport2_id{2},2), set(hb(c), 'facec', 'none', 'edgecolor', 'r'); end


%% Regional coal consumption (only 2030)
gdx_filename = 'result_egyint_n.gdx';
[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_a = col_consumption(end,:);

gdx_filename = 'result_egyint_n_coaltax.gdx';
[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_b = col_consumption(end,:);

dc = (col_consumption_b - col_consumption_a)./col_consumption_a;

figure(5); clf;
hb = bar(r,[col_consumption_a;col_consumption_b]', 'hist');
set(hb(1), 'facec', [1 0.5 0.5], 'edgecolor', 'none');
set(hb(2), 'facec', [0 0.75 0], 'edgecolor', 'none');
set(gcf, 'units', 'inch', 'pos', [0.7292    3.2083    9.35    1.95]);
set(gca, 'pos', [0.0569    0.1023    0.9263    0.7883]);
xlim([0.4 30.6]);
set(gca, 'fontsize', 7);
set(gca, 'xtick', 1:30);
set(gca, 'xticklabel', R);
set(gca, 'ticklength', [0.005 0.005]);
ylabel('Coal Consumption in 2030 (mtce)');
for rn = 1:30, text(rn+0.15, col_consumption_b(rn)+2, [num2str(dc(rn)*100, '%1.2f'), '%'], 'fontsize', 6, 'rotation', 90); end
legend('w/ Nat\primel Egy. Int. Target', 'w/ Nat\primel Egy. Int. Target + 20% Coal Tax in 3 Key Regions');
% export_fig regional_coal_consumption -painters

% ==========
% Regional nhw consumption (only 2030)
gdx_filename = 'result_egyint_n.gdx';
[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
nhw_consumption = squeeze(egyreport2(1,:,strcmp('NHW', egyreport2_id{3}),1:30))/0.12*0.356;
nhw_consumption_a = nhw_consumption(end,:);

gdx_filename = 'result_egyint_n_coaltax.gdx';
[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
nhw_consumption = squeeze(egyreport2(1,:,strcmp('NHW', egyreport2_id{3}),1:30))/0.12*0.356;
nhw_consumption_b = nhw_consumption(end,:);

dc = (nhw_consumption_b - nhw_consumption_a)./nhw_consumption_a;

figure(6); clf;
hb = bar(r,[nhw_consumption_a;nhw_consumption_b]', 'hist');
set(hb(1), 'facec', [1 0.5 0.5], 'edgecolor', 'none');
set(hb(2), 'facec', [0 0.75 0], 'edgecolor', 'none');
set(gcf, 'units', 'inch', 'pos', [0.7292    3.2083    9.35    1.95]);
set(gca, 'pos', [0.0569    0.1023    0.9263    0.7883]);
xlim([0.4 30.6]);
set(gca, 'fontsize', 7);
set(gca, 'xtick', 1:30);
set(gca, 'xticklabel', R);
set(gca, 'ticklength', [0.005 0.005]);
ylabel('NHW Production in 2030 (mtce)');
for rn = 1:30, text(rn+0.15, nhw_consumption_b(rn)+2, [num2str(dc(rn)*100, '%1.2f'), '%'], 'fontsize', 6, 'rotation', 90); end
% export_fig regional_nhw_consumption -painters

% ==========
% Regional gas consumption (only 2030)
gdx_filename = 'result_egyint_n.gdx';
[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
gas_consumption = squeeze(egyreport2(1,:,strcmp('GAS', egyreport2_id{3}),1:30));
gas_consumption_a = gas_consumption(end,:);

gdx_filename = 'result_egyint_n_coaltax.gdx';
[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
gas_consumption = squeeze(egyreport2(1,:,strcmp('GAS', egyreport2_id{3}),1:30));
gas_consumption_b = gas_consumption(end,:);

dc = (gas_consumption_b - gas_consumption_a)./gas_consumption_a;

figure(7); clf;
hb = bar(r,[gas_consumption_a;gas_consumption_b]', 'hist');
set(hb(1), 'facec', [1 0.5 0.5], 'edgecolor', 'none');
set(hb(2), 'facec', [0 0.75 0], 'edgecolor', 'none');
set(gcf, 'units', 'inch', 'pos', [0.7292    3.2083    9.35    1.95]);
set(gca, 'pos', [0.0569    0.1023    0.9263    0.7883]);
xlim([0.4 30.6]);
set(gca, 'fontsize', 7);
set(gca, 'xtick', 1:30);
set(gca, 'xticklabel', R);
set(gca, 'ticklength', [0.005 0.005]);
ylabel('GAS Consumption in 2030 (mtce)');
for rn = 1:30, text(rn+0.15, gas_consumption_b(rn)+0.5, [num2str(dc(rn)*100, '%1.2f'), '%'], 'fontsize', 6, 'rotation', 90); end
% export_fig regional_gas_consumption -painters

% ==========
% Regional oil consumption (only 2030)
gdx_filename = 'result_egyint_n.gdx';
[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
oil_consumption = squeeze(egyreport2(1,:,strcmp('OIL', egyreport2_id{3}),1:30));
oil_consumption_a = oil_consumption(end,:);

gdx_filename = 'result_egyint_n_coaltax.gdx';
[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
oil_consumption = squeeze(egyreport2(1,:,strcmp('OIL', egyreport2_id{3}),1:30));
oil_consumption_b = oil_consumption(end,:);

dc = (oil_consumption_b - oil_consumption_a)./oil_consumption_a;

figure(8); clf;
hb = bar(r,[oil_consumption_a;oil_consumption_a]', 'hist');
set(hb(1), 'facec', [1 0.5 0.5], 'edgecolor', 'none');
set(hb(2), 'facec', [0 0.75 0], 'edgecolor', 'none');
set(gcf, 'units', 'inch', 'pos', [0.7292    3.2083    9.35    1.95]);
set(gca, 'pos', [0.0569    0.1023    0.9263    0.7883]);
xlim([0.4 30.6]);
ylim([0 250]);
set(gca, 'fontsize', 7);
set(gca, 'xtick', 1:30);
set(gca, 'xticklabel', R);
set(gca, 'ticklength', [0.005 0.005]);
ylabel('OIL Consumption in 2030 (mtce)');
for rn = 1:30, text(rn+0.15, oil_consumption_b(rn)+2, [num2str(dc(rn)*100, '%1.2f'), '%'], 'fontsize', 6, 'rotation', 90); end
% export_fig regional_oil_consumption -painters


%% Regional coal production (2007~2030)
[e_prod, e_prod_id] = getgdx('result_egyint_n.gdx', 'e_prod'); % 'HI' does not produce energy
col_prod = squeeze(e_prod(strcmp('COL', e_prod_id{1}),1:29,:));
col_prod = [col_prod; zeros(1,6)]; % patch missing data for 'HI'

figure(9); clf;
hb = bar(1:30, col_prod, 'hist');
color1 = [0.8 0.8 0.8];
color2 = [0.1 0.1 0.1];
interval_count = 6;
cc = [linspace(color1(1),color2(1),interval_count); linspace(color1(2),color2(2),interval_count); linspace(color1(3),color2(3),interval_count)]';
for c = 1:interval_count, set(hb(c), 'facec', cc(c,:), 'edgecolor', 'k'); end
set(gcf, 'units', 'inch', 'pos', [0.3021    6.6667   18.7292    2.4479]);
set(gca, 'pos', [0.0569    0.1023    0.9263    0.7883]);
xlim([0.4 30.6]);
set(gca, 'fontsize', 7);
set(gca, 'xtick', 1:30);
set(gca, 'xticklabel', R);
set(gca, 'ticklength', [0.005 0.005]);
ylabel('Coal Production (mtce)');

[e_prod, e_prod_id] = getgdx('result_egyint_n_coaltax.gdx', 'e_prod');
col_prod = squeeze(e_prod(strcmp('COL', e_prod_id{1}),1:29,:));
col_prod = [col_prod; zeros(1,6)];
figure(9); hold on;
hb = bar(1:30, col_prod, 'hist');
set(hb, 'edgecolor', 'r', 'facec', 'none');

% ==============================
% Regional coal production (only 2030)
[e_prod, e_prod_id] = getgdx('result_egyint_n.gdx', 'e_prod'); % 'HI' does not produce energy
col_prod = squeeze(e_prod(strcmp('COL', e_prod_id{1}),1:29,:));
col_prod_a = [col_prod(:,end); zeros(1,1)]; % patch missing data for 'HI'

[e_prod, e_prod_id] = getgdx('result_egyint_n_coaltax.gdx', 'e_prod');
col_prod = squeeze(e_prod(strcmp('COL', e_prod_id{1}),1:29,:));
col_prod_b = [col_prod(:,end); zeros(1,1)];

d = (col_prod_b - col_prod_a)./col_prod_a;

figure(10); clf;
hb = bar(1:30, [col_prod_a, col_prod_b], 'hist');
set(hb(1), 'facec', [1 0.5 0.5], 'edgecolor', 'none');
set(hb(2), 'facec', [0 0.75 0], 'edgecolor', 'none');
xlim([0.4 30.6]);
set(gca, 'fontsize', 7);
ylabel('Coal Production (mtce)');
set(gca, 'xtick', 1:30);
set(gca, 'xticklabel', R);
set(gca, 'ticklength', [0.005 0.005]);
set(gcf, 'units', 'inch', 'pos', [0.7292    3.2083    9.35    1.95]);
set(gca, 'pos', [0.0569    0.1023    0.9263    0.7883]);
for rn = 1:30
    if (rn == 10 || rn == 30), text(rn+0.15, col_prod_b(rn)+5, 'N/A', 'fontsize', 6, 'rotation', 90);
    else text(rn+0.15, col_prod_b(rn)+5, [num2str(d(rn)*100, '%1.2f'), '%'], 'fontsize', 6, 'rotation', 90);
    end
end
% export_fig regional_col_production -painers;


%% Coal trades (i.e. imports & exports)
gdx_filename = 'result_default.gdx';
[evt_report, evt_report_id] = getgdx(gdx_filename, 'evt_report'); % [i]x[rs]x[sr]x[t]
col_export = -squeeze(evt_report(1,:,:,1)); % 2007
col_import = squeeze(evt_report(1,:,:,1))';

color_code = rainbow_color(34);
figure(11); clf; hold on;
hb = bar(col_export, 'stacked');
for rn = 1:length(rs), set(hb(rn), 'facec', color_code(rn,:), 'edge', 'none'); end
hb2 = bar(col_import, 'stacked');
for rn = 1:length(rs), set(hb2(rn), 'facec', color_code(rn,:), 'edge', 'none'); end
xlim([0.4 34.6]);
set(gca, 'fontsize', 7);
set(gca, 'tickdir', 'out');
box off;
set(gca, 'xtick', 1:34);
set(gca, 'xticklabel', rs);
set(gca, 'ticklength', [0.005 0.005]);
ylabel('Volume of Energy Trade (mtce)');
title('COL Imports & Exports (No Policy, 2007)', 'fontsize', 10, 'fontweight', 'bold');
set(gcf, 'units', 'inch', 'pos', [0.2917    7.0625    9.35    3.15]);
set(gca, 'pos', [0.0602    0.1023    0.8574    0.8144]);
legend(fliplr(hb), fliplr(rs));
set(legend, 'fontsize', 6, 'units', 'pixels', 'pos', [827.0000    4.3333   70.0000  294.6667]);
text(1, 50, 'Imports', 'color', [0.6 0.6 0.6], 'fontsize', 8, 'rotation', 90);
text(1, -50, 'Exports', 'color', [0.6 0.6 0.6], 'fontsize', 8, 'rotation', 90, 'horizontalalignment', 'right');
my_gridline;
% export_fig evt_NoPolicy_2007 -painters;

% ==========
col_export = -squeeze(evt_report(1,:,:,end)); % 2030
col_import = squeeze(evt_report(1,:,:,end))';

figure(12); clf; hold on;
hb = bar(col_export, 'stacked');
for rn = 1:length(rs), set(hb(rn), 'facec', color_code(rn,:), 'edge', 'none'); end
hb2 = bar(col_import, 'stacked');
for rn = 1:length(rs), set(hb2(rn), 'facec', color_code(rn,:), 'edge', 'none'); end
xlim([0.4 34.6]);
set(gca, 'fontsize', 7);
set(gca, 'tickdir', 'out');
box off;
set(gca, 'xtick', 1:34);
set(gca, 'xticklabel', rs);
set(gca, 'ticklength', [0.005 0.005]);
ylabel('Volume of Energy Trade (mtce)');
title('COL Imports & Exports (No Policy, 2030)', 'fontsize', 10, 'fontweight', 'bold');
set(gcf, 'units', 'inch', 'pos', [9.8125    7.0625    9.35    3.15]);
set(gca, 'pos', [0.0602    0.1023    0.8574    0.8144]);
legend(fliplr(hb), fliplr(rs));
set(legend, 'fontsize', 6, 'units', 'pixels', 'pos', [827.0000    4.3333   70.0000  294.6667]);
text(1, 50, 'Imports', 'color', [0.6 0.6 0.6], 'fontsize', 8, 'rotation', 90);
text(1, -50, 'Exports', 'color', [0.6 0.6 0.6], 'fontsize', 8, 'rotation', 90, 'horizontalalignment', 'right');
my_gridline;
% export_fig evt_NoPolicy_2030 -painters;

% ==========
gdx_filename = 'result_egyint_n.gdx';
[evt_report, ~] = getgdx(gdx_filename, 'evt_report');
col_export = -squeeze(evt_report(1,:,:,end)); % 2030
col_import = squeeze(evt_report(1,:,:,end))';

color_code = rainbow_color(34);
figure(13); clf; hold on;
hb = bar(col_export, 'stacked');
for rn = 1:length(rs), set(hb(rn), 'facec', color_code(rn,:), 'edge', 'none'); end
hb2 = bar(col_import, 'stacked');
for rn = 1:length(rs), set(hb2(rn), 'facec', color_code(rn,:), 'edge', 'none'); end
xlim([0.4 34.6]);
set(gca, 'fontsize', 7);
set(gca, 'tickdir', 'out');
box off;
set(gca, 'xtick', 1:34);
set(gca, 'xticklabel', rs);
set(gca, 'ticklength', [0.005 0.005]);
ylabel('Volume of Energy Trade (mtce)');
title('COL Imports & Exports (w/ National Energy Intensity Target, 2030)', 'fontsize', 10, 'fontweight', 'bold');
set(gcf, 'units', 'inch', 'pos', [0.2917     2.5729    9.35    3.15]);
set(gca, 'pos', [0.0602    0.1023    0.8574    0.8144]);
legend(fliplr(hb), fliplr(rs));
set(legend, 'fontsize', 6, 'units', 'pixels', 'pos', [827.0000    4.3333   70.0000  294.6667]);
text(1, 50, 'Imports', 'color', [0.6 0.6 0.6], 'fontsize', 8, 'rotation', 90);
text(1, -50, 'Exports', 'color', [0.6 0.6 0.6], 'fontsize', 8, 'rotation', 90, 'horizontalalignment', 'right');
my_gridline;
% export_fig evt_NationalEint -painters;

% ==========
gdx_filename = 'result_egyint_n_coaltax.gdx';
[evt_report, ~] = getgdx(gdx_filename, 'evt_report');
col_export = -squeeze(evt_report(1,:,:,end)); % 2030
col_import = squeeze(evt_report(1,:,:,end))';

color_code = rainbow_color(34);
figure(14); clf; hold on;
hb = bar(col_export, 'stacked');
for rn = 1:length(rs), set(hb(rn), 'facec', color_code(rn,:), 'edge', 'none'); end
hb2 = bar(col_import, 'stacked');
for rn = 1:length(rs), set(hb2(rn), 'facec', color_code(rn,:), 'edge', 'none'); end
xlim([0.4 34.6]);
set(gca, 'fontsize', 7);
set(gca, 'tickdir', 'out');
box off;
set(gca, 'xtick', 1:34);
set(gca, 'xticklabel', rs);
set(gca, 'ticklength', [0.005 0.005]);
ylabel('Volume of Energy Trade (mtce)');
title('COL Imports & Exports (w/ National Energy Intensity Target + Coal Tax in the 3 Key Regions, 2030)', 'fontsize', 10, 'fontweight', 'bold');
set(gcf, 'units', 'inch', 'pos', [9.8125    2.5729    9.35    3.15]);
set(gca, 'pos', [0.0602    0.1023    0.8574    0.8144]);
legend(fliplr(hb), fliplr(rs));
set(legend, 'fontsize', 6, 'units', 'pixels', 'pos', [827.0000    4.3333   70.0000  294.6667]);
text(1, 50, 'Imports', 'color', [0.6 0.6 0.6], 'fontsize', 8, 'rotation', 90);
text(1, -50, 'Exports', 'color', [0.6 0.6 0.6], 'fontsize', 8, 'rotation', 90, 'horizontalalignment', 'right');
my_gridline;
% export_fig evt_NationalEint_CoalTax -painters;


%% Electricity trades
gdx_filename = 'result_egyint_n.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
ele_trade_a = squeeze(report(strcmp('exportELE', report_id{1}),:,1:30));

gdx_filename = 'result_egyint_n_coaltax.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
ele_trade_b = squeeze(report(strcmp('exportELE', report_id{1}),:,1:30));

figure(15); clf;
hb = bar(1:30, [ele_trade_a(end,:); ele_trade_b(end,:)]', 'hist');
set(hb(1), 'facec', [1 0.5 0.5], 'edgecolor', 'none');
set(hb(2), 'facec', [0 0.75 0], 'edgecolor', 'none');
hold on;
line([0 31], [0 0], 'color', 'k');
xlim([0.4 30.6]);
set(gca, 'fontsize', 7);
set(gca, 'xtick', 1:30);
set(gca, 'xticklabel', R);
set(gca, 'ticklength', [0.005 0.005]);
set(gcf, 'units', 'inch', 'pos', [0.7292    3.3021    9.35    2.45]);
set(gca, 'pos', [0.0569    0.1023    0.9263    0.7883]);
ylabel('Electricity Trades (mtce)');
text(0.8, 15, 'Exports', 'color', [0.6 0.6 0.6], 'fontsize', 8);
text(0.8, -30, 'Imports', 'color', [0.6 0.6 0.6], 'fontsize', 8);
my_gridline;
legend('w/ Nat\primel Egy. Int. Target', 'w/ Nat\primel Egy. Int. Target + 20% Coal Tax in 3 Key Regions', 2);

% export_fig ele_trade -painters;


%% regional coal consumption (four scenarios, only 2030)
[egyreport2, egyreport2_id] = getgdx('result_default.gdx', 'egyreport2');
col_consumption_a = squeeze(egyreport2(1,end,strcmp('COL', egyreport2_id{3}),1:30)); % only 2030

[egyreport2, egyreport2_id] = getgdx('result_coaltax.gdx', 'egyreport2');
col_consumption_b = squeeze(egyreport2(1,end,strcmp('COL', egyreport2_id{3}),1:30));

[egyreport2, egyreport2_id] = getgdx('result_egyint_n.gdx', 'egyreport2');
col_consumption_c = squeeze(egyreport2(1,end,strcmp('COL', egyreport2_id{3}),1:30));

[egyreport2, egyreport2_id] = getgdx('result_egyint_n_coaltax.gdx', 'egyreport2');
col_consumption_d = squeeze(egyreport2(1,end,strcmp('COL', egyreport2_id{3}),1:30));

d = (col_consumption_b - col_consumption_a)./col_consumption_a;
dd = (col_consumption_d - col_consumption_c)./col_consumption_c;

figure(16); clf;
hb = bar(1:30, [col_consumption_a, col_consumption_b, col_consumption_c, col_consumption_d], 'hist');
set(hb(1), 'facec', [0.6 0.6 0.6]);
set(hb(2), 'facec', [0.3 0.65 1]);
set(hb(3), 'facec', [1 0.7 0.7]);
set(hb(4), 'facec', [0 0.6 0]);
set(gcf, 'units', 'inch', 'pos', [0.6250    6.0313    9.3542    3.15]);
set(gca, 'pos', [0.0569    0.0726    0.9263    0.8647]);
xlim([0.4 30.6]);
set(gca, 'fontsize', 7);
set(gca, 'xtick', 1:30);
set(gca, 'xticklabel', R);
set(gca, 'ticklength', [0.005 0.005]);
ylabel('Coal Consumption in 2030 (mtce)');
text(1-0.08, col_consumption_b(1)+2, [num2str(d(1)*100, '%1.2f'), '% (relative to grey)'], 'fontsize', 6, 'rotation', 90);
for rn = 2:30, text(rn-0.08, col_consumption_b(rn)+2, [num2str(d(rn)*100, '%1.2f'), '%'], 'fontsize', 6, 'rotation', 90); end
text(1+0.27, col_consumption_d(1)+2, [num2str(dd(1)*100, '%1.2f'), '% (relative to red)'], 'fontsize', 6, 'rotation', 90);
for rn = 2:30, text(rn+0.27, col_consumption_d(rn)+2, [num2str(dd(rn)*100, '%1.2f'), '%'], 'fontsize', 6, 'rotation', 90); end
legend('No Policy', 'Only Coal Tax in 3 Key Regions', 'Only Natioal Energy Intensity Target', 'National Egy. Int. Target + Coal Tax in 3 Key Regions')
my_gridline('y');
% export_fig regional_coal_consumption_all -painters;


% ==============================
% regional coal production (only 2030)
[e_prod, e_prod_id] = getgdx('result_default.gdx', 'e_prod'); % 'HI' does not produce energy
col_prod = squeeze(e_prod(strcmp('COL', e_prod_id{1}),1:29,:));
col_prod_a = [col_prod(:,end); zeros(1,1)]; % patch missing data for 'HI'

[e_prod, e_prod_id] = getgdx('result_coaltax.gdx', 'e_prod'); % 'HI' does not produce energy
col_prod = squeeze(e_prod(strcmp('COL', e_prod_id{1}),1:29,:));
col_prod_b = [col_prod(:,end); zeros(1,1)]; % patch missing data for 'HI'

[e_prod, e_prod_id] = getgdx('result_egyint_n.gdx', 'e_prod'); % 'HI' does not produce energy
col_prod = squeeze(e_prod(strcmp('COL', e_prod_id{1}),1:29,:));
col_prod_c = [col_prod(:,end); zeros(1,1)]; % patch missing data for 'HI'

[e_prod, e_prod_id] = getgdx('result_egyint_n_coaltax.gdx', 'e_prod'); % 'HI' does not produce energy
col_prod = squeeze(e_prod(strcmp('COL', e_prod_id{1}),1:29,:));
col_prod_d = [col_prod(:,end); zeros(1,1)]; % patch missing data for 'HI'

figure(17); clf;
hb = bar(1:30, [col_prod_a, col_prod_b, col_prod_c, col_prod_d], 'hist');
set(hb(1), 'facec', [0.6 0.6 0.6]);
set(hb(2), 'facec', [0.3 0.65 1]);
set(hb(3), 'facec', [1 0.7 0.7]);
set(hb(4), 'facec', [0 0.6 0]);
set(gcf, 'units', 'inch', 'pos', [0.6250    1.9063    9.3542    3.15]);
set(gca, 'pos', [0.0569    0.1023    0.9263    0.7883]);
xlim([0.4 30.6]);
set(gca, 'fontsize', 7);
set(gca, 'xtick', 1:30);
set(gca, 'xticklabel', R);
set(gca, 'ytick', 0:300:1500);
set(gca, 'ticklength', [0.005 0.005]);
ylabel('Coal Production in 2030 (mtce)');
legend('No Policy', 'Only Coal Tax in 3 Key Regions', 'Only Natioal Energy Intensity Target', 'National Egy. Int. Target + Coal Tax in 3 Key Regions')
my_gridline('y');
% export_fig regional_coal_production_all -painters;


%% Reginal energy intensity (2007-2030)
egy_intensity_r = getgdx('result_default.gdx', 'egy_intensity_r');
figure(18); clf;
hb = bar(r,egy_intensity_r, 'hist');

color1 = [1 1 1];
color2 = [0.2 0.2 0.2];
interval = 6;
cc = [linspace(color1(1),color2(1),interval); linspace(color1(2),color2(2),interval); linspace(color1(3),color2(3),interval)]';
for c = 1:interval, set(hb(c), 'facec', cc(c,:), 'edgecolor', 'k'); end
set(gcf, 'units', 'inch', 'pos', [0.7292    3.3021    9.35    1.95]);
set(gca, 'pos', [0.0569    0.1023    0.9263    0.7883]);
set(gca, 'fontsize', 8);
set(gca, 'ticklength', [0.005 0.005]);
ylabel('Energy Intensity in 2007-2030');
xlim([0.4 30.6]);
set(gca, 'xtick', r, 'xticklabel', R);
text(1-0.3, egy_intensity_r(1,1)+0.05, 'Yr 2007', 'fontsize', 6, 'rotation', 90);
text(1+0.3, egy_intensity_r(1,6)+0.05, 'Yr 2030', 'fontsize', 6, 'rotation', 90);
% my_gridline('y'); export_fig regional_energy_intensity_default -painters;



