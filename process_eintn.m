clear all
close all
clc
format compact

r = {'BJ','TJ','HE','SX','SD','NM','LN','JL','HL','SH','JS','ZJ','AH','FJ','HA','HB','HN','JX','SC','CQ','SN','GS','QH','NX','XJ','GD','GX','YN','GZ','HI'};

JJJ = [1,2,3]; %BJ/TJ/HE
YRD = [10,11,12,13]; %SH/JS/ZJ/AH
PRD = 26; %GD

%% No policy
gdx_filename = 'result_default.gdx';

% ==========
egy_intensity_n = getgdx(gdx_filename, 'egy_intensity_n');

% ==========
[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);

nhw_consumption = squeeze(egyreport2(1,:,strcmp('NHW', egyreport2_id{3}),1:30))/0.12*0.356;
nhw_consumption_n = sum(nhw_consumption,2);

% ==========
[report, report_id] = getgdx(gdx_filename, 'report');

GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);

egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
egycons_n = sum(egycons,2);

fosegycons = squeeze(report(strcmp('fosegycons', report_id{1}),:,1:30));
fosegycons_n = sum(fosegycons,2);

ele_trade = squeeze(report(strcmp('exportELE', report_id{1}),:,1:30));
ele_trade_n = sum(ele_trade,2);

% =========
col_share_n = col_consumption_n./egycons_n; % national coal share
nhw_share_n = nhw_consumption_n./egycons_n;

% =========
col_share = col_consumption./egycons; % regional coal share

% =========
[urban, urban_id] = getgdx(gdx_filename, 'urban');
urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
for i = 1:length(urban_id{1})
urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
urban_CHN(i,:) = sum(urban_extract);
end

%% ===========================
yr = [2007,2010,2015,2020,2025,2030];

figure(1); clf;
plot(yr, egy_intensity_n, 'x-');
ylim([0 0.8]);
set(gcf, 'unit', 'inch', 'pos', [0.3646    5.9167    4.0000    3.0000]);
set(gca, 'fontsize', 8);
set(gca, 'xminortick', 'on', 'yminortick', 'on');
ylabel('National Energy Intensity');

% ==========
figure(2); clf;
plot(yr, col_share_n, 'x-');
ylim([0 0.8]);
set(gcf, 'unit', 'inch', 'pos', [4.5833    5.9167    4.0000    3.0000]);
set(gca, 'fontsize', 8);
set(gca, 'xminortick', 'on', 'yminortick', 'on');
ylabel('Coal Share');

line([2005 2030], [1 1]*0.65, 'linestyle', ':', 'color', [0.2 0.2 0.2]);
text(2018, 0.65, {'Action Plan Target:', 'Coal Share below 65% by 2017'}, 'fontsize', 7, 'color', [0.4 0.4 0.4]);

% ==========
figure(3); clf;
plot(yr, nhw_share_n, 'x-', 'markersize', 5);
ylim([0.0 0.8]);
set(gcf, 'unit', 'inch', 'pos', [8.7604    5.9167    4.0000    3.0000]);
set(gca, 'fontsize', 8);
set(gca, 'xminortick', 'on', 'yminortick', 'on');
ylabel('Non-Fossil Fuel (NHW) Share');

line([2005 2030], [1 1]*0.13, 'linestyle', ':', 'color', [0.2 0.2 0.2]);
text(2005.7, 0.17, {'Action Plan Target:', 'Non-Fossil Fuel Share at 13% by 2017'}, 'fontsize', 7, 'color', [0.4 0.4 0.4]);

% ==========
figure(4); clf;
plot(yr, GDP_n, 'x-');
ylim([2000 16000]);
set(gcf, 'unit', 'inch', 'pos', [0.3646    1.9479    4.0000    3.0000]);
set(gca, 'fontsize', 8);
set(gca, 'xminortick', 'on', 'yminortick', 'on');
ylabel('GDP (Billion USD in 2007)');

% ==========
dx = 0.9/2;
b = 0.25;
figure(5); clf;
tmp = [fosegycons_n, nhw_consumption_n, -ele_trade_n];
hb = bar(yr-dx, tmp, b, 'stacked', 'edge','none'); hold on;
set(hb(1), 'facec', [0.8 0.8 0.8], 'edge','none');
set(hb(2), 'facec', [0.675 1 0.675], 'edge','none');
set(hb(3), 'facec', 'none', 'edge','k');
bar(yr-dx, sum(tmp,2), b, 'facec', 'none', 'edge', 'b', 'linewidth', 1);
set(gcf, 'unit', 'inch', 'pos', [4.5833    1.9479    4.0000    3.0000]);
set(gca, 'fontsize', 8);
ylabel('Energy Consumption (mtce)');
legend('Fossil Fuel', 'Non-Fossil Fuel (NHW)', 2);
xlim([2005 2031.2]);

% ==========
figure(6); clf;
set(gcf, 'unit', 'inch', 'pos', [13.0000    5.9167    5.8333    4.3750]);

subplot(3,1,1);
plot(yr, col_consumption(:,JJJ), 'x-');
set(gca, 'fontsize', 8);
ylabel('JJJ');
% for i = 1:size(col_consumption(:,JJJ),2), text(2005.6, col_consumption(1,JJJ(i)), r{JJJ(i)}, 'fontsize', 7); end
legend(r(JJJ), 'location', 'eastoutside');
ylim([0 400]);
set(gca, 'yminortick', 'on', 'xminortick', 'on');
set(gca, 'pos', [0.08    0.6875    0.75    0.25]);
title('Regional Coal Consumption (mtce) (No Policy)');
my_gridline;

subplot(3,1,2);
plot(yr, col_consumption(:,YRD), 'x-');
set(gca, 'fontsize', 8);
ylabel('YRD')
legend(r(YRD), 'location', 'eastoutside');
ylim([0 400]);
set(gca, 'yminortick', 'on', 'xminortick', 'on');
set(gca, 'pos', [0.08    0.3729    0.75    0.25]);
my_gridline;

subplot(3,1,3);
plot(yr, col_consumption(:,PRD), 'x-');
set(gca, 'fontsize', 8);
ylabel('PRD');
legend(r(PRD), 'location', 'eastoutside');
ylim([0 400]);
set(gca, 'yminortick', 'on', 'xminortick', 'on');
set(gca, 'pos', [0.08    0.0586    0.75    0.25]);
my_gridline;

% export_fig regional_coal_consumption -painters;

% ==========
figure(60); clf;
set(gcf, 'unit', 'inch', 'pos', [13.0000    0.5729    5.8333    4.3750]);

subplot(3,1,1);
plot(yr, col_share(:,JJJ), 'x-');
set(gca, 'fontsize', 8);
ylabel('JJJ');
legend(r(JJJ), 'location', 'eastoutside');
ylim([0 1]);
set(gca, 'ytick', 0:0.2:1);
set(gca, 'xminortick', 'on');
set(gca, 'pos', [0.08    0.6875    0.75    0.25]);
title('Regional Coal Share (No Policy)');
my_gridline;

subplot(3,1,2);
plot(yr, col_share(:,YRD), 'x-');
set(gca, 'fontsize', 8);
ylabel('YRD')
legend(r(YRD), 'location', 'eastoutside');
ylim([0 1]);
set(gca, 'ytick', 0:0.2:1);
set(gca, 'xminortick', 'on');
set(gca, 'pos', [0.08    0.3729    0.75    0.25]);
my_gridline;

subplot(3,1,3);
plot(yr, col_share(:,PRD), 'x-');
set(gca, 'fontsize', 8);
ylabel('PRD');
legend(r(PRD), 'location', 'eastoutside');
ylim([0 1]);
set(gca, 'ytick', 0:0.2:1);
set(gca, 'xminortick', 'on');
set(gca, 'pos', [0.08    0.0586    0.75    0.25]);
my_gridline;

% % ==========
% for i = 1:length(urban_id{1})
% figure(10+i); clf;
% plot(yr, urban_CHN(i,:), 'x-');
% set(gca, 'fontsize', 8);
% ylabel('Urban pollution emissions');
% title(urban_id{1}(i));
% set(gcf, 'unit', 'inch', 'pos', [21.2604+0.5*i    5.5729-0.5*i    4.0000    3.0000]);
% end

% ==========
figure(20); clf;
bar(1:30, col_consumption(end,:), 'facec', [70 126 255]/255, 'edgecolor', 'none');
set(gca, 'fontsize', 7);
xlim([0.4 30.6]);
ylim([0 600]);
set(gca, 'xtick', 1:30, 'xticklabel', r);
set(gca, 'tickdir', 'out');
set(gca, 'ticklength', [0.005 0.005]);
ylabel('Coal Consumption in 2030 (mtce)');

set(gcf, 'units', 'inch', 'pos', [0.7292    0.770    9.35    2]);
set(gca, 'pos', [0.0569    0.1023    0.9263    0.7883]);


%% policy scenario: national energy intensity
gdx_filename = 'result_egyint_n.gdx';

% ==========
egy_intensity_n = getgdx(gdx_filename, 'egy_intensity_n');

% ==========
[egyreport2, egyreport2_id] = getgdx(gdx_filename, 'egyreport2');
col_consumption = squeeze(egyreport2(1,:,strcmp('COL', egyreport2_id{3}),1:30));
col_consumption_n = sum(col_consumption,2);

nhw_consumption = squeeze(egyreport2(1,:,strcmp('NHW', egyreport2_id{3}),1:30))/0.12*0.356;
nhw_consumption_n = sum(nhw_consumption,2);

% ==========
[report, report_id] = getgdx(gdx_filename, 'report');

GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);

egycons = squeeze(report(strcmp('egycons', report_id{1}),:,1:30)); %(COL+CRU+GAS)-(ELE export)+NHW
egycons_n = sum(egycons,2);

fosegycons = squeeze(report(strcmp('fosegycons', report_id{1}),:,1:30));
fosegycons_n = sum(fosegycons,2);

ele_trade = squeeze(report(strcmp('exportELE', report_id{1}),:,1:30));
ele_trade_n = sum(ele_trade,2);

% =========
col_share_n = col_consumption_n./egycons_n;
nhw_share_n = nhw_consumption_n./egycons_n;

% =========
col_share = col_consumption./egycons;

% =========
[urban, urban_id] = getgdx(gdx_filename, 'urban');
urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
for i = 1:length(urban_id{1})
urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
urban_CHN(i,:) = sum(urban_extract);
end

%% ===========================
yr = [2007, 2010,2015,2020,2025,2030];

figure(1); hold on;
plot(yr, egy_intensity_n, 'r^-', 'markersize', 5);

egy_intensity_n_2012 = interp1(yr, egy_intensity_n, 2012);
plot(2012, egy_intensity_n_2012, '^m', 'markerf', 'm', 'linewidth', 1, 'markersize', 5);

egy_intensity_n_2017 = interp1(yr, egy_intensity_n, 2017, 'linear', 'extrap');
plot(2017, egy_intensity_n_2017, 'm^', 'markerf', 'm', 'linewidth', 1, 'markersize', 5);

axx=[2011.5 2016.2];
axy=[1 1]*egy_intensity_n_2017;
[arrowx,arrowy] = dsxy2figxy(gca, axx, axy);
annotation('line',arrowx, arrowy);

axx=[1 1]*2012;
axy=[egy_intensity_n_2012*0.97 egy_intensity_n_2017];
[arrowx,arrowy] = dsxy2figxy(gca, axx, axy);
annotation('arrow',arrowx, arrowy, 'HeadLength', 4, 'HeadWidth', 4);
text(2006, 0.585, {'Energy intensity', 'in 2017 is 18%', 'lower than 2012'}, 'fontsize', 7)

legend('No Policy', 'w/ National Energy Intensity Target', 3);

% my_gridline; export_fig egyintn -painters;

% ==========
figure(2); hold on;
plot(yr, col_share_n, 'r^-', 'markersize', 5);
% my_gridline; export_fig coal_share -painters;

% ==========
figure(3); hold on;
plot(yr, nhw_share_n, 'r^-', 'markersize', 5);
% my_gridline; export_fig nhw_share -painters;

% ==========
figure(4); hold on;
plot(yr, GDP_n, 'r^-', 'markersize', 5);
% my_gridline; export_fig GDP -painters;

% ==========
figure(5); hold on;
tmp = [fosegycons_n,nhw_consumption_n,-ele_trade_n];
hb = bar(yr+dx, tmp, b, 'stacked', 'edge','none');
set(hb(1), 'facec', [0.8 0.8 0.8], 'edge','none');
set(hb(2), 'facec', [0.675 1 0.675], 'edge','none');
set(hb(3), 'facec', 'none', 'edge','k');
bar(yr+dx, sum(tmp,2), b, 'facec', 'none', 'edge', 'r', 'linewidth', 1);
text(yr(1)-dx, sum(tmp(1,:))+100, 'Left: No Policy', 'fontsize', 6, 'rotation', 90, 'color', 'b');
text(yr(1)+dx, sum(tmp(1,:))+100, 'Right: w/ Nat\primel Egy. Int. Target', 'fontsize', 6, 'rotation', 90, 'color', 'r');
% my_gridline; export_fig egycons -painters;

% ==========
figure(7); clf;
set(gcf, 'unit', 'inch', 'pos', [20.1354    5.5938    5.8333    4.3750]);

subplot(3,1,1);
plot(yr, col_consumption(:,JJJ), '^-', 'markersize', 5);
set(gca, 'fontsize', 8);
ylabel('JJJ');
legend(r(JJJ), 'location', 'eastoutside');
ylim([0 400]);
set(gca, 'yminortick', 'on', 'xminortick', 'on');
set(gca, 'pos', [0.08    0.6875    0.75    0.25]);
title('Regional Coal Consumption (mtce) (w/ National Energy Intensity Target)');
my_gridline;

subplot(3,1,2);
plot(yr, col_consumption(:,YRD), '^-', 'markersize', 5);
set(gca, 'fontsize', 8);
ylabel('YRD')
legend(r(YRD), 'location', 'eastoutside');
ylim([0 400]);
set(gca, 'yminortick', 'on', 'xminortick', 'on');
set(gca, 'pos', [0.08    0.3729    0.75    0.25]);
my_gridline;

subplot(3,1,3);
plot(yr, col_consumption(:,PRD), '^-', 'markersize', 5);
set(gca, 'fontsize', 8);
ylabel('PRD');
legend(r(PRD), 'location', 'eastoutside');
ylim([0 400]);
set(gca, 'yminortick', 'on', 'xminortick', 'on');
set(gca, 'pos', [0.08    0.0586    0.75    0.25]);
my_gridline;

% export_fig regional_coal_consumption_wPolicy -painters;

% ==========
figure(70); clf;
set(gcf, 'unit', 'inch', 'pos', [20.1354    0.2292    5.8333    4.3750]);

subplot(3,1,1);
plot(yr, col_share(:,JJJ), '^-', 'markersize', 5);
set(gca, 'fontsize', 8);
ylabel('JJJ');
legend(r(JJJ), 'location', 'eastoutside');
ylim([0 1]);
set(gca, 'ytick', 0:0.2:1);
set(gca, 'xminortick', 'on');
set(gca, 'pos', [0.08    0.6875    0.75    0.25]);
title('Regional Coal Share (No Policy)');
my_gridline;

subplot(3,1,2);
plot(yr, col_share(:,YRD), '^-', 'markersize', 5);
set(gca, 'fontsize', 8);
ylabel('YRD')
legend(r(YRD), 'location', 'eastoutside');
ylim([0 1]);
set(gca, 'ytick', 0:0.2:1);
set(gca, 'xminortick', 'on');
set(gca, 'pos', [0.08    0.3729    0.75    0.25]);
my_gridline;

subplot(3,1,3);
plot(yr, col_share(:,PRD), '^-', 'markersize', 5);
set(gca, 'fontsize', 8);
ylabel('PRD');
legend(r(PRD), 'location', 'eastoutside');
ylim([0 1]);
set(gca, 'ytick', 0:0.2:1);
set(gca, 'xminortick', 'on');
set(gca, 'pos', [0.08    0.0586    0.75    0.25]);
my_gridline;

% % ==========
% for i = 1:length(urban_id{1})
% figure(10+i); hold on;
% plot(yr, urban_CHN(i,:), 'r^-', 'markersize', 5);
% set(gca, 'fontsize', 8);
% if i == 1, legend('No Policy', 'w/ Policy', 2); end
% end

% ==========
figure(20); hold on;
bar(1:30, col_consumption(end,:), 0.55, 'facec', [1 0.5 0.5], 'edgecolor', 'none');
legend('No Policy', 'w/ National Energy Intensity Target',2, 'orientation', 'horizontal');


