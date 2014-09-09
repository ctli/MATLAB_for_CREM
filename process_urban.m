clear all
close all
clc
format compact

yr = [2007, 2010:5:2030];

r = {'BJ','TJ','HE','SX','SD','NM','LN','JL','HL','SH','JS','ZJ','AH','FJ','HA','HB','HN','JX','SC','CQ','SN','GS','QH','NX','XJ','GD','GX','YN','GZ','HI'};


%% ================================================================== %%
% % baseline
% gdx_filename = 'result_default.gdx';
% [urban, urban_id] = getgdx(gdx_filename, 'urban');
% urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
% for i = 1:length(urban_id{1})
%     urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
%     urban_CHN(i,:) = sum(urban_extract);
% end
% 
% for i = 1:length(urban_id{1})
% figure(i); clf;
% plot(yr, urban_CHN(i,:), 'kx-');
% set(gca, 'fontsize', 8);
% ylabel('Urban pollution emissions (Tg)');
% title(urban_id{1}(i), 'fontsize', 10, 'fontweight', 'bold');
% set(gcf, 'unit', 'inch', 'pos', [21.2604+0.5*i    5.5729-0.5*i    4.0000    3.0000]);
% end

% ==============================
% No policy
gdx_filename = 'result_urban_exo.gdx';
[urban, urban_id] = getgdx(gdx_filename, 'urban');
urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
for i = 1:length(urban_id{1})
    urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
    urban_CHN(i,:) = sum(urban_extract);
end

for i = 1:length(urban_id{1})
figure(i); clf; box on;
plot(yr, urban_CHN(i,:), 'r^-', 'markersize', 5);
set(gca, 'fontsize', 8);
ylabel('Urban pollution emissions (Tg)');
title(urban_id{1}(i), 'fontsize', 10, 'fontweight', 'bold');
set(gcf, 'unit', 'inch', 'pos', [21.2604+0.5*i    5.5729-0.5*i    4.0000    3.0000]);
end

[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
figure(10); clf; box on;
plot(yr, GDP_n, 'r^-', 'markersize', 5);
set(gca, 'fontsize', 8);
ylabel('GDP, Billion US Dollor (2007 Value)');
set(gcf, 'unit', 'inch', 'pos', [29.9583    5.5729-0.5*i    4.0000    3.0000]);

% ==============================
% policy scenario: national energy intensity
gdx_filename = 'result_egyint_n.gdx';
[urban, urban_id] = getgdx(gdx_filename, 'urban');
urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
for i = 1:length(urban_id{1})
urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
urban_CHN(i,:) = sum(urban_extract);
end

for i = 1:length(urban_id{1})
figure(i); hold on;
plot(yr, urban_CHN(i,:), 'go-', 'markersize', 5);
if i == 1, legend('No Policy', 'w/ Policy', 2); end

export_filename = ['fig_', char(urban_id{1}(i))];
my_gridline; %export_fig(export_filename);
end

[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
figure(10); hold on;
plot(yr, GDP_n, 'go-', 'markersize', 5);


% %% SO2: combustion emission vs process emission
% [urban, urban_id] = getgdx('result_egyint_n.gdx', 'urban'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[11]x[6]
% SO2 = squeeze(urban(strcmp('SO2', urban_id{1}),:,:,:)); % [30]x[11]x[6]
% SO2_r = squeeze(sum(SO2,2)); % [30]x[6]
% SO2_n = sum(SO2_r); % [1x6]
% 
% [urban_c, urban_c_id] = getgdx('result_egyint_n.gdx', 'urban_c'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[8]x[6]
% SO2_c = squeeze(urban_c(strcmp('SO2', urban_c_id{1}),:,:,:)); % [30]x[8]x[6]
% SO2_c_g = squeeze(sum(SO2_c,2)); % [30]x[6]
% SO2_c_n = sum(SO2_c_g); % [1]x[6]
% 
% [urban_o, urban_o_id] = getgdx('result_egyint_n.gdx', 'urban_o'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[10]x[6]
% SO2_o = squeeze(urban_o(strcmp('SO2', urban_o_id{1}),:,:,:)); % [30]x[8]x[6]
% SO2_o_g = squeeze(sum(SO2_o,2)); % [30]x[6]
% SO2_o_n = sum(SO2_o_g); % [1]x[6]
% 
% figure(10); clf;
% hb = bar(yr, [SO2_c_n; SO2_o_n]', 'stacked');
% set(hb(1), 'facec', [1 0.4 0.4], 'edgecolor', 'none');
% set(hb(2), 'facec', [0.3 0.65 1], 'edgecolor', 'none');
% set(gca, 'fontsize', 8);
% ylabel('SO2 (Tg)');
% legend(fliplr(hb), 'Process', 'Combustion', 2);
% title('SO2 Emission (All Sectors) (more from combustion, less from processes)', 'Fontsize', 10);
% set(gcf, 'units', 'inch', 'pos', [7.0521    5.8646    5.8333    4.3750]);
% 
% 
% %% NH3: combustion emission vs process emission
% [urban, urban_id] = getgdx('result_egyint_n.gdx', 'urban'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[11]x[6]
% NH3 = squeeze(urban(strcmp('NH3', urban_id{1}),:,:,:)); % [30]x[11]x[6]
% NH3_r = squeeze(sum(NH3,2)); % [30]x[6]
% NH3_n = sum(NH3_r); % [1x6]
% 
% NH3 = squeeze(urban(strcmp('NH3', urban_id{1}),:,:,:)); % [30]x[11]x[6]
% NH3_g = squeeze(sum(NH3)); % [11]x[6]
% NH3_agr = squeeze(urban(strcmp('NH3', urban_id{1}),:,strcmp('AGR', urban_id{3}),:)); % [30]x[6]
% 
% figure(11); clf;
% plot(yr, NH3_g, 'x-');
% set(gca, 'fontsize', 8);
% ylabel('Tg')
% title('NH3 Emissions (All Sectors)', 'fontsize', 10);
% legend(urban_id{3}, 'location', 'east');
% text(2005.75, 42.5, 'Top Three Sector: AGR (~80%), WAT(10-12%), c (5-6%)');
% set(gcf, 'unit', 'inch', 'pos', [1.0521    0.5104    5.8333    4.3750]);
% 
% ratio_AGR = NH3_g(1,:)./NH3_n;
% for iy = 1:length(yr), text(yr(iy), NH3_g(1,iy)+1.1, num2str(ratio_AGR(iy), '%2.2f'), 'fontsize', 8, 'horizontalalignment', 'center'); end
% 
% ratio_WTR = NH3_g(strcmp('WTR',urban_id{3}),:)./NH3_n;
% for iy = 1:length(yr), text(yr(iy), NH3_g(strcmp('WTR',urban_id{3}),iy)+1.1, num2str(ratio_WTR(iy), '%2.2f'), 'fontsize', 8, 'horizontalalignment', 'center'); end
% 
% ratio_c = NH3_g(strcmp('c',urban_id{3}),:)./NH3_n;
% for iy = 1:length(yr), text(yr(iy), NH3_g(strcmp('c',urban_id{3}),iy)+1, num2str(ratio_c(iy), '%2.2f'), 'fontsize', 8, 'horizontalalignment', 'center'); end
% 
% % ==========
% [urban_c, urban_c_id] = getgdx('result_egyint_n.gdx', 'urban_c'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[8]x[6]
% NH3_c = squeeze(urban_c(strcmp('NH3', urban_c_id{1}),:,:,:)); % [30]x[8]x[6]
% NH3_c_g = squeeze(sum(NH3_c,2)); % [30]x[6]
% NH3_c_n = sum(NH3_c_g); % [1]x[6]
% 
% [urban_o, urban_o_id] = getgdx('result_egyint_n.gdx', 'urban_o'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[10]x[6]
% NH3_o = squeeze(urban_o(strcmp('NH3', urban_o_id{1}),:,:,:)); % [30]x[8]x[6]
% NH3_o_g = squeeze(sum(NH3_o,2)); % [30]x[6]
% NH3_o_n = sum(NH3_o_g); % [1]x[6]
% 
% figure(12); clf;
% hb = bar([2007, 2010:5:2030], [NH3_o_n; NH3_c_n]', 'stacked');
% set(hb(1), 'facec', [1 0.4 0.4], 'edgecolor', 'none');
% set(hb(2), 'facec', [0.3 0.65 1], 'edgecolor', 'none');
% set(gca, 'fontsize', 8);
% ylabel('Tg');
% title('NH3 Emission (mostly process emissions; almost no combustion emissions)', 'fontsize', 10);
% set(gcf, 'unit', 'inch', 'pos', [7.0521    0.5104    5.8333    4.3750]);
% 
% % ==========
% [urban_c, urban_c_id] = getgdx('result_egyint_n.gdx', 'urban_c'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[8]x[6]
% NH3_c_agr = squeeze(urban_c(strcmp('NH3', urban_c_id{1}),:,strcmp('AGR', urban_c_id{3}),:)); % [30]x[6]
% NH3_c_agr_n = sum(NH3_c_agr); % [1]x[6]
% 
% [urban_o, urban_o_id] = getgdx('result_egyint_n.gdx', 'urban_o'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[10]x[6]
% NH3_o_agr = squeeze(urban_o(strcmp('NH3', urban_o_id{1}),:,strcmp('AGR', urban_o_id{3}),:)); % [30]x[6]
% NH3_o_agr_n = sum(NH3_o_agr); % [1]x[6]
% 
% figure(12); hold on;
% hb2 = bar([2007, 2010:5:2030], [NH3_o_agr_n; NH3_c_agr_n]', 0.5, 'stacked');
% set(hb2(1), 'facec', [1 0.4 0.4], 'edgecolor', 'k');
% set(hb2(2), 'facec', [0.3 0.65 1], 'edgecolor', 'k');
% set(gca, 'fontsize', 8);
% ylabel('Tg');
% legend([fliplr(hb),fliplr(hb2)], 'Process', 'Combustion', 'Process from AGR', 'Combustion from AGR', 2);
% 
