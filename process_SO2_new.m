clear all
close all
clc
format compact

r = {'BJ','TJ','HE','SX','SD','NM','LN','JL','HL','SH','JS','ZJ','AH','FJ','HA','HB','HN','JX','SC','CQ','SN','GS','QH','NX','XJ','GD','GX','YN','GZ','HI'};

yr = [2007, 2010:5:2030];


%% Baseline
gdx_filename = 'result_default.gdx';
[urban, urban_id] = getgdx(gdx_filename, 'urban'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[11]x[6]

SO2 = squeeze(urban(strcmp('SO2', urban_id{1}),:,:,:)); % [30]x[11]x[6]
SO2_r = squeeze(sum(SO2,2)); % [30]x[6]
SO2_n = sum(SO2_r); % [1x6]

NOX = squeeze(urban(strcmp('NOX', urban_id{1}),:,:,:)); % [30]x[11]x[6]
NOX_r = squeeze(sum(NOX,2)); % [30]x[6]
NOX_n = sum(NOX_r); % [1x6]

SO2_r_baseline = SO2_r;
NOX_r_baseline = NOX_r;

% ==============================
figure(1); clf;
plot(yr, SO2_n, 'x-');
ylabel('SO2 (Tg/yr)');
set(gcf, 'unit', 'inch', 'pos', [0.3646    5.9167    4.0000    3.0000]);

figure(2); clf;
plot(yr, NOX_n, 'x-');
ylabel('NOx (Tg/yr)');
set(gcf, 'unit', 'inch', 'pos', [0.3646    1.9167    4.0000    3.0000]);


%% w/ exogenous pollution abetment
gdx_filename = 'result_urban_exo.gdx';
[urban, urban_id] = getgdx(gdx_filename, 'urban'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[11]x[6]

SO2 = squeeze(urban(strcmp('SO2', urban_id{1}),:,:,:)); % [30]x[11]x[6]
SO2_r = squeeze(sum(SO2,2)); % [30]x[6]
SO2_n = sum(SO2_r); % [1x6]

NOX = squeeze(urban(strcmp('NOX', urban_id{1}),:,:,:)); % [30]x[11]x[6]
NOX_r = squeeze(sum(NOX,2)); % [30]x[6]
NOX_n = sum(NOX_r); % [1x6]

% ==============================
figure(1); hold on;
plot(yr, SO2_n, 'r^-', 'markersize', 5);
set(gca, 'fontsize', 8);
ylabel('SO2 (Tg/yr)');
legend('Baseline', 'w/ Exogenous Pollution Abetment', 2);
ylim([20 160]);
% my_gridline; export_fig SO2 -painters;

figure(2); hold on;
plot(yr, NOX_n, 'r^-', 'markersize', 5);
set(gca, 'fontsize', 8);
ylabel('NOx (Tg/yr)');
legend('Baseline', 'w/ Exogenous Pollution Abetment', 2);
ylim([20 160]);
% my_gridline; export_fig NOx -painters;


%% baseline vs. exogenous pollution abetment
figure(11); clf; % only 2010
hb = bar(1:30, [SO2_r_baseline(:,2), SO2_r(:,2)], 'hist');
set(hb(1), 'facec', 'b', 'edgecolor', 'none');
set(hb(2), 'facec', 'r', 'edgecolor', 'none');
set(gca, 'fontsize', 7);
ylabel('SO2 in 2010 (Tg/yr)', 'fontsize', 10, 'fontweight', 'bold');
xlim([0.4 30.6]);
ylim([0 6]);
set(gca, 'xtick', 1:30, 'xticklabel', r);
set(gca, 'tickdir', 'out');
set(gca, 'ticklength', [0.005 0.005]);
set(gcf, 'units', 'inch', 'pos', [4.6250    6.3542    9.35    2]);
set(gca, 'pos', [0.0569    0.1023    0.9263    0.7883]);
for rn = 1:30
    text(rn-0.15, SO2_r_baseline(rn,2)+0.05, num2str(SO2_r_baseline(rn,2), '%1.3f'), 'fontsize', 6, 'rotation', 90, 'color', 'b');
    text(rn+0.15, SO2_r(rn,2)+0.05, num2str(SO2_r(rn,2), '%1.3f'), 'fontsize', 6, 'rotation', 90, 'color', 'r');
end
% export_fig SO2_2010 -painters;

figure(12); clf; % only 2030
hb = bar(1:30, [SO2_r_baseline(:,end), SO2_r(:,end)], 'hist');
set(hb(1), 'facec', 'b', 'edgecolor', 'none');
set(hb(2), 'facec', 'r', 'edgecolor', 'none');
set(gca, 'fontsize', 7);
ylabel('SO2 in 2030 (Tg/yr)', 'fontsize', 10, 'fontweight', 'bold');
xlim([0.4 30.6]);
ylim([0 20]);
set(gca, 'xtick', 1:30, 'xticklabel', r);
set(gca, 'tickdir', 'out');
set(gca, 'ticklength', [0.005 0.005]);
set(gcf, 'units', 'inch', 'pos', [14.1875    6.3542    9.35    2]);
set(gca, 'pos', [0.0569    0.1023    0.9263    0.7883]);
for rn = 1:30
    text(rn-0.15, SO2_r_baseline(rn,end)+0.05, num2str(SO2_r_baseline(rn,end), '%1.3f'), 'fontsize', 6, 'rotation', 90, 'color', 'b');
    text(rn+0.15, SO2_r(rn,end)+0.05, num2str(SO2_r(rn,end), '%1.3f'), 'fontsize', 6, 'rotation', 90, 'color', 'r');
end
% export_fig SO2_2030 -painters;



%%
figure(21); clf; % only 2010
hb = bar(1:30, [NOX_r_baseline(:,2), NOX_r(:,2)], 'hist');
set(hb(1), 'facec', 'b', 'edgecolor', 'none');
set(hb(2), 'facec', 'r', 'edgecolor', 'none');
set(gca, 'fontsize', 7);
ylabel('NOx in 2010 (Tg/yr)', 'fontsize', 10, 'fontweight', 'bold');
xlim([0.4 30.6]);
ylim([0 6]);
set(gca, 'xtick', 1:30, 'xticklabel', r);
set(gca, 'tickdir', 'out');
set(gca, 'ticklength', [0.005 0.005]);
set(gcf, 'units', 'inch', 'pos', [4.6250    2.3750    9.35    2]);
set(gca, 'pos', [0.0569    0.1023    0.9263    0.7883]);
for rn = 1:30
    text(rn-0.15, NOX_r_baseline(rn,2)+0.05, num2str(NOX_r_baseline(rn,2), '%1.3f'), 'fontsize', 6, 'rotation', 90, 'color', 'b');
    text(rn+0.15, NOX_r(rn,2)+0.05, num2str(NOX_r(rn,2), '%1.3f'), 'fontsize', 6, 'rotation', 90, 'color', 'r');
end
% export_fig NOX_2010 -painters;

figure(22); clf; % only 2030
hb = bar(1:30, [NOX_r_baseline(:,end), NOX_r(:,end)], 'hist');
set(hb(1), 'facec', 'b', 'edgecolor', 'none');
set(hb(2), 'facec', 'r', 'edgecolor', 'none');
set(gca, 'fontsize', 7);
ylabel('NOx in 2030 (Tg/yr)', 'fontsize', 10, 'fontweight', 'bold');
xlim([0.4 30.6]);
ylim([0 20]);
set(gca, 'xtick', 1:30, 'xticklabel', r);
set(gca, 'tickdir', 'out');
set(gca, 'ticklength', [0.005 0.005]);
set(gcf, 'units', 'inch', 'pos', [14.1875    2.3750    9.35    2]);
set(gca, 'pos', [0.0569    0.1023    0.9263    0.7883]);
for rn = 1:30
    text(rn-0.15, NOX_r_baseline(rn,end)+0.05, num2str(NOX_r_baseline(rn,end), '%1.3f'), 'fontsize', 6, 'rotation', 90, 'color', 'b');
    text(rn+0.15, NOX_r(rn,end)+0.05, num2str(NOX_r(rn,end), '%1.3f'), 'fontsize', 6, 'rotation', 90, 'color', 'r');
end
% export_fig NOX_2030 -painters;






