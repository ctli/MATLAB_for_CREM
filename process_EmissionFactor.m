clear all
close all
clc

%% SO2 in ELE sector
yr = [2007, 2010:5:2030];
[urban, urban_id] = getgdx('result_default.gdx', 'urban');
SO2 = squeeze(urban(strcmp('SO2', urban_id{1}),:,:,:));
SO2_r = squeeze(sum(SO2,2));
SO2_n = sum(SO2_r);

SO2_ele = squeeze(SO2(:,strcmp('ELE',urban_id{3}),:)); % [30]x[6]
SO2_ele_n = sum(SO2_ele);

figure(1); clf;
bar(yr, [SO2_n-SO2_ele_n;SO2_ele_n]', 'stacked');
axis([2005 2032 0 160]);
set(gca, 'ygrid', 'on');
set(gca, 'fontsize', 8);
ylabel('SO2 (Tg)');
legend('Other Sectors', 'Electricity', 2);
set(gcf, 'unit', 'inch', 'pos', [2.8646    5.8021    4.0000    3.0000]);
oth_SO2 = SO2_n-SO2_ele_n;
oth_growth = oth_SO2(2:end)./oth_SO2(1:end-1)


%% Sulfuer scrubber installation
% Jeremy J. Schreifels, Yale Fu,and Elizabeth J. Wilson, "Sulfur dioxide 
% control in China: policy evolution during the 10th and 11th Five-year 
% Plans and lessons for the future," Energy Policy, vol 48, pp. 779-789,
% 2012. (cited by 21)

yr_Schreifels = 2005:1:2010;
tot = [390 482 552 603 650 701]; % total thermal generating capacity [GW]
FGD = [56 160 265 361 470 559]; % w/ flue gas desulphurization technology [GW]

FGD_ratio = FGD./tot

figure(2); clf; hold on; box on;
bar(yr_Schreifels, [FGD;tot-FGD]', 'stacked', 'edgecolor', 'none');
ylim([-100 1200]);
xlim([2004 2020]);
set(gca, 'fontsize',8);
% grid on;
ylabel('Thermal Generating Capacity (GW)');
title('Installation of Flue Gas Desulphurization Technology (i.e. Sulfur Scrubber)');
set(gcf, 'unit', 'inch', 'pos', [2.8646    1.8229    4.0000    3.0000]);
for ir = 1:length(FGD_ratio), text(yr_Schreifels(ir), FGD(ir), num2str(FGD_ratio(ir), '%2.2f'), 'color', 'w', 'fontsize', 8, 'horizontalalignment', 'center', 'rotation', 90); end

p = polyfit(yr_Schreifels, FGD, 1);
x_yr = 2003:2015;
y_FGD = p(1).*x_yr + p(2);
plot(x_yr, y_FGD, 'color', [0.3 0.65 1]);

p = polyfit(yr_Schreifels, tot, 1);
x_yr = 2003:2015;
y_tot = p(1).*x_yr + p(2);
plot(x_yr, y_tot, 'color', [1 0.65 0]);

legend('w/ FGD', 'w/o FGD', 'liner fit for FGD', 'linear fit for total');
set(legend, 'location', 'east');

my_gridline;
% export_fig FGD_ratio -painters;


%% emission factor
yr = 2010:5:2100;
t = 1:length(yr);

alpha = [-0.03 %SO2
         -0.01];%NOx
ef = exp(alpha*(t-1)); % emission factor

figure(3); clf;
plot(yr, ef, 'o-', 'markersize', 4, 'color', [0.5 0.9 1], 'markerf', [0.5 0.9 1], 'linewidth', 2);

% ==========
lo_bnd = [0.85 %SO2
          0.8];%NOx
alpha = [-3.75 %SO2
         -0.4];%NOx

lo_bnd = repmat(lo_bnd,1,length(t));
ef2 = exp(alpha*(t-1)).*(1-lo_bnd)+lo_bnd; % emission factor

figure(3); hold on;
plot(yr, ef2, 'x-', 'markersize', 4, 'color', [1 0.8 0.8], 'markerf', [1 0.8 0.8], 'linewidth', 2);
ylim([0.5 1]);
set(gca, 'fontsize', 8);
ylabel('Emission Factor');


lo_bnd = [0 %SO2
          0];%NOx
alpha = [-0.175 %SO2
         -0.065];%NOx
     
lo_bnd = repmat(lo_bnd,1,length(t));
ef3 = exp(alpha*(t-1)).*(1-lo_bnd)+lo_bnd; % emission factor

figure(3); hold on;
plot(yr, ef3, 'x-', 'markersize', 4, 'color', [0 0.5 0], 'markerf', [1 0.8 0.8], 'linewidth', 2);


%% Emission factor in CREM
yr = 2010:5:2030;

gdx_filename = 'merge_egyint_n.gdx';

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

curb_BC_agr = curb(:,strcmp('BC', curb_id{2}),1,strcmp('AGR', curb_id{4}),1);
curb_BC_agr = curb_BC_agr/BC_ele;

curb_VOC_agr = curb(:,strcmp('VOC', curb_id{2}),1,strcmp('AGR', curb_id{4}),1);
curb_VOC_agr = curb_VOC_agr/VOC_ele;

h6 = plot(yr, curb_BC_ele(2:end), 'k<-');
h7 = plot(yr, curb_VOC_ele(2:end), 'k>-');


legend([h1; h2; h3; h4;h5], 'SO2,ELE', 'SO2,AGR', 'NOX,ELE', 'BC,ELE', 'VOC,ELE',3);
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

