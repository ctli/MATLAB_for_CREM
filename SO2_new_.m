clear all
close all
clc

r = {'BJ','TJ','HE','SX','SD','NM','LN','JL','HL','SH','JS','ZJ','AH','FJ','HA','HB','HN','JX','SC','CQ','SN','GS','QH','NX','XJ','GD','GX','YN','GZ','HI'};

yr = [2007, 2010:5:2030];

zhao_data = [
0.187
0.351
1.942
1.66
3.199
1.304
1.188
0.356
0.309
0.691
1.341
0.909
0.803
0.486
1.402
1.24
1.036
0.633
1.813
1.148
0.926
0.409
0.036
0.303
0.46
1.112
0.738
0.616
1.075
0.038
];


%% Baseline
gdx_filename = 'result_default.gdx';
[urban, urban_id] = getgdx(gdx_filename, 'urban'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[11]x[6]

SO2 = squeeze(urban(strcmp('SO2', urban_id{1}),:,:,:)); % [30]x[11]x[6]
SO2_r = squeeze(sum(SO2,2)); % [30]x[6]
SO2_n = sum(SO2_r); % [1x6]

NOX = squeeze(urban(strcmp('NOX', urban_id{1}),:,:,:)); % [30]x[11]x[6]
NOX_r = squeeze(sum(NOX,2)); % [30]x[6]
NOX_n = sum(NOX_r); % [1x6]

figure(1); clf; hold on; box on;
plot(1:30, SO2_r(:,1), 'bx-', 'markersize', 5);
plot(1:30, SO2_r(:,2), 'r^-', 'markersize', 5);
plot(1:30, zhao_data, 'ko-', 'linewidth', 1, 'markersize', 4);
set(gca, 'fontsize', 8);
set(gca, 'xtick', 1:30, 'xticklabel', r);
set(gca, 'ticklength', [0.005 0.005]);
ylabel('SO2 (Tg)');
legend('2007 SO2 from CREM Baseline', '2010 SO2 from CREM Baseline', '2010 SO2 in Zhao et al.');
set(gcf, 'units', 'inch', 'pos', [0.7292    3.7500    9.35    2.95]);
set(gca, 'pos', [0.0469    0.1129    0.9263    0.7883]);

% export_fig SO2_calibration -painters;
