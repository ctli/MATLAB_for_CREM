clear all
close all
clc


%% Emission factor in CREM
yr = [2007, 2010:5:2100];
dyr = yr-yr(1);

ef = exp(-0.01*dyr);
ef2 = exp(-0.03*dyr);
ef3 = exp(-0.07*dyr);

figure(1); clf; hold on;
plot(yr, ef, 'x-', yr, ef2, 'o-', yr, ef3, '^-', 'markersize', 5);
plot([1 1]*2030, [0 1], 'k:');

ylim([0 1]);
xlim([2000 2100]);
set(gca, 'ytick', 0:0.1:1, 'xtick', 2000:10:2100);
legend('\alpha = -0.01', '\alpha = -0.03', '\alpha = -0.07');
set(gcf, 'unit', 'inch', 'pos', [1.65    6.25    4.0000    3.0000]);
set(gca, 'fontsize', 8);
ylabel('exp(\alpha*t)', 'fontsize', 10);
my_gridline;


%% Emission factor in CREM
yr = [2007, 2010:5:2030];

gdx_filename = 'result_urban_exo.gdx';
[curb0, curb0_id] = getgdx(gdx_filename, 'curb0'); % [9]x[30]x[8]x[4]
[ourb0, ourb0_id] = getgdx(gdx_filename, 'ourb0'); % [9]x[30]x[11]
SO2_ele = squeeze(curb0(strcmp('SO2', curb0_id{1}),1,strcmp('ELE',curb0_id{3}),1)); % [1x1], scalar
SO2_agr = squeeze(curb0(strcmp('SO2', curb0_id{1}),1,strcmp('AGR',curb0_id{3}),1)); % [1x1]
BC_agr =  squeeze(curb0(strcmp('BC', curb0_id{1}),1,strcmp('AGR',curb0_id{3}),1)); % [1x1]
VOC_agr =  squeeze(curb0(strcmp('VOC', curb0_id{1}),1,strcmp('AGR',curb0_id{3}),1)); % [1x1]

gdx_filename = 'merge_urb_exo.gdx';
[curb, curb_id] = getgdx(gdx_filename, 'curb'); % [6]x[9]x[30]x[8]x[4]
[ourb, ourb_id] = getgdx(gdx_filename, 'ourb'); % [6]x[9]x[30]x[11]
SO2_ele_t = squeeze(curb(:,strcmp('SO2', curb_id{2}),1,strcmp('ELE',curb_id{4}),1)); %[6x1]
SO2_agr_t = squeeze(curb(:,strcmp('SO2', curb_id{2}),1,strcmp('AGR',curb_id{4}),1));
BC_agr_t =  squeeze(curb(:,strcmp('BC', curb_id{2}),1,strcmp('AGR',curb_id{4}),1)); % -0.03 decay
VOC_agr_t =  squeeze(curb(:,strcmp('VOC', curb_id{2}),1,strcmp('AGR',curb_id{4}),1)); % -0.01 decay

ef_SO2_ele = SO2_ele_t/SO2_ele;
ef_SO2_agr = SO2_agr_t/SO2_agr;
ef_BC_agr = BC_agr_t/BC_agr;
ef_VOC_agr = VOC_agr_t/VOC_agr;


%%
figure(2); clf; hold on;
plot(yr, ef_SO2_ele, 'bx-', ...
     yr, ef_BC_agr, 'rx-', ...
     yr, ef_VOC_agr, 'gx-');
legend('SO2 ele', 'BC agr', 'VOC agr');

xx = 2015:5:2100;
xy = ef_SO2_ele(2)*(exp(-0.3*(xx-2007-3))*(1-0.85)+0.85);
plot(xx, xy, 'bo:');

xy = ef_BC_agr(3)*exp(-0.03*(xx-2007-8));
plot(xx, xy, 'ro:');

xx = 2015:5:2100;
xy = ef_VOC_agr(3)*exp(-0.01*(xx-2007-8));
plot(xx, xy, 'go:');

set(gcf, 'unit', 'inch', 'pos', [5.85    6.25    4.0000    3.0000]);
title('Real Emission Factor', 'fontsize', 12);
ylim([0 1]);
xlim([2000 2100]);
my_gridline;


%%
figure(3); clf; hold on; box on;
h1 = plot(yr, ef_SO2_ele, 's-', 'color', [0.1 0.1 0.1], 'markersize', 7, 'linewidth', 1);
h2 = plot(yr, ef_BC_agr, 'x-', 'color', [0.35 0.35 0.35], 'markersize', 7, 'linewidth', 1);
h3 = plot(yr, ef_VOC_agr, 'd-', 'color', [0.6 0.6 0.6], 'markersize', 6, 'linewidth', 1);
ylim([0 1]);
xlim([2000 2050]);
my_gridline;

xx = 2030:5:2100;
xy = ef_SO2_ele(2)*(exp(-0.3*(xx-2007-3))*(1-0.85)+0.85);
plot(xx, xy, ':', 'color', [0.1 0.1 0.1], 'markersize', 7, 'linewidth', 1);
plot(xx(2:end), xy(2:end), 's', 'color', [0.1 0.1 0.1], 'markersize', 7, 'linewidth', 1);

xx = 2030:5:2100;
xy = ef_BC_agr(3)*exp(-0.03*(xx-2007-8));
plot(xx, xy, ':', 'color', [0.35 0.35 0.35], 'markersize', 7, 'linewidth', 1);
plot(xx(2:end), xy(2:end), 'x', 'color', [0.35 0.35 0.35], 'markersize', 7, 'linewidth', 1);

xx = 2030:5:2100;
xy = ef_VOC_agr(3)*exp(-0.01*(xx-2007-8));
plot(xx, xy, ':', 'color', [0.6 0.6 0.6], 'markersize', 6, 'linewidth', 1);
plot(xx(2:end), xy(2:end), 'd', 'color', [0.6 0.6 0.6], 'markersize', 6, 'linewidth', 1);

set(gcf, 'unit', 'inch', 'pos', [10.05    6.25    4.0000    3.0000]);
set(gca, 'fontsize', 10);
ylabel('Emission Factor (-)', 'fontsize', 12, 'fontweight', 'bold');
legend([h3, h2, h1], 'VOC, NOx, CO, NH3', 'SO2, BC, OC', 'SO2 in ELE sector')
set(legend, 'fontsize', 9);

yy = [0.25 0.30];
line([1 1]*2010, yy, 'color', 'k');
axx =[2009.2 2005];
axy =[1 1]*mean(yy);
[arrowx,arrowy] = dsxy2figxy(gca, axx, axy);
annotation('arrow',arrowx, arrowy, 'HeadLength',5,'HeadWidth',5, 'color', 'k', 'linestyle', '-');
text(2009.5, 0.26, {'Calibration', 'to match','historical data'}, 'fontsize', 6, 'horizontalalignment', 'right', 'verticalalignment', 'top');

axx=[2010.5 2015];
axy=[1 1]*mean(yy);
[arrowx,arrowy] = dsxy2figxy(gca, axx, axy);
annotation('arrow',arrowx, arrowy, 'HeadLength',5,'HeadWidth', 5, 'color', 'k', 'linestyle', '-');
text(2010.7, 0.26, {'Projection', '(exponential decay)'}, 'fontsize', 6, 'horizontalalignment', 'left', 'verticalalignment', 'top');

axx=[2007 2030];
axy=[1 1]*0.06;
[arrowx,arrowy] = dsxy2figxy(gca, axx, axy);
annotation('doublearrow', arrowx, arrowy, 'HeadLength',6,'HeadWidth',6, 'color', [0 0.6 0], 'linestyle', '-');
text(mean(axx), 0.12, 'Time Frame of this Study', 'fontsize', 7, 'horizontalalignment', 'center', 'verticalalignment', 'top', 'color', [0 0.6 0]);

% export_fig ef_2050 -r300 -painters;


%%
yr = [2007, 2010:5:2030];

gdx_filename = 'result_urban_exo.gdx';
[curb0, curb0_id] = getgdx(gdx_filename, 'curb0'); % [9]x[30]x[8]x[4]
SO2_ele = squeeze(curb0(strcmp('SO2', curb0_id{1}),1,strcmp('ELE',curb0_id{3}),1)); % [1x1], scalar
SO2_agr = squeeze(curb0(strcmp('SO2', curb0_id{1}),1,strcmp('AGR',curb0_id{3}),1)); % [1x1]
NOX_ele = squeeze(curb0(strcmp('NOX', curb0_id{1}),1,strcmp('ELE',curb0_id{3}),1)); % [1x1]
NOX_agr = squeeze(curb0(strcmp('NOX', curb0_id{1}),1,strcmp('AGR',curb0_id{3}),1)); % [1x1]
BC_ele =  squeeze(curb0(strcmp('BC', curb0_id{1}),1,strcmp('ELE',curb0_id{3}),1)); % [1x1]
VOC_ele =  squeeze(curb0(strcmp('VOC', curb0_id{1}),1,strcmp('ELE',curb0_id{3}),1)); % [1x1]

gdx_filename = 'merge_urb_exo.gdx';
[curb, curb_id] = getgdx(gdx_filename, 'curb'); % [6]x[9]x[30]x[8]x[4]
curb_SO2_ele = curb(:,strcmp('SO2', curb_id{2}),1,strcmp('ELE', curb_id{4}),1);
curb_SO2_ele = curb_SO2_ele/SO2_ele;

curb_SO2_agr = curb(:,strcmp('SO2', curb_id{2}),1,strcmp('AGR', curb_id{4}),1);
curb_SO2_agr = curb_SO2_agr/SO2_agr;

figure(4); clf; hold on;
h1 = plot(yr, curb_SO2_ele, 'bs-');
h2 = plot(yr, curb_SO2_agr, 'bx-', 'markersize', 10);

% ==============================
curb_NOX_ele = curb(:,strcmp('NOX', curb_id{2}),1,strcmp('ELE', curb_id{4}),1);
curb_NOX_ele = curb_NOX_ele/NOX_ele;

curb_NOX_agr = curb(:,strcmp('NOX', curb_id{2}),1,strcmp('AGR', curb_id{4}),1);
curb_NOX_agr = curb_NOX_agr/NOX_agr;

h3 = plot(yr, curb_NOX_ele, 'ro-');
h4 = plot(yr, curb_NOX_agr, 'rx-');

% ==============================
curb_BC_ele = curb(:,strcmp('BC', curb_id{2}),1,strcmp('ELE', curb_id{4}),1);
curb_BC_ele = curb_BC_ele/BC_ele;

curb_VOC_ele = curb(:,strcmp('VOC', curb_id{2}),1,strcmp('ELE', curb_id{4}),1);
curb_VOC_ele = curb_VOC_ele/VOC_ele;

h5 = plot(yr, curb_BC_ele, 'g^-');
h6 = plot(yr, curb_VOC_ele, 'mv-');

ylim([0 1]);
xlim([2000 2100]);
grid on;
set(gca, 'fontsize',8);
set(gcf, 'unit', 'inch', 'pos', [5.85    2.25    4.0000    3.0000]);
legend([h1; h2; h3; h4; h5; h6], 'SO2,ELE', 'SO2,AGR', 'NOX,ELE', 'NOX,AGR', 'BC,ELE (-0.03)', 'VOC,ELE (-0.01)');
title('Real Emission Factor', 'fontsize', 12);


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

figure(5); clf; hold on; box on;
plot(yr, ef, 'o-', 'markersize', 4, 'color', [0.5 0.9 1], 'markerf', [0.5 0.9 1], 'linewidth', 2);
plot(yr, ef2, 'o-', 'markersize', 4, 'color', [1 0.8 0.8], 'markerf', [1 0.8 0.8], 'linewidth', 2);
ylim([0.5 1]);
set(gcf, 'unit', 'inch', 'pos', [10.05    2.25    4.0000    3.0000]);
set(gca, 'fontsize', 8);
ylabel('Emission Factor')

