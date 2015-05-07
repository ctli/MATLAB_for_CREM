clear all
close all
clc
format compact

yr = [2007, 2010:5:2030];

r = {'BJ','TJ','HE','SX','SD','NM','LN','JL','HL','SH','JS','ZJ','AH','FJ','HA','HB','HN','JX','SC','CQ','SN','GS','QH','NX','XJ','GD','GX','YN','GZ','HI'};


% % ================================================================== %%
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
% plot(yr, urban_CHN(i,:), 'bs-');
% set(gca, 'fontsize', 8);
% ylabel('Urban pollution emissions (Tg)');
% title(urban_id{1}(i), 'fontsize', 10, 'fontweight', 'bold');
% set(gcf, 'unit', 'inch', 'pos', [0.3+0.3*i    4.3-0.3*i    4.0000    3.0000]);
% end
% 
% [report, report_id] = getgdx(gdx_filename, 'report');
% GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
% GDP_n = sum(GDP,2);
% figure(10); clf; box on;
% plot(yr, GDP_n, 'bs-', 'markersize', 5);
% set(gca, 'fontsize', 8);
% ylabel('GDP, Billion US Dollor (2007 Value)');
% set(gcf, 'unit', 'inch', 'pos', [29.9583    5.5729-0.5*i    4.0000    3.0000]);
% 
% egy_intensity_n = getgdx(gdx_filename, 'egy_intensity_n');
% figure(11); clf; box on;
% plot(yr, egy_intensity_n, 'bs-', 'markersize', 5);
% ylim([0.3 0.8]);
% ylabel('National Energy Intensity');
% set(gcf, 'unit', 'inch', 'pos', [29.9583    5.0625    4.0000    3.0000]);
% 
% [egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
% col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
% col_consumption_n = sum(col_consumption,2);
% figure(12); clf; box on;
% plot(yr, col_consumption_n, 'bs-', 'markersize', 5);
% ylabel('Coal Consumption (mtce)');
% set(gcf, 'unit', 'inch', 'pos', [33.1771    2.8021    4.0000    3.0000]);
% 
% 
% %% baseline
% gdx_filename = 'result_default_new.gdx';
% [urban, urban_id] = getgdx(gdx_filename, 'urban');
% urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
% for i = 1:length(urban_id{1})
%     urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
%     urban_CHN(i,:) = sum(urban_extract);
% end
% 
% for i = 1:length(urban_id{1})
% figure(i); hold on;
% plot(yr, urban_CHN(i,:), 'kx-');
% set(gca, 'fontsize', 8);
% ylabel('Urban pollution emissions (Tg)');
% title(urban_id{1}(i), 'fontsize', 10, 'fontweight', 'bold');
% end
% 
% [report, report_id] = getgdx(gdx_filename, 'report');
% GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
% GDP_n = sum(GDP,2);
figure(10); hold on;
% plot(yr, GDP_n, 'kx-', 'markersize', 5);
% set(gca, 'fontsize', 8);
% ylabel('GDP, Billion US Dollor (2007 Value)');
set(gcf, 'unit', 'inch', 'pos', [29.9583    5.5729-0.5*i    4.0000    3.0000]);
% 
% egy_intensity_n = getgdx(gdx_filename, 'egy_intensity_n');
figure(11); hold on;
% plot(yr, egy_intensity_n, 'kx-', 'markersize', 5);
% ylim([0.3 0.8]);
% ylabel('National Energy Intensity');
set(gcf, 'unit', 'inch', 'pos', [29.9583    5.0625    4.0000    3.0000]);
% 
% [egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
% col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
% col_consumption_n = sum(col_consumption,2);
figure(12); hold on;
% plot(yr, col_consumption_n, 'kx-', 'markersize', 5);
% ylabel('Coal Consumption (mtce)');
set(gcf, 'unit', 'inch', 'pos', [33.1771    2.8021    4.0000    3.0000]);


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
figure(i); hold on; box on;
plot(yr, urban_CHN(i,:), 'r^-', 'markersize', 5);
set(gca, 'fontsize', 8);
ylabel('Urban pollution emissions (Tg)');
title(urban_id{1}(i), 'fontsize', 10, 'fontweight', 'bold');
set(gcf, 'unit', 'inch', 'pos', [0.3+0.3*i    4.3-0.3*i    4.0000    3.0000]);

end

[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
figure(10); hold on;
plot(yr, GDP_n, 'r^-', 'markersize', 5);
set(gca, 'fontsize', 8);
ylabel('GDP, Billion US Dollor (2007 Value)');
set(gcf, 'unit', 'inch', 'pos', [29.9583    5.5729-0.5*i    4.0000    3.0000]);

egy_intensity_n = getgdx(gdx_filename, 'egy_intensity_n');
figure(11); hold on;
plot(yr, egy_intensity_n, 'r^-', 'markersize', 5);
ylim([0.3 0.8]);
ylabel('National Energy Intensity');
set(gcf, 'unit', 'inch', 'pos', [29.9583    5.0625    4.0000    3.0000]);

[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
figure(12); hold on;
plot(yr, col_consumption_n, 'r^-', 'markersize', 5);

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
if i == 1
    [~, childObjs] = ...
    legend('No Policy, constant EF', ...
           'No Policy, constant EF, correct 2010 SO2&NOx', ...
           'No Policy, exp. decay EF, correct 2010 SO2&NOx', ...
           'w/ Policy, exp. decay EF, correct 2010 SO2&NOx', 2);
    set(legend, 'units', 'pixels');
    set(legend, 'pos', [57.6667  199.0000  175.3333   63.3333]);
    set(legend, 'box', 'off');
    
end

export_filename = ['fig_', char(urban_id{1}(i))];
% my_gridline; %export_fig(export_filename);
end

[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
figure(10); hold on;
plot(yr, GDP_n, 'go-', 'markersize', 5);

egy_intensity_n = getgdx(gdx_filename, 'egy_intensity_n');
figure(11); hold on;
plot(yr, egy_intensity_n, 'go-', 'markersize', 5);

[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);
figure(12); hold on;
plot(yr, col_consumption_n, 'go-', 'markersize', 5);


%% emission factor
yr = 2010:5:2100;
t = 1:length(yr);

alpha = [-0.03 %SO2
         -0.01];%NOx
ef = exp(alpha*(t-1)); % emission factor

lo_bnd = [0.85 %SO2
          0.8];%NOx

alpha = [-3.75 %SO2
         -0.4];%NOx

lo_bnd = repmat(lo_bnd,1,length(t));
ef2 = exp(alpha*(t-1)).*(1-lo_bnd)+lo_bnd; % emission factor

figure(100); clf; hold on; box on;
plot(yr, ef, 'o-', 'markersize', 4, 'color', [0.5 0.9 1], 'markerf', [0.5 0.9 1], 'linewidth', 2);
plot(yr, ef2, 'o-', 'markersize', 4, 'color', [1 0.8 0.8], 'markerf', [1 0.8 0.8], 'linewidth', 2);
ylim([0.5 1]);
set(gca, 'fontsize', 8);
ylabel('Emission Factor')


%% Emission factor in CREM
yr = 2010:5:2030;

gdx_filename = 'merge_egy_int_n.gdx';

[curb0, curb0_id] = getgdx(gdx_filename, 'curb0');
SO2_ele = squeeze(curb0(1,strcmp('SO2', curb0_id{2}),1,strcmp('ELE',curb0_id{4}),1));
SO2_agr = squeeze(curb0(1,strcmp('SO2', curb0_id{2}),1,strcmp('AGR',curb0_id{4}),1));
NOX_ele = squeeze(curb0(1,strcmp('NOX', curb0_id{2}),1,strcmp('ELE',curb0_id{4}),1));
NOX_agr = squeeze(curb0(1,strcmp('NOX', curb0_id{2}),1,strcmp('AGR',curb0_id{4}),1));
BC_ele =  squeeze(curb0(1,strcmp('BC', curb0_id{2}),1,strcmp('ELE',curb0_id{4}),1));
VOC_ele =  squeeze(curb0(1,strcmp('VOC', curb0_id{2}),1,strcmp('ELE',curb0_id{4}),1));

[curb, curb_id] = getgdx(gdx_filename, 'curb');
% curb_id{2} %BC/CO/NH3/NOX/OC/PH10/PM25/SO2/VOC
% curb_id{3} %r
% curb_id{4} %ELE/AGR
% curb_id{5} %COL/OIL/CRU

curb_SO2_ele = curb(:,strcmp('SO2', curb_id{2}),1,strcmp('ELE', curb_id{4}),1);
curb_SO2_ele = curb_SO2_ele/(SO2_ele*0.358);

curb_SO2_agr = curb(:,strcmp('SO2', curb_id{2}),1,strcmp('AGR', curb_id{4}),1);
curb_SO2_agr = curb_SO2_agr/(SO2_agr*0.89);

h1 = plot(yr, curb_SO2_ele(2:end), 's-');
h2 = plot(yr, curb_SO2_agr(2:end), 'x-', 'markersize', 10);

% ==============================
curb_NOX_ele = curb(:,strcmp('NOX', curb_id{2}),1,strcmp('ELE', curb_id{4}),1);
curb_NOX_ele = curb_NOX_ele/(NOX_ele*0.8656);

h3 = plot(yr, curb_NOX_ele(2:end), 'ro-');

% ==============================
curb_BC_ele = curb(:,strcmp('BC', curb_id{2}),1,strcmp('ELE', curb_id{4}),1);
curb_BC_ele = curb_BC_ele/BC_ele;

curb_VOC_ele = curb(:,strcmp('VOC', curb_id{2}),1,strcmp('ELE', curb_id{4}),1);
curb_VOC_ele = curb_VOC_ele/VOC_ele;

h4 = plot(yr, curb_BC_ele(2:end), 'm^-');
h5 = plot(yr, curb_VOC_ele(2:end), 'mv-');

legend([h1; h2; h3; h4;h5], 'SO2,ELE', 'SO2,AGR', 'NOX,ELE', 'BC,ELE', 'VOC,ELE',4);
my_gridline;

%% Emission factor in CREM
yr = 2010:5:2100;
dyr = yr-yr(1);

ef = exp(-0.03*dyr);
ef2 = exp(-0.01*dyr);

figure(10); clf;
hp = plot(yr, ef, 'x-', yr, ef2, 'x-');
ylim([0 1]);
xlim([2010 2100]);
set(gca, 'ytick', 0:0.1:1, 'xtick', 2010:10:2100);
legend(flipud(hp), '\alpha = -0.01', '\alpha = -0.03');
defaultratio;
set(gca, 'fontsize', 8);
ylabel('exp(\alpha*t)', 'fontsize', 10);
my_gridline;

% export_fig exp_decay -painters;



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
