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

ele_pctg = SO2_ele_n./SO2_n;

figure(1); clf;
bar(yr, [SO2_n-SO2_ele_n;SO2_ele_n]', 'stacked');
axis([2005 2032 0 160]);
set(gca, 'ygrid', 'on');
set(gca, 'fontsize', 8);
ylabel('SO2 (Tg)');
legend('Other Sectors', 'Electricity', 2);
set(gcf, 'unit', 'inch', 'pos', [2.8646    5.8021    4.0000    3.0000]);

for i = 1:length(yr)
    text(yr(i), SO2_n(i)-SO2_ele_n(i)/2, [num2str(ele_pctg(i)*100, '%2.0f'), '%'], 'fontsize', 8, 'horizontalalignment', 'center', 'color', 'w');
end


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

colormap jet
grid on;
% my_gridline;
% export_fig FGD_ratio;



