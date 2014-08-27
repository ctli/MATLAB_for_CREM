clear all
close all
clc
format compact

gdx_filename = 'result_2007.gdx';

%% ================================================================== %%
% SET
[~, rs_id] = getgdx(gdx_filename, 'rs'); % All regions: China provinces + Other regions
rs = rs_id{1};
clear rs_id;

[~, r_id] = getgdx(gdx_filename, 'r'); % Other regions: USA, EUR, ODC, ROW
r = r_id{1};
clear r_id;

[~, s_id] = getgdx(gdx_filename, 's'); % Other regions: USA, EUR, ODC, ROW
s = s_id{1};
clear s_id;

[~, g_id] = getgdx(gdx_filename, 'g'); % Goods and final demands
g = g_id{1};
g(end-1:end) = []; % eliminate 'hh1' & 'hh2'
clear g_id;

for gg = 1:length(g)
    ggg{gg} = [g{gg}, ' (', num2str(gg), ')'];
end

[~, i_id] = getgdx(gdx_filename, 'i'); % Goods and sectors
i = i_id{1};
clear i_id;


%% ================================================================== %%
% Volume of energy trade [mtce]; region rs exports to region sr
[evt, evt_id] = getgdx(gdx_filename, 'evt'); % [i]x[rs]x[sr] = [5]x[34]x[34]
evt_i = evt_id{1}; % only 5 sectors: COL/CRU/ELE/GAS/OIL
evt_sr = evt_id{3};

% ==============================
province_name = {'BJ', 'TJ', 'HE'};
for province_count = 1:3
    evt_province = squeeze(evt(:,:,province_count));
    figure(province_count); clf;
    hb = bar(evt_province', 'stack');
    set(hb(1), 'facec', [0.7 0 0], 'edge', 'none');  % COL
    set(hb(2), 'facec', [1 0 0], 'edge', 'none');    % CRU
    set(hb(3), 'facec', [1 0.65 0], 'edge', 'none'); % GAS
    set(hb(4), 'facec', [1 0.6 0.6], 'edge', 'none');% OIL
    set(hb(5), 'facec', [0.4 0.8 1], 'edge', 'none');% ELE
    xlim([0.4 34.6]);
%     ylim([0 50.05]);
    set(gca, 'fontsize', 6);
    set(gca, 'xtick', 1:34, 'xticklabel', evt_sr);
    ylabel({'evt [mtce]', 'Volume of energy trade'}, 'fontsize', 8);
    title([province_name{province_count}, '-- Energy Imports (mtce)'], 'fontsize', 8, 'fontweight', 'bold');
    set(gca, 'tickdir', 'out', 'layer', 'top');
    box off;
    set(gcf, 'units', 'inch', 'pos', [0.8854    7.6146-(province_count-1)*3.55    9.35    2.4]);
    set(gca, 'pos', [0.0686    0.0927    0.9198    0.8281]);
    legend(fliplr(hb), fliplr(evt_i), 2, 'fontsize', 7, 'location', 'north');
    set(legend, 'location', 'eastoutside');
    
    text(province_count, 0.07, 'N/A', 'fontsize', 8, 'rotation', 90);
    
    if province_count==1
    line([1 1]*30.5, [0 17], 'linestyle', ':', 'color', [0.6 0.6 0.6]);
    text(31.5, 16.35, 'Foreign', 'color', [0.6 0.6 0.6], 'fontsize', 8);
    axx=[30.6 31.3];
    axy=[1 1]*16.35;
    [arrowx,arrowy] = dsxy2figxy(gca, axx, axy);
    annotation('arrow',arrowx,arrowy,'headwidth',5,'headlength',5, 'color', [0.6 0.6 0.6]);
    text(29.5, 16.35, 'Domestic', 'color', [0.6 0.6 0.6], 'fontsize', 8, 'horizontalalignment', 'right');
    axx=[30.4 29.7];
    axy=[1 1]*16.35;
    [arrowx,arrowy] = dsxy2figxy(gca, axx, axy);
    annotation('arrow',arrowx,arrowy,'headwidth',5,'headlength',5, 'color', [0.6 0.6 0.6]);
    end
    
    file_name = ['evt_', province_name{province_count}];
    %export_fig(file_name, '-painters');
end

%% ==============================
evt_BJ_import = squeeze(evt(:,:,1));
evt_BJ_export = squeeze(evt(:,1,:));
evt_BJ_sum = sum(evt_BJ_import,2)-sum(evt_BJ_export,2);

[evd, evd_id] = getgdx(gdx_filename, 'evd'); % [i]x[g]x[sr] = [5]x[15]x[24]
evd_i = evd_id{1};
evd_BJ = squeeze(sum(evd([1,3,4],:,1),2)); % COL/GAS/OIL

egyconevt = getgdx(gdx_filename, 'egyconevt'); % [29x1], missing XJ; % ELE
egyconevt = [egyconevt(1:24); 0; egyconevt(25:end)];

egyconevt_imports = zeros(size(egyconevt)); % imports
egyconevt_imports(egyconevt>=0) = egyconevt(egyconevt>=0);
egyconevt_exports = zeros(size(egyconevt)); % exports
egyconevt_exports(egyconevt<0) = egyconevt(egyconevt<0);

egyconevt_imports_BJ = egyconevt_imports(1);
egyconevt_exports_BJ = egyconevt_exports(2);

egyconnhw = getgdx(gdx_filename, 'egyconnhw'); %[r] = [30x1]
egyconnhw_BJ = egyconnhw(1);

%
e_prd = getgdx(gdx_filename, 'e_prd');
e_prd = e_prd'; % [rs]x[pe] = [3]x[33]; COL/CRU/GAS
e_prd = [e_prd(:,1:29), zeros(3,1), e_prd(:,30:end)]; % missing HI (Hainan);
e_prd_BJ = e_prd(:,1);

%% COL/CRU/GAS/OIL/ELE_i/ELE_x/nhw
temp = zeros(7,3); 
temp([1 3 4 5 6 7],1) = [evd_BJ
                         egyconnhw_BJ
                         egyconevt_imports_BJ
                         egyconevt_exports_BJ
                         ];
temp(1:5,2) = evt_BJ_sum;
% temp(1:3,2) = temp(1:3,2) + e_prd_BJ;

temp(1:3,3) = e_prd_BJ;

figure(4); clf; hold on;
hb = bar(temp', 'stack', 'edge', 'none');
set(hb(1), 'facec', [0.7 0 0]); % COL
set(hb(2), 'facec', [1 0 0]); % CRU
set(hb(3), 'facec', [1 0.65 0]); % GAS
set(hb(4), 'facec', [1 0.6 0.6]); % OIL
set(hb(5), 'facec', [0.6 1 0]); % nhw
set(hb(6), 'facec', [0.4 0.8 1]); % egyconevt_imports
set(hb(7), 'facec', [0 0.6 0.9]); % egyconevt_exports

set(gca, 'fontsize', 8);
xlim([0.4 3.6]);
title('BJ', 'fontsize', 8, 'fontweight', 'bold');
ylabel('[mtce]');
set(gca, 'xtick', 1:3, 'xticklabel', {'evd', 'evt', 'e_prd'});
legend(hb, 'COL', 'CRU','GAS', 'OIL', 'nhw', 'ELE\_imports', 'ELE\_exports');
set(legend, 'fontsize', 8);

set(gcf, 'units', 'inch', 'pos', [10.5    7.6250    5.8438    2.4]);


