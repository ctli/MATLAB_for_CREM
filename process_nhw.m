clear all
close all
clc
format compact

r = {'BJ','TJ','HE','SX','SD','NM','LN','JL','HL','SH','JS','ZJ','AH','FJ','HA','HB','HN','JX','SC','CQ','SN','GS','QH','NX','XJ','GD','GX','YN','GZ','HI'};

yr = [2007, 2010, 2015, 2020, 2025, 2030];


% %% No policy
% gdx_filename = 'result_default.gdx'; title_name = 'No Policy';
% [nucl, nucl_id] = getgdx(gdx_filename, 'nucl'); % [MWh]?
% [hydr, hydr_id] = getgdx(gdx_filename, 'hydr');
% [wind, wind_id] = getgdx(gdx_filename, 'wind');
% 
% % ==============================
% figure(1); clf;
% set(gcf, 'unit', 'inch', 'pos', [0.3542    6.1354    4.2083    4.1354]);
% 
% subplot(2,1,1);
% plot(yr, nucl, 'x-');
% set(gca, 'fontsize', 8);
% ylabel('Nuclear Generation (TWh)');
% legend(nucl_id{1},2);
% my_gridline;
% title(title_name);
% 
% subplot(2,1,2);
% hPlot = plot(yr, sum(nucl), 'x-');
% makedatatip(hPlot,[3 6]);
% set(gca, 'fontsize', 8);
% ylabel('Total Nuclear Generation in CHN (TWh)');
% annotation('textbox',[0.15 0.4 0.8 0.04],'String',{'Total nuclear generation in China'}, 'edgecolor', 'none');
% my_gridline;
% 
% % ==========
% figure(2); clf;
% set(gcf, 'unit', 'inch', 'pos', [4.7500    6.1354    4.2083    4.1354]);
% 
% subplot(2,1,1);
% plot(yr, hydr, 'x-');
% set(gca, 'fontsize', 8);
% ylabel('Hydro Generation (TWh)');
% annotation('textbox',[0.15 0.87 0.8 0.04],'String',{'29 Provinces have hydro generation'}, 'edgecolor', 'none');
% my_gridline;
% title(title_name);
% 
% subplot(2,1,2);
% hPlot = plot(yr, sum(hydr), 'x-');
% makedatatip(hPlot,[3 6]);
% set(gca, 'fontsize', 8);
% ylabel('Total Hydro Generation in CHN (TWh)');
% annotation('textbox',[0.15 0.4 0.8 0.04],'String',{'Total hydro generation in China'}, 'edgecolor', 'none');
% my_gridline;
% 
% % ==========
% figure(3); clf;
% set(gcf, 'unit', 'inch', 'pos', [9.1354    6.1354    4.2083    4.1354]);
% 
% subplot(2,1,1);
% plot(yr, wind, 'x-');
% set(gca, 'fontsize', 8);
% ylabel('Wind Generation (TWh)');
% annotation('textbox',[0.15 0.87 0.8 0.04],'String',{'15 Provinces have hydro generation'}, 'edgecolor', 'none');
% my_gridline;
% title(title_name);
% 
% subplot(2,1,2);
% hPlot = plot(yr, sum(wind), 'x-');
% makedatatip(hPlot,[3 6]);
% set(gca, 'fontsize', 8);
% ylabel('Total Wind Generation in CHN (TWh)');
% annotation('textbox',[0.15 0.4 0.8 0.04],'String',{'Total wind generation in China'}, 'edgecolor', 'none');
% my_gridline;


%% National energy intensity target
gdx_filename = 'result_egyint_n.gdx'; title_name = 'w/ National Energy Intensity Target';
[nucl, nucl_id] = getgdx(gdx_filename, 'nucl'); % [MWh]?
[hydr, hydr_id] = getgdx(gdx_filename, 'hydr');
[wind, wind_id] = getgdx(gdx_filename, 'wind');

% ==============================
figure(4); clf;
set(gcf, 'unit', 'inch', 'pos', [0.3542    0.7708    4.2083    4.1354]);

subplot(2,1,1);
plot(yr, nucl, 'x-');
set(gca, 'fontsize', 8);
ylabel('Nuclear Generation (TWh)');
legend(nucl_id{1},2);
my_gridline;
title(title_name);

subplot(2,1,2);
hPlot = plot(yr, sum(nucl), 'x-');
makedatatip(hPlot,[3 6]);
set(gca, 'fontsize', 8);
ylabel('Total Nuclear Generation in CHN (TWh)');
annotation('textbox',[0.15 0.4 0.8 0.04],'String',{'Total nuclear generation in China'}, 'edgecolor', 'none');
my_gridline;

%% ==========
figure(5); clf;
set(gcf, 'unit', 'inch', 'pos', [4.7500    0.7708    4.2083    4.1354]);

subplot(2,1,1);
plot(yr, hydr, 'x-');
set(gca, 'fontsize', 8);
ylabel('Hydro Generation (TWh)');
annotation('textbox',[0.15 0.87 0.8 0.04],'String',{'29 Provinces have hydro generation'}, 'edgecolor', 'none');
my_gridline;
title(title_name);

for rn = 1:length(hydr_id{1})
    text(2031, hydr(rn,end), hydr_id{1}(rn), 'fontsize', 8);
end

subplot(2,1,2);
hPlot = plot(yr, sum(hydr), 'x-');
makedatatip(hPlot,[3 6]);
set(gca, 'fontsize', 8);
ylabel('Total Hydro Generation in CHN (TWh)');
annotation('textbox',[0.15 0.4 0.8 0.04],'String',{'Total hydro generation in China'}, 'edgecolor', 'none');
my_gridline;

%% ==========
figure(6); clf;
set(gcf, 'unit', 'inch', 'pos', [9.1354    0.7708    4.2083    4.1354]);

subplot(2,1,1);
plot(yr, wind, 'x-');
set(gca, 'fontsize', 8);
ylabel('Wind Generation (TWh)');
annotation('textbox',[0.15 0.87 0.8 0.04],'String',{'15 Provinces have hydro generation'}, 'edgecolor', 'none');
my_gridline;
title(title_name);

subplot(2,1,2);
hPlot = plot(yr, sum(wind), 'x-');
makedatatip(hPlot,[3 6]);
set(gca, 'fontsize', 8);
ylabel('Total Wind Generation in CHN (TWh)');
annotation('textbox',[0.15 0.4 0.8 0.04],'String',{'Total wind generation in China'}, 'edgecolor', 'none');
my_gridline;




