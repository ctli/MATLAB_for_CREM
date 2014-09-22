clear all
close all
clc

r = {'BJ','TJ','HE','SX','SD','NM','LN','JL','HL','SH','JS','ZJ','AH','FJ','HA','HB','HN','JX','SC','CQ','SN','GS','QH','NX','XJ','GD','GX','YN','GZ','HI'};


%% Emissions in CREM
yr = [2007, 2010:5:2030];

gdx_filename = 'result_default.gdx';
[urban, urban_id] = getgdx(gdx_filename, 'urban'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[11]x[6]
SO2 = squeeze(urban(strcmp('SO2', urban_id{1}),:,:,:)); % [30]x[11]x[6]
SO2_r = squeeze(sum(SO2,2)); % [30]x[6]
SO2_n = sum(SO2_r); % [1x6]
NOX = squeeze(urban(strcmp('NOX', urban_id{1}),:,:,:)); % [30]x[11]x[6]
NOX_r = squeeze(sum(NOX,2)); % [30]x[6]
NOX_n = sum(NOX_r); % [1x6]
NH3 = squeeze(urban(strcmp('NH3', urban_id{1}),:,:,:)); % [30]x[11]x[6]
NH3_r = squeeze(sum(NH3,2)); % [30]x[6]
NH3_n = sum(NH3_r); % [1x6]

[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
[report, report_id] = getgdx(gdx_filename, 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
egycons_n = sum(egycons,2);
col_share_n = col_consumption_n./egycons_n; % national coal share

figure(1); clf;
plot(yr, SO2_n, 'x-k');
set(gca, 'fontsize', 8);
ylim([0 160]);
xlim([2003 2031]);
set(gca, 'xtick', [2005 2010:5:2030]);
set(gca, 'tickdir', 'out');
title('SO2', 'fontsize', 10);
ylabel('Tg');
set(gcf, 'unit', 'inch', 'pos', [0.3646    5.9167    4.0000    3.0000]);

figure(2); clf;
plot(yr, NOX_n, 'x-k');
set(gca, 'fontsize', 8);
ylim([0 160]);
xlim([2003 2031]);
set(gca, 'xtick', [2005 2010:5:2030]);
set(gca, 'tickdir', 'out');
title('NOX', 'fontsize', 10);
ylabel('Tg');
set(gcf, 'unit', 'inch', 'pos', [4.5833    5.9167    4.0000    3.0000]);

figure(3); clf;
plot(yr, NH3_n, 'x-k');
set(gca, 'fontsize', 8);
ylim([0 160]);
xlim([2003 2031]);
set(gca, 'xtick', [2005 2010:5:2030]);
set(gca, 'tickdir', 'out');
title('NH3', 'fontsize', 10);
ylabel('Tg');
set(gcf, 'unit', 'inch', 'pos', [8.7500    5.9167    4.0000    3.0000]);


%% ==============================
NH3 = squeeze(urban(strcmp('NH3', urban_id{1}),:,:,:)); % [30]x[11]x[6]
NH3_g = squeeze(sum(NH3)); % [11]x[6]
NH3_agr = squeeze(urban(strcmp('NH3', urban_id{1}),:,strcmp('AGR', urban_id{3}),:)); % [30]x[6]

figure(31); clf;
plot(yr, NH3_g, 'x-');
set(gca, 'fontsize', 8);
ylabel('Tg')
title('NH3 Emissions', 'fontsize', 10);
legend(urban_id{3}, 2);

% AGR has the largest share (~80%)
ratio_AGR = NH3_g(1,:)./NH3_n;
for iy = 1:length(yr), text(yr(iy), NH3_g(1,iy)-1.1, num2str(ratio_AGR(iy), '%2.2f'), 'fontsize', 8, 'horizontalalignment', 'center'); end

% WTR has the second largest share (10~12%)
ratio_WTR = NH3_g(strcmp('WTR',urban_id{3}),:)./NH3_n;
for iy = 1:length(yr), text(yr(iy), NH3_g(strcmp('WTR',urban_id{3}),iy)+1.1, num2str(ratio_WTR(iy), '%2.2f'), 'fontsize', 8, 'horizontalalignment', 'center'); end

% WTR has the third largest share (5~6%)
ratio_c = NH3_g(strcmp('c',urban_id{3}),:)./NH3_n;
for iy = 1:length(yr), text(yr(iy), NH3_g(strcmp('c',urban_id{3}),iy)+1, num2str(ratio_c(iy), '%2.2f'), 'fontsize', 8, 'horizontalalignment', 'center'); end

% ==========
[urban_c, urban_c_id] = getgdx('result_default.gdx', 'urban_c'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[8]x[6]
[urban_o, urban_o_id] = getgdx('result_default.gdx', 'urban_o'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[10]x[6]

NH3_c_agr = squeeze(urban_c(strcmp('NH3', urban_c_id{1}),:,strcmp('AGR', urban_c_id{3}),:)); % [30]x[6]
NH3_c_agr_n = sum(NH3_c_agr); % [1]x[6]

NH3_o_agr = squeeze(urban_o(strcmp('NH3', urban_o_id{1}),:,strcmp('AGR', urban_o_id{3}),:)); % [30]x[6]
NH3_o_agr_n = sum(NH3_o_agr); % [1]x[6]

figure(32); clf;
hb = bar([2007, 2010:5:2030], [NH3_o_agr_n; NH3_c_agr_n]', 'stacked');
set(hb(1), 'facec', [1 0 0], 'edgecolor', 'none');
set(hb(2), 'facec', [0.3 0.65 1], 'edgecolor', 'none');
set(gca, 'fontsize', 8);
title('NH3 Emission Shares (mostly process emissions; almost no combustion emissions)');
ylabel('Tg');
legend('Process Emissions', 'Combustion Emissions', 2);

%% ==========
[Y, Y_id]= getgdx('merge_default.gdx', 'Y'); 
Y_agr = squeeze(Y(:,strcmp('AGR', Y_id{2}),1:30));
Y_agr_n = sum(Y_agr,2)./30;

figure(33); clf;
plot([2007, 2010:5:2030], Y_agr_n, 'x-');
grid on;
set(gca, 'fontsize', 8);
ylabel('AGR Sectoral Output (normalized)');


%%
[urban_c, urban_c_id] = getgdx('result_egyint_n.gdx', 'urban_c'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[8]x[6]
[urban_o, urban_o_id] = getgdx('result_egyint_n.gdx', 'urban_o'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[10]x[6]

SO2_c = squeeze(urban_c(strcmp('SO2', urban_c_id{1}),:,:,:)); % [30]x[8]x[6]
SO2_c_g = squeeze(sum(SO2_c,2)); % [30]x[6]
SO2_c_n = sum(SO2_c_g); % [1]x[6]

SO2_o = squeeze(urban_o(strcmp('SO2', urban_o_id{1}),:,:,:)); % [30]x[8]x[6]
SO2_o_g = squeeze(sum(SO2_o,2)); % [30]x[6]
SO2_o_n = sum(SO2_o_g); % [1]x[6]

figure(4); clf;
bar(yr, [SO2_c_n; SO2_o_n]', 'stacked');
set(gca, 'fontsize', 8);
ylabel('SO2 (Tg)');
legend('Combustion', 'Process', 2);



