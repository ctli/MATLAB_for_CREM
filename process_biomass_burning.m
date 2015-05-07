clear all
close all
clc
format compact

r = {'BJ','TJ','HE','SX','SD','NM','LN','JL','HL','SH','JS','ZJ','AH','FJ','HA','HB','HN','JX','SC','CQ','SN','GS','QH','NX','XJ','GD','GX','YN','GZ','HI'};
g = {'AGR', 'COL', 'GAS', 'CRU', 'OIL', 'ELE', 'EIS', 'MAN', 'OMN', 'CON', 'TRN', 'WTR', 'SER', 'c', 'OTF'};
yr = [2007,2010,2015,2020,2025,2030];


%% urban emissions
gdx_filename = 'result_urban_exo.gdx';
[urban, urban_id] = getgdx(gdx_filename, 'urban');
urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
for i = 1:length(urban_id{1})
    urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
    urban_CHN(i,:) = sum(urban_extract);
    
    figure(i); clf; box on;
    plot(yr, urban_CHN(i,:), '^-', 'color', [0.5 0.5 0.5], 'markersize', 7, 'linewidth', 1);
    set(gca, 'fontsize', 10);
    ylabel([char(cellstr(urban_id{1}(i))), ' (Tg)'], 'fontsize', 12, 'fontweight', 'bold');
    
    set(gcf, 'unit', 'inch', 'pos', [0.25+4.15*(i-1)    6.85    4.0000    3.0000]);
    
    if i == 1, ylim([0 3]); end
    if i == 2, ylim([0 500]); end
    if i == 3, ylim([0 30]); end
    if i == 4, ylim([0 80]); end
    if i == 5, ylim([0 6]); end
    if i == 6, ylim([0 55]); end
    if i == 7, ylim([0 40]); end
    if i == 8, ylim([0 70]); end
    if i == 9, ylim([0 65]); end
end

% ==========
gdx_filename = 'result_egyint_n.gdx';
[urban, urban_id] = getgdx(gdx_filename, 'urban');
urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
for i = 1:length(urban_id{1})
    urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
    urban_CHN(i,:) = sum(urban_extract);
    
    figure(i); hold on; box on;
    plot(yr, urban_CHN(i,:), 'o-', 'color', [0 0.6 0], 'markersize', 7, 'linewidth', 1);
end

% % ==========
% gdx_filename = 'result_ccap_r.gdx';
% [urban, urban_id] = getgdx(gdx_filename, 'urban');
% urban_CHN = zeros(length(urban_id{1}),length(urban_id{4}));
% for i = 1:length(urban_id{1})
%     urban_extract = squeeze(sum(squeeze(urban(i,:,:,:)),2));
%     urban_CHN(i,:) = sum(urban_extract);
%     
%     figure(i); hold on; box on;
%     plot(yr, urban_CHN(i,:), 'xb-', 'markersize', 7, 'linewidth', 1);
%     if i==1, legend('No Policy', 'Action Plan', 'Stringent Rgnl CO2 Cap', 3); end
%     
%     my_gridline;
%     export_filename = ['fig_', char(urban_id{1}(i))];
% %     export_fig(export_filename);
% end


%% Urban emission breakdown (combustion emission vs. process emission)
[urban_c, urban_c_id] = getgdx('result_urban_exo.gdx', 'urban_c'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[8]x[6]
[urban_o, urban_o_id] = getgdx('result_urban_exo.gdx', 'urban_o'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[11]x[6]
for i = 1:length(urban_c_id{1})
urb_c = squeeze(urban_c(strcmp(urban_c_id{1}(i), urban_c_id{1}),:,:,:)); % [30]x[8]x[6]
urb_c_g = squeeze(sum(urb_c,2)); % [30]x[6]
urb_c_n = sum(urb_c_g); % [1]x[6]

urb_o = squeeze(urban_o(strcmp(urban_o_id{1}(i), urban_o_id{1}),:,:,:)); % [30]x[8]x[6]
urb_o_g = squeeze(sum(urb_o(:,1:end-1,:),2)); % [30]x[6]
urb_o_n = sum(urb_o_g); % [1]x[6]
urb_o_b = squeeze(sum(urb_o(:,end,:))); % biomass burning

figure(i+9); clf; hold on; box on;
hb0 = bar(yr-0.42, [urb_c_n; urb_o_n; urb_o_b']', 0.25, 'stacked', 'edgecolor', 'none');
colormap copper
set(hb0(1), 'facec', [0.5 0 0]); %biomass burning

hb1 = bar(yr-0.42, sum([urb_c_n; urb_o_n; urb_o_b']), 0.25, 'stacked', 'facec', 'none', 'edgecolor', [0.4 0.4 0.4], 'linewidth', 1);

set(gca, 'fontsize', 10);
set(gca, 'layer', 'top');
set(gcf, 'unit', 'inch', 'pos', [0.25+4.15*(i-1)    2.865    4.0000    3.0000]);
set(gca, 'pos', [0.1458    0.1100    0.7722    0.8150]);
set(gca, 'layer', 'bottom');
ylabel([char(cellstr(urban_c_id{1}(i))), ' (Tg)'], 'fontsize', 12, 'fontweight', 'bold');
xlim([2005 2031.5]);
legend(fliplr(hb0), 'Biomass Burning & Other', 'Industrial Process', 'Fossil Fuel Combustion', 2);
set(legend, 'fontsize', 8);

if i == 1, ylim([0 3]); end
if i == 2, ylim([0 500]); end
if i == 3, ylim([0 30]); end
if i == 4, ylim([0 80]); end
if i == 5, ylim([0 6]); end
if i == 6, ylim([0 55]); end
if i == 7, ylim([0 40]); end
if i == 8, ylim([0 70]); end
if i == 9, ylim([0 65]); end
end

%%
[urban_c, urban_c_id] = getgdx('result_egyint_n.gdx', 'urban_c'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[8]x[6]
[urban_o, urban_o_id] = getgdx('result_egyint_n.gdx', 'urban_o'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[10]x[6]
for i = 1:length(urban_c_id{1})
urb_c = squeeze(urban_c(strcmp(urban_c_id{1}(i), urban_c_id{1}),:,:,:)); % [30]x[8]x[6]
urb_c_g = squeeze(sum(urb_c,2)); % [30]x[6]
urb_c_n = sum(urb_c_g); % [1]x[6]

urb_o = squeeze(urban_o(strcmp(urban_o_id{1}(i), urban_o_id{1}),:,:,:)); % [30]x[8]x[6]
urb_o_g = squeeze(sum(urb_o(:,1:end-1,:),2)); % [30]x[6]
urb_o_n = sum(urb_o_g); % [1]x[6]
urb_o_b = squeeze(sum(urb_o(:,end,:))); % biomass burning

figure(i+9); 
% hb0 = bar(yr+0.42, [urb_c_n; urb_o_n; urb_o_b']', 0.25, 'stacked', 'edge', 'none');
hb0 = bar(yr+0.42, [urb_c_n; urb_o_n; urb_o_b']', 0.25, 'stacked');
set(hb0(1), 'facec', [0.5 0 0]); %biomass burning
hb1 = bar(yr+0.42, sum([urb_c_n; urb_o_n; urb_o_b']), 0.25, 'stacked', 'facec', 'none', 'edge', [0 0.7 0], 'linewidth', 1);

if i == 1
    text(2011.1, 3.15, 'Gray: No Policy; ', 'fontsize', 8, 'color', [0.5 0.5 0.5]);
    text(2018.3, 3.15, 'Green: Action Plan', 'fontsize', 8, 'color', [0 0.6 0]);
end

file_name = ['bar_', char(cellstr(urban_c_id{1}(i)))];
% export_fig(file_name);

end


%%
% [urban_c, urban_c_id] = getgdx('result_ccap_r.gdx', 'urban_c'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[8]x[6]
% [urban_o, urban_o_id] = getgdx('result_ccap_r.gdx', 'urban_o'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[10]x[6]
% for i = 1:length(urban_c_id{1})
% urb_c = squeeze(urban_c(strcmp(urban_c_id{1}(i), urban_c_id{1}),:,:,:)); % [30]x[8]x[6]
% urb_c_g = squeeze(sum(urb_c,2)); % [30]x[6]
% urb_c_n = sum(urb_c_g); % [1]x[6]
% 
% urb_o = squeeze(urban_o(strcmp(urban_o_id{1}(i), urban_o_id{1}),:,:,:)); % [30]x[8]x[6]
% urb_o_g = squeeze(sum(urb_o(:,1:end-1,:),2)); % [30]x[6]
% urb_o_n = sum(urb_o_g); % [1]x[6]
% urb_o_b = squeeze(sum(urb_o(:,end,:))); % biomass burning
% 
% figure(i+9); 
% hb0 = bar(yr+0.65, [urb_c_n; urb_o_n; urb_o_b']', 0.25, 'stacked', 'edge', 'none');
% set(hb0(1), 'facec', [0.5 0 0]); %biomass burning
% hb1 = bar(yr+0.65, sum([urb_c_n; urb_o_n; urb_o_b']), 0.25, 'stacked', 'facec', 'none', 'edge', 'b', 'linewidth', 1);
% 
% if i == 1
%     text(2002.1, 3.15, 'Gray: No Policy; ', 'fontsize', 8, 'color', [0.5 0.5 0.5]);
%     text(2009.3, 3.15, 'Green: Ntnl Energy Intensity Target; ', 'fontsize', 8, 'color', [0 0.6 0]);
%     text(2025, 3.15, 'Blue: Rgnl CO2 Cap', 'fontsize', 8, 'color', 'b');
% end
% 
% file_name = ['bar_', char(cellstr(urban_c_id{1}(i)))];
% % export_fig(file_name, '-painters');
% end



%% compare AGR & private consumption outputs
% % this helps to understand if it is more appropriate to link biomass burning to AGR, instead of c
% [Y, Y_id] = getgdx('merge_urb_exo.gdx', 'Y'); % [t]x[g]x[rs] = [6]x[18]x[34]
% YY = Y(:,1:16,1:30);
% YY_n = sum(YY,3);
% YY_n_AGR = YY_n(:,strcmp(Y_id{2}, 'AGR'));
% YY_n_c   = YY_n(:,strcmp(Y_id{2}, 'c'));
% 
% figure(4); clf;
% plot(yr, YY_n_AGR, 'x-', yr, YY_n_c, 'x-');
% legend('AGR', 'c', 2);
% ylabel('Sectorial Output (Normalized)');
% 
% [vom, vom_id] = getgdx('result_urban_exo.gdx', 'vom'); % [g]x[rs] = [16]x[34]
% value_AGR_n = zeros(1,length(yr));
% for yn = 1:length(yr)
% value_AGR = squeeze(YY(yn,strcmp(Y_id{2}, 'AGR'),1:30)).*vom(strcmp(vom_id{1}, 'AGR'),1:30)';
% value_AGR_n(yn) = sum(value_AGR(:));
% end
% value_c_n = zeros(1,length(yr));
% for yn = 1:length(yr)
% value_c = squeeze(YY(yn,strcmp(Y_id{2}, 'c'),1:30)).*vom(strcmp(vom_id{1}, 'c'),1:30)';
% value_c_n(yn) = sum(value_c(:));
% end
% 
% figure(5); clf;
% plot(yr, value_AGR_n, 'x-', yr, value_c_n, 'x-');
% ylabel('Sectorial Output (Billion USD in 2007)');
% legend('AGR', 'c', 2);

