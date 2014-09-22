clear all
close all
clc
format compact

r = {'BJ','TJ','HE','SX','SD','NM','LN','JL','HL','SH','JS','ZJ','AH','FJ','HA','HB','HN','JX','SC','CQ','SN','GS','QH','NX','XJ','GD','GX','YN','GZ','HI'};

yr = [2007, 20105:2030];

ratio = 0.12;


%% National energy intensity target
gdx_filename = 'result_default.gdx'; title_name = 'w/ National Energy Intensity Target';
[nucl, nucl_id] = getgdx(gdx_filename, 'nucl'); % [mtce]
[hydr, hydr_id] = getgdx(gdx_filename, 'hydr'); % [mtce]
[wind, wind_id] = getgdx(gdx_filename, 'wind'); % [mtce]

% ==============================
figure(4); clf;
set(gcf, 'unit', 'inch', 'pos', [0.3542    6.1354    4.2083    4.1354]);

subplot(2,1,1);
plot(yr, nucl/ratio, 'x-');
set(gca, 'fontsize', 8);
ylabel('Nuclear Generation (TWh)');
legend(nucl_id{1},2);
my_gridline;
title(title_name);

subplot(2,1,2);
hPlot = plot(yr, sum(nucl)/ratio, 'x-');
makedatatip(hPlot,[1 2]);
set(gca, 'fontsize', 8);
ylabel('National Nuclear Generation (TWh)');
annotation('textbox',[0.15 0.4 0.8 0.04],'String',{'Total nuclear generation in China'}, 'edgecolor', 'none');
my_gridline;

%% ==========
figure(5); clf;
set(gcf, 'unit', 'inch', 'pos', [4.7500    6.1354    4.2083    4.1354]);

subplot(2,1,1);
plot(yr, hydr/ratio, 'x-');
set(gca, 'fontsize', 8);
ylabel('Hydro Generation (TWh)');
annotation('textbox',[0.15 0.87 0.8 0.04],'String',{'29 Provinces have hydro generation'}, 'edgecolor', 'none');
my_gridline;
title(title_name);

subplot(2,1,2);
hPlot = plot(yr, sum(hydr)/ratio, 'x-');
makedatatip(hPlot,[1 2]);
set(gca, 'fontsize', 8);
ylabel('National Hydro Generation (TWh)');
annotation('textbox',[0.15 0.4 0.8 0.04],'String',{'Total hydro generation in China'}, 'edgecolor', 'none');
my_gridline;

% 2007 hydro
hydr_crem = [hydr(1:9,:); zeros(1,length(yr)); hydr(10:end,:)]/ratio;% patch missing data in SH
hydro_data_2007 = [0.493	0.014	0.568	4.732	0.077	1.186	4.381	6.183	1.041	0	0.295	11.815	1.967	31.159	8.853	93.77	31.256	8.506	81.413	8.375	5.545	18.908	20.776	1.747	5.884	24.103	32.352	43.095	34.062	1.309];
tmp = [hydr_crem(:,1), hydro_data_2007'];
figure(50); clf;
hb = bar(tmp, 'hist');
set(hb(1), 'facec', [0.3 0.65 1], 'edgecolor', 'none');
set(hb(2), 'facec', [0.1 0.2  1], 'edgecolor', 'none');
set(gca, 'fontsize', 8, 'xtick', 1:30, 'xticklabel', r);
set(gca, 'ticklength', [0.001 0.001]);
xlim([0.4 30.6]);
legend('CREM', 'data');
my_gridline;
title('2007 Hydro Generation', 'fontsize', 10, 'fontweight', 'bold');
ylabel('Hydro Generation (TWh)');
set(gcf, 'units', 'inch', 'pos', [0.1771    4.6979    9.35    3]);
set(gca, 'pos', [0.0569    0.1023    0.9263    0.7883]);
annotation('textbox',[0.06 0.82 1 0.04],'String',{'29 Provinces have hydro generation'}, 'edgecolor', 'none');
annotation('textbox',[0.06 0.77 1 0.04],'String',{['CREM: CHN total = ', num2str(sum(hydr_crem(:,1)), '%3.0f'), ' TWh']}, 'edgecolor', 'none', 'color', [0.3 0.65 1]);
annotation('textbox',[0.06 0.72 1 0.04],'String',{['data: CHN total = ', num2str(sum(hydro_data_2007), '%3.0f'), ' TWh']}, 'edgecolor', 'none', 'color', [0.1 0.2  1]);

% 2010 hydro
hydro_data_2010 = [0.43	0.012	0.8	3.7	0.06	2	5.7	10.3	2.2	7	1.4	22.4	3.7	45.4	8.5	124.6	37.5	10.1	113.9	14.3	7.5	26.3	36.3	1.8	10.3	26.8	47.5	81.4	38.4	2];
tmp = [hydr_crem(:,2), hydro_data_2010'];
figure(51); clf;
hb = bar(tmp, 'hist');
set(hb(1), 'facec', [0.3 0.65 1], 'edgecolor', 'none');
set(hb(2), 'facec', [0.1 0.2  1], 'edgecolor', 'none');
set(gca, 'fontsize', 8, 'xtick', 1:30, 'xticklabel', r);
set(gca, 'ticklength', [0.001 0.001]);
xlim([0.4 30.6]);
legend('CREM', 'data');
my_gridline;
title('2010 Hydro Generation', 'fontsize', 10, 'fontweight', 'bold');
ylabel('Hydro Generation (TWh)');
set(gcf, 'units', 'inch', 'pos', [0.1771    0.6979    9.35    3]);
set(gca, 'pos', [0.0569    0.1023    0.9263    0.7883]);
annotation('textbox',[0.06 0.82 1 0.04],'String',{'29 Provinces have hydro generation'}, 'edgecolor', 'none');
annotation('textbox',[0.06 0.77 1 0.04],'String',{['CREM: CHN total = ', num2str(sum(hydr_crem(:,2)), '%3.0f'), ' TWh']}, 'edgecolor', 'none', 'color', [0.3 0.65 1]);
annotation('textbox',[0.06 0.72 1 0.04],'String',{['data: CHN total = ', num2str(sum(hydro_data_2010), '%3.0f'), ' TWh']}, 'edgecolor', 'none', 'color', [0.1 0.2  1]);

%% ==========
figure(6); clf;
set(gcf, 'unit', 'inch', 'pos', [9.1354    6.1354    4.2083    4.1354]);

subplot(2,1,1);
plot(yr, wind/ratio, 'x-');
set(gca, 'fontsize', 8);
ylabel('Wind Generation (TWh)');
annotation('textbox',[0.15 0.87 0.8 0.04],'String',{'15 Provinces have hydro generation'}, 'edgecolor', 'none');
my_gridline;
title(title_name);

subplot(2,1,2);
hPlot = plot(yr, sum(wind)/ratio, 'x-');
makedatatip(hPlot,[1 2]);
set(gca, 'fontsize', 8);
ylabel('National Wind Generation (TWh)');
annotation('textbox',[0.15 0.4 0.8 0.04],'String',{'Total wind generation in China'}, 'edgecolor', 'none');
my_gridline;

%% 2010 wind
[~, ia, ib] = intersect(wind_id{1}, r);
wind_crem = zeros(30,length(yr));
wind_crem(ib,:) = wind(ia,:)/ratio;
wind_data_2010 = [0.31	0.01	5.7	0.6	2.7	17.4	4.7	3.3	3.3	0.2	2.3	0.5	0	1.2	0.11	0.07	0.04	0.14	0	0.05	0	2.1	0	0.8	2.3	1.02	0	0.39	0	0.24];
tmp = [wind_crem(:,2), wind_data_2010'];
figure(61); clf;
hb = bar(tmp, 'hist');
set(hb(1), 'facec', [0 0.8 0], 'edgecolor', 'none');
set(hb(2), 'facec', [0 0.6 0], 'edgecolor', 'none');
set(gca, 'fontsize', 8, 'xtick', 1:30, 'xticklabel', r);
set(gca, 'ticklength', [0.001 0.001]);
xlim([0.4 30.6]);
legend('CREM', 'data');
title('2010 Wind Generation', 'fontsize', 10, 'fontweight', 'bold');
ylabel('Wind Generation (TWh)');
set(gcf, 'units', 'inch', 'pos', [9.7292    0.6979    9.35    3]);
set(gca, 'pos', [0.0569    0.1023    0.9263    0.7883]);
annotation('textbox',[0.06 0.82 1 0.04],'String',{'15 Provinces have wind generation'}, 'edgecolor', 'none');
annotation('textbox',[0.06 0.77 1 0.04],'String',{['CREM: CHN total = ', num2str(sum(tmp(:,1)), '%3.0f'), ' TWh']}, 'edgecolor', 'none', 'color', [0 0.8 0]);
annotation('textbox',[0.06 0.72 1 0.04],'String',{['data: CHN total = ', num2str(sum(tmp(:,2)), '%3.0f'), ' TWh']}, 'edgecolor', 'none', 'color', [0 0.6 0]);
my_gridline;

