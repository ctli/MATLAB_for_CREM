clear all
close all
clc

r = {'BJ','TJ','HE','SX','SD','NM','LN','JL','HL','SH','JS','ZJ','AH','FJ','HA','HB','HN','JX','SC','CQ','SN','GS','QH','NX','XJ','GD','GX','YN','GZ','HI'};

% SO2 in Tg (tera gram, i.e., mega ton)
data = [
%     2007,        2010,       2010, 2010
%     CREM,        CREM,    CREM-EX, paper
0.243972332	0.297821492	0.289019537	0.187
0.426485411	0.57254063	0.555619498	0.351
2.534487725	3.130178335	3.037667585	1.942
1.908104293	2.524705862	2.450089528	1.66
4.150450162	5.203995137	5.050193838	3.199
0.958974607	1.330697189	1.291369143	1.304
1.431799073	1.849202598	1.794550402	1.188
0.428792091	0.590907804	0.573443839	0.356
0.383490965	0.479888857	0.465705998	0.309
0.893716752	0.946048872	0.918088903	0.691
1.634910937	1.966695345	1.908570713	1.341
0.945912225	1.139012744	1.10534983	0.909
0.816698808	1.067408772	1.035862075	0.803
0.411627028	0.531589095	0.515878263	0.486
2.070454011	2.621310539	2.543839105	1.402
1.503482276	2.522180274	2.447638582	1.24
1.127223642	1.65648417	1.607527664	1.036
0.810310876	1.130951554	1.097526884	0.633
1.393535946	2.134173907	2.071099536	1.813
0.801327779	1.172507343	1.137854514	1.148
1.152704684	1.616989281	1.569200026	0.926
0.536319025	0.690497355	0.670090074	0.409
0.085347836	0.127865748	0.124086744	0.036
0.51623594	0.748039223	0.725931323	0.303
0.546659838	0.68479853	0.664559675	0.46
1.702443901	2.098101561	2.036093289	1.112
1.345253813	1.916300851	1.859665601	0.738
1.385460687	1.859870925	1.804903432	0.616
2.21924831	3.21026266	3.11538506	1.075
0.114142394	0.121077165	0.117498794	0.038
];

% figure(1); clf;
% plot(1:30, data, 'x-');
% set(gca, 'xtick', 1:30, 'xticklabel', r);
% set(gca, 'fontsize', 8);
% set(gcf, 'units', 'inch', 'pos', [0.7292    6.7292    9.35    2]);
% set(gca, 'pos', [0.0569    0.1023    0.9263    0.7883]);
% ylabel('SO2 (Tg/yr)');
% 
% figure(2); clf;
% plot(data(:,1), data(:,end), 'x');
% set(gca, 'fontsize', 8);
% xlabel('2007 data (Mt of SO2)');
% ylabel('2010 data (Mt of SO2)');
% axis equal;
% axis([0 4.5 0 4.5]);
% set(gca, 'xtick', 0:0.5:4.5, 'ytick', 0:0.5:4.5);
% hold on;
% plot([0 4.5], [0 4.5], 'color', [0.5 0.5 0.5]);
% set(gcf, 'units', 'inch', 'pos', [0.7500    2.7396    4.0000    3.0000]);
% my_gridline;
% % export_fig SO2_diag -painters;
% 
% ratio = data(:,end)./data(:,1)


%% data from Geng (AGU powerpoint)
yr_geng = 2004:2012;
SO2_geng = [29.5 33.5 34.3 32.6 31.3 28.9 28.5 29.8 29.7];
NOX_geng = [18.5, 21.2, 23.1 25 26 26.5 28.5 31 31.5];

figure(3); clf;
bar(yr_geng, SO2_geng, 'facec', [6 125 255]/255, 'edge', 'none');
set(gca, 'fontsize', 8);
% xlim([2003 2013]);
% ylim([0 40]);
title('SO2', 'fontsize', 10);
ylabel('Tg');
set(gcf, 'units', 'inch', 'pos', [4.9271    2.7396    4.0000    3.0000]);

figure(4); clf;
bar(yr_geng, NOX_geng, 'facec', [6 125 255]/255, 'edge', 'none');
set(gca, 'fontsize', 8);
% xlim([2003 2013]);
% ylim([0 40]);
title('NOX', 'fontsize', 10);
ylabel('Tg');
set(gcf, 'units', 'inch', 'pos', [9.1146    2.7396    4.0000    3.0000]);


% Emissions in CREM
yr = [2007, 2010:5:2030];

[urban, urban_id] = getgdx('result_default.gdx', 'urban'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[11]x[6]
SO2 = squeeze(urban(strcmp('SO2', urban_id{1}),:,:,:)); % [30]x[11]x[6]
SO2_r = squeeze(sum(SO2,2)); % [30]x[6]
SO2_n = sum(SO2_r); % [1x6]
NOX = squeeze(urban(strcmp('NOX', urban_id{1}),:,:,:)); % [30]x[11]x[6]
NOX_r = squeeze(sum(NOX,2)); % [30]x[6]
NOX_n = sum(NOX_r); % [1x6]

figure(3); hold on;
plot(yr, SO2_n, 'x-k');
xlim([2003 2030]);

figure(4); hold on;
plot(yr, NOX_n, 'x-k');

% ==============================
[urban, urban_id] = getgdx('result_urban_exo.gdx', 'urban'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[11]x[6]
SO2 = squeeze(urban(strcmp('SO2', urban_id{1}),:,:,:)); % [30]x[11]x[6]
SO2_r = squeeze(sum(SO2,2)); % [30]x[6]
SO2_n = sum(SO2_r); % [1x6]
NOX = squeeze(urban(strcmp('NOX', urban_id{1}),:,:,:)); % [30]x[11]x[6]
NOX_r = squeeze(sum(NOX,2)); % [30]x[6]
NOX_n = sum(NOX_r); % [1x6]

figure(3); hold on;
plot(yr, SO2_n, 'r^-', 'markersize', 5);

figure(4); hold on;
plot(yr, NOX_n, 'r^-', 'markersize', 5);


% ==============================
[urban, urban_id] = getgdx('result_egyint_n.gdx', 'urban'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[11]x[6]
SO2 = squeeze(urban(strcmp('SO2', urban_id{1}),:,:,:)); % [30]x[11]x[6]
SO2_r = squeeze(sum(SO2,2)); % [30]x[6]
SO2_n = sum(SO2_r); % [1x6]
NOX = squeeze(urban(strcmp('NOX', urban_id{1}),:,:,:)); % [30]x[11]x[6]
NOX_r = squeeze(sum(NOX,2)); % [30]x[6]
NOX_n = sum(NOX_r); % [1x6]

figure(3); hold on;
plot(yr, SO2_n, 'go-', 'markersize', 5);
xlim([2003 2031]);
ylim([0 160]);
set(gca, 'xtick', [2005 2010:5:2030]);
set(gca, 'tickdir', 'out');
legend('Emission Inventory (Gung et al.)', 'CREM Baseline (No Policy)', 'CREM w/ exponential deay EF (No Policy)', 'CREM w/ exponential deay EF & Policy', 2)
% my_gridline; export_fig SO2_compare;

figure(4); hold on;
plot(yr, NOX_n, 'go-', 'markersize', 5);
xlim([2003 2031]);
ylim([0 160]);
set(gca, 'xtick', [2005 2010:5:2030]);
set(gca, 'tickdir', 'out');
legend('Emission Inventory (Gung et al.)', 'CREM Baseline (No Policy)', 'CREM w/ exponential decay EF (No Policy)', 'CREM w/ exponential decay EF & Policy', 2)
% my_gridline; export_fig NOX_compare;



%%
[urban, urban_id] = getgdx('result_default.gdx', 'urban'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[11]x[6]
SO2 = squeeze(urban(strcmp('SO2', urban_id{1}),:,:,:)); % [30]x[11]x[6]
SO2_r = squeeze(sum(SO2,2)); % [30]x[6]
SO2_n = sum(SO2_r); % [1x6]
NOX = squeeze(urban(strcmp('NOX', urban_id{1}),:,:,:)); % [30]x[11]x[6]
NOX_r = squeeze(sum(NOX,2)); % [30]x[6]
NOX_n = sum(NOX_r); % [1x6]

SO2_ele = squeeze(SO2(:,strcmp('ELE',urban_id{3}),:)); % [30]x[6]
SO2_eis = squeeze(SO2(:,strcmp('EIS',urban_id{3}),:)); % [30]x[6]

SO2_ele_n = sum(SO2_ele);
SO2_eis_n = sum(SO2_eis);
SO2_g_n = squeeze(sum(SO2));

figure(5); clf
hb = bar(yr, SO2_g_n', 'stacked'); 
legend(fliplr(hb), fliplr(urban_id{3}), 2);
ylabel('SO2 (Tg)');

figure(51); clf;
bar(yr, [SO2_n-SO2_ele_n;SO2_ele_n]', 'stacked');
axis([2005 2032 0 160]);
set(gca, 'ygrid', 'on');
legend('Other Sectors', 'Electricity', 2);


%%
figure(10); clf; % only 2010
hb = bar(1:30, SO2_r(:,2));
set(hb(1), 'facec', 'b', 'edgecolor', 'none');

hold on;
plot(1:30, data(:,end), 'x-k');
xlim([0.4 30.6]);
ylim([0 6]);
set(gca, 'xtick', 1:30, 'xticklabel', r);
set(gca, 'tickdir', 'out');
set(gca, 'ticklength', [0.005 0.005]);
set(gcf, 'units', 'inch', 'pos', [4.6250    6.3542    9.35    2]);
set(gca, 'pos', [0.0569    0.1023    0.9263    0.7883]);



%% ================================
% % alpha = [-0.03  %SO2
% %          -0.01];%NOx
alpha = [-0.20  %SO2
         -0.1];%NOx

yr = 2010:5:2100;
t = 1:length(yr);
ef = exp(alpha*(t-1)); % emission factor

figure(11); clf;
hp = plot(yr, ef);
set(gca, 'fontsize', 8);
set(gcf, 'units', 'inch', 'pos', [7.0521    0.6146    4.0000    3.0000]);
xlim([2003 2100]);
ylim([0 1]);
ylabel('Emissioni Factor (-)');
set(gca,'xtick', [2005 2010:5:2100]);
set(gca,'ytick', 0:0.1:1);
legend(flipud(hp), 'NOx', 'SO2');
% my_gridline;


lo_bnd = [0.8  %SO2
          0.6];%NOx
tmp = [0.8187
       0.9048];

log((tmp-lo_bnd)./lo_bnd)


alpha = [-3.76 %SO2
         -0.3];%NOx
lo_bnd = repmat(lo_bnd,1,length(t));
ef2 = exp(alpha*(t-1)).*(1-lo_bnd)+lo_bnd; % emission factor

hold on;
plot(yr, ef2, ':');


% =====
[curb, curb_id] = getgdx('merge_urban_exo.gdx', 'curb');
curb_SO2_BJ_ele_col = curb(:,strcmp('SO2', curb_id{2}), strcmp('BJ', curb_id{3}), strcmp('ELE', curb_id{4}), strcmp('COL', curb_id{5}));
curb_SO2_BJ_ele_col(2:end) = curb_SO2_BJ_ele_col(2:end)/curb_SO2_BJ_ele_col(2);

curb_SO2_BJ_agr_col = curb(:,strcmp('SO2', curb_id{2}), strcmp('BJ', curb_id{3}), strcmp('AGR', curb_id{4}), strcmp('COL', curb_id{5}));
curb_SO2_BJ_agr_col(2:end) = curb_SO2_BJ_agr_col(2:end)/curb_SO2_BJ_agr_col(2);

%%
[egyreport2, egyreport2_id] = getgdx('result_default', 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);

[report, report_id] = getgdx('result_default', 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
egycons_n = sum(egycons,2);

col_share_n = col_consumption_n./egycons_n; % national coal share

figure(20); clf;
plot([2007 2010:5:2030], col_consumption_n/1e3, 'kx-');
set(gca, 'fontsize', 8);
defaultratio;
ylabel('Coal Consumption (Billion ton)');

figure(21); clf;
plot([2007 2010:5:2030], col_share_n, 'kx-');
ylim([0 0.8]);
set(gcf, 'unit', 'inch', 'pos', [4.5833    5.9167    4.0000    3.0000]);
set(gca, 'fontsize', 8);
ylabel('Coal Share');

% ========
[egyreport2, egyreport2_id] = getgdx('result_egyint_n', 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);

[report, report_id] = getgdx('result_egyint_n', 'report');
egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
egycons_n = sum(egycons,2);

col_share_n = col_consumption_n./egycons_n; % national coal share

figure(20); hold on;
plot([2007 2010:5:2030], col_consumption_n/1e3, 'go-', 'markersize', 5);
set(gca, 'fontsize', 8);
defaultratio;
ylabel('Coal Consumption (Billion ton)');
legend('Baseline', 'Policy: Nat\primel egy int.', 2);
% my_gridline; export_fig coal_consumption -painters;

figure(21); hold on;
plot([2007 2010:5:2030], col_share_n, 'go-', 'markersize', 5);
ylim([0 0.8]);
set(gcf, 'unit', 'inch', 'pos', [4.5833    5.9167    4.0000    3.0000]);
set(gca, 'fontsize', 8);
% set(gca, 'xminortick', 'on', 'yminortick', 'on');
ylabel('Coal Share');
legend('Baseline', 'Policy: Nat\primel egy int.', 3);
my_gridline; export_fig coal_share -painters;


