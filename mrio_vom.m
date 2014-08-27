clear all
close all
clc
format compact

% gdx_filename = 'result_default.gdx'; current_yr = 2007;
% gdx_filename = 'result_2030.gdx'; current_yr = 2030;
gdx_filename = 'result_egycap.gdx'; current_yr = 2007;

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

% for gg = 1:length(g)
%     ggg{gg} = [g{gg}, ' (', num2str(gg), ')'];
% end

[~, i_id] = getgdx(gdx_filename, 'i'); % Goods and sectors
i = i_id{1};
clear i_id;


%% ================================================================== %%
% market clearance check
[Y, Y_id] = getgdx(gdx_filename, 'Y'); % [g]x[r] = [16]x[34]
[vom, vom_id] = getgdx(gdx_filename, 'vom'); % [g]x[r] = [16]x[34]
[vdm, vdm_id] = getgdx(gdx_filename, 'vdm'); % [i]x[rs] = [16]x[34]
[vxmd, vxmd_id] = getgdx(gdx_filename, 'vxmd'); % [i]x[rs]x[sr] = [13]x[34]x[34]
%[vst, vst_id] = getgdx(gdx_filename, 'vst'); % [i]x[rs] = [1]x[23]; only TRN sector
[vtwr, vtwr_id] = getgdx(gdx_filename, 'vtwr'); % [i]x[rs]x[sr] = [8]x[33]x[31]; only AGR/COL/CRU/GAS/OMN/OIL/EIS/MAN

% test COL in BJ region --> OK
vom_COL_BJ = vom(strcmp('COL',vom_id{1}),strcmp('BJ',vom_id{2})); % 1x1
vdm_COL_BJ = vdm(strcmp('COL',vdm_id{1}),strcmp('BJ',vdm_id{2})); % 1x1
vxmd_COL_BJ = vxmd(strcmp('COL',vxmd_id{1}),strcmp('BJ',vxmd_id{2}),:); %1x1x34; exports from BJ to other regions
vtwr_COL_BJ = vtwr(strcmp('COL',vtwr_id{1}),:,strcmp('BJ',vtwr_id{2})); %1x33; why the "direction" is different than vxmd
chk_COL = vom_COL_BJ - (vdm_COL_BJ + sum(vxmd_COL_BJ) + sum(vtwr_COL_BJ)) % include vtwr!!!

% test CRU in BJ region
vom_CRU_BJ = vom(strcmp('CRU',vom_id{1}),strcmp('BJ',vom_id{2}));
vdm_CRU_BJ = vdm(strcmp('CRU',vdm_id{1}),strcmp('BJ',vdm_id{2}));
vxmd_CRU_BJ = vxmd(strcmp('CRU',vxmd_id{1}),strcmp('BJ',vxmd_id{2}),:);
vtwr_CRU_BJ = vtwr(strcmp('CRU',vtwr_id{1}),:,strcmp('BJ',vtwr_id{2}));
chk_CRU = vom_CRU_BJ - (vdm_CRU_BJ + sum(vxmd_CRU_BJ))

% test OIL in BJ region
vom_OIL_BJ = vom(strcmp('OIL',vom_id{1}),strcmp('BJ',vom_id{2}));
vdm_OIL_BJ = vdm(strcmp('OIL',vdm_id{1}),strcmp('BJ',vdm_id{2}));
vxmd_OIL_BJ = vxmd(strcmp('OIL',vxmd_id{1}),strcmp('BJ',vxmd_id{2}),:);
vtwr_OIL_BJ = vtwr(strcmp('OIL',vtwr_id{1}),:,strcmp('BJ',vtwr_id{2}));
chk_OIL = vom_OIL_BJ - (vdm_OIL_BJ + sum(vxmd_OIL_BJ))


%% ================================================================== %%
[dom, dom_id] = getgdx(gdx_filename, 'dom'); % [g]x[rs] = [16]x[34]

[ddm, ddm_id] = getgdx(gdx_filename, 'ddm'); % [i]x[rs] = [13]x[34]

[dxmd, dxmd_id] = getgdx(gdx_filename, 'dxmd'); % [i]x[rs]x[sr] = [13]x[34]x[34]

sort_vtwr = zeros(13,34,34); %[i]x[rs]x[sr]
for in = 1:13
    i_target = i{in};
    i_find = strcmp(i_target,vtwr_id{1});
    for rn1 = 1:34
        rs1_target = rs{rn1};
        rs1_find = strcmp(rs1_target,vtwr_id{2});
        for rn2 = 1:34
            rs2_target = rs{rn2};
            rs2_find = strcmp(rs2_target,vtwr_id{3});
            if any(i_find>0) && any(rs1_find>0) && any(rs2_find>0)
                sort_vtwr(in,rn1,rn2) = vtwr(i_find,rs1_find,rs2_find);
            end
        end
    end
end
vtwr = sort_vtwr;

ratio = vtwr./vxmd; % [13x34x34]; use the ratio between vxmd and vtwr (because the substitution is zero) to derive dtwr
ratio(isnan(ratio)) = 0;
dtwr = vxmd.*ratio;
chk_dtwr = dtwr - vtwr; % matched
dtwr_id = vtwr_id;


%% ================================================================== %%
[evd, evd_id] = getgdx(gdx_filename, 'evd_now'); % [i]x[g]x[rs] = [5]x[15]x[24]
[evt, evt_id] = getgdx(gdx_filename, 'evt_now'); % [i]x[rs]x[sr] = [5]x[34]x[34]
[e_prod, eprod_id] = getgdx(gdx_filename, 'e_prod_now'); % [pe]x[rs] = [3]x[33]; COL/CRU/GAS

sector_filter = {'COL', 'CRU', 'GAS'};

tmp_evd = zeros(length(sector_filter), length(rs)); %[3]x[34]
for in = 1:length(sector_filter)
    i_target = sector_filter(in);
    i_find = strcmp(i_target,evd_id{1});
    for rn = 1:length(rs)
        rs_target = rs{rn};
        rs_find = strcmp(rs_target,evd_id{3});
        if any(i_find>0) && any(rs_find>0)
            tmp_evd(in, rn) = sum(evd(i_find,:,rs_find));
        end
    end
end
evd = tmp_evd;
evd_id{1} = sector_filter;
evd_id{2} = rs;

tmp_eprod = zeros(length(sector_filter), length(rs)); %[3]x[34]
for in = 1:length(sector_filter)
    i_target = sector_filter(in);
    i_find = strcmp(i_target,eprod_id{1});
    for rn = 1:length(rs)
        rs_target = rs{rn};
        rs_find = strcmp(rs_target,eprod_id{2});
        if any(i_find>0) && any(rs_find>0)
            tmp_eprod(in,rn) = e_prod(i_find,rs_find);
        end
    end
end
e_prod = tmp_eprod;
eprod_id{1} = sector_filter;
eprod_id{2} = rs;


%% ================================================================== %%
color_code = rainbow_color(length(rs));
for in = 1%:length(sector_filter)
sector = sector_filter{in}

dom_COL_r = dom(strcmp(sector,dom_id{1}),:);
ddm_COL_r = ddm(strcmp(sector,ddm_id{1}),:);
dxmd_COL_r = squeeze(dxmd(strcmp(sector,dxmd_id{1}),:,:));
dtwr_COL_r = squeeze(dtwr(strcmp(sector,dtwr_id{1}),:,:));

%% ==============================
figure(1); clf; hold on;
tmp = [ddm_COL_r', dxmd_COL_r]; % exports
hb = bar(1:34, tmp, 0.5, 'stacked');
set(hb(1), 'facec', [0.6 0.6 0.6], 'edge', 'none');
for rn = 1:length(rs), set(hb(rn+1), 'facec', color_code(rn,:), 'edge', 'none'); end

bar(1:34, dom_COL_r, 0.5, 'edge', 'k', 'facec', 'none');

xlim([0.4 34.6]);
set(gca, 'fontsize', 7);
set(gca, 'xtick', 1:34);
set(gca, 'xticklabel', rs);
set(gcf, 'units', 'inch', 'pos', [0.7292    5.5938    9.35    2.45]);
set(gca, 'pos', [0.0602    0.1023    0.8439    0.8144]);
box off
set(gca, 'tickdir', 'out');
title([sector, ': vom, vxmd and vdm'], 'fontsize', 10, 'fontweight', 'bold');
ylabel('Value (Billions 2007 USD)')
legend(fliplr(hb), fliplr({'dfm', rs{:}}));
set(legend, 'fontsize', 5, 'units', 'pixels', 'pos', [827.0000    4.3333   70.0000  229]);

if (in==1 && current_yr==2030), ylim([0 180]); end

if in==1
    text(34.75, ddm_COL_r(in,34)/2, 'vfm (Local Production)', 'color', [0.6 0.6 0.6], 'fontsize', 7, 'rotation', 90, 'horizontalalignment', 'center');
    axx=[1 1]*34.45;
    axy=[0 ddm_COL_r(in,34)];
    [arrowx,arrowy] = dsxy2figxy(gca, axx, axy);
    annotation('doublearrow',arrowx,arrowy,'headwidth',4,'headlength',4, 'color', [0.6 0.6 0.6]);
    
    text(34.75, ddm_COL_r(in,34) + sum(dxmd_COL_r(34,:))/2, 'vxmd (Exports)', 'color', [0.6 0.6 0.6], 'fontsize', 7, 'rotation', 90, 'horizontalalignment', 'center');
    axx=[1 1]*34.45;
    axy=[0 sum(dxmd_COL_r(34,:))]+ddm_COL_r(in,34);
    [arrowx,arrowy] = dsxy2figxy(gca, axx, axy);
    annotation('doublearrow',arrowx,arrowy,'headwidth',4,'headlength',4, 'color', [0.6 0.6 0.6]);
    
    text(33.3, dom_COL_r(34)*0.70, 'vom (Sectoral Supply)', 'color', [0.6 0.6 0.6], 'fontsize', 7, 'rotation', 90, 'horizontalalignment', 'center');
    axx=[1 1]*33.55;
    axy=[0 dom_COL_r(34)];
    [arrowx,arrowy] = dsxy2figxy(gca, axx, axy);
    annotation('doublearrow',arrowx,arrowy,'headwidth',4,'headlength',4, 'color', [0.6 0.6 0.6]);
    
    if current_yr == 2007
        axx=[1 1]*4;
        axy=[0 sum(dxmd_COL_r(4,1:3))]+ddm_COL_r(4);
        [arrowx,arrowy] = dsxy2figxy(gca, axx, axy);
        annotation('doublearrow',arrowx,arrowy,'headwidth',4,'headlength',4, 'color', 'w');
    end
end

% export_tiff([sector, '_ddm_exports']);

%% ==============================
% zoom-in
if in>1
figure(2); clf; hold on;
tmp = [ddm_COL_r', dxmd_COL_r]; % exports
hb = bar(1:34, tmp, 0.5, 'stacked');
set(hb(1), 'facec', [0.6 0.6 0.6], 'edge', 'none');
for rn = 1:length(rs), set(hb(rn+1), 'facec', color_code(rn,:), 'edge', 'none'); end

xlim([0.5 30.5]);
if (in==2 && current_yr==2007), ylim([0 25]); end
if (in==3 && current_yr==2007), ylim([0 5]); end
if (in==2 && current_yr==2030), ylim([0 100]); set(gca, 'ytick', 0:25:100); end
if (in==3 && current_yr==2030), ylim([0 20]); end

set(gca, 'fontsize', 7);
set(gca, 'tickdir', 'out');
box off;
set(gca, 'xtick', 1:34);
set(gca, 'xticklabel', rs);
set(gca, 'xcolor', [0.4 0.4 0.4], 'ycolor', [0.4 0.4 0.4], 'fontangle', 'italic', 'tickdir', 'out');
set(gcf, 'units', 'inch', 'pos', [2.5313    4.7917    6.8    1.3]);
set(gca, 'pos', [0.0513    0.1704    0.9351    0.7646]);
if (in==2 && current_yr==2007), text(0.85, 22.5, 'Zoom-In on Chinese Provinces:', 'fontsize', 8, 'color', [0.3 0.3 0.3], 'fontangle', 'italic'); end
if (in==3 && current_yr==2007), text(0.85, 4.5, 'Zoom-In on Chinese Provinces:', 'fontsize', 8, 'color', [0.3 0.3 0.3], 'fontangle', 'italic'); end
if (in==2 && current_yr==2030), text(0.85, 90, 'Zoom-In on Chinese Provinces:', 'fontsize', 8, 'color', [0.3 0.3 0.3], 'fontangle', 'italic'); end
if (in==3 && current_yr==2030), text(0.85, 18, 'Zoom-In on Chinese Provinces:', 'fontsize', 8, 'color', [0.3 0.3 0.3], 'fontangle', 'italic'); end

set(gca, 'color', [0.9 0.9 0.9]);
set(gcf, 'color', [0.9 0.9 0.9]);
% export_fig([sector, '_ddm_exports_zoomin']);
end

% %% ==============================
% figure(3); clf;
% tmp = [ddm_COL_r;
%        dxmd_COL_r]; % imports
% hb = bar(1:34, tmp', 'stacked');
% set(hb(1), 'facec', [0.6 0.6 0.6], 'edge', 'none');
% for rn = 1:length(rs)
%     set(hb(rn+1), 'facec', color_code(rn,:), 'edge', 'none');
%     if rn<=3
%         set(hb(rn+1), 'edge', 'k');
%     end
% end
% xlim([0.4 34.6]);
% ylim([0 y_lim(in)]);
% set(gca, 'fontsize', 7);
% set(gca, 'xtick', 1:34);
% set(gca, 'xticklabel', rs);
% set(gcf, 'units', 'inch', 'pos', [0.7292    1.4583    9.35    3.15]);
% set(gca, 'pos', [0.0602    0.1023    0.8574    0.8144]);
% box off
% set(gca, 'tickdir', 'out');
% title([sector, ' (Domestic Production + Exports)'], 'fontsize', 10, 'fontweight', 'bold');
% ylabel('Value (Billions 2007 USD)')
% legend(fliplr(hb), fliplr({'DDM', rs{:}}));
% set(legend, 'fontsize', 6, 'units', 'pixels', 'pos', [827.0000    4.3333   70.0000  294.6667]);
% 
% % export_tiff([sector, '_ddm_imports']);


%% ================================================================== %%
tmp_evd_rs = zeros(34,1);
tmp_export_rs = zeros(34, 34);
tmp_import_rs = zeros(34, 34);
tmp_eprod_rs = zeros(34,1);

%% ==============================
i_target = sector_filter(in);
for rn = 1:length(rs)
    rs_target = rs{rn};
    
    % ==============================
    % evd
    i_find = strcmp(i_target,evd_id{1});
    rs_find = strcmp(rs_target,evd_id{3});
    evd_extract = sum(evd(i_find,rs_find)); %[1x1]
    
    % ==============================
    % evt
    i_find = strcmp(i_target,evt_id{1});
    rs_find = strcmp(rs_target,evt_id{3});
    evt_imports = evt(i_find,:,rs_find); %[1]x[rs]
    
    rs_find = strcmp(rs_target,evt_id{2});
    evt_exports = squeeze(evt(i_find,rs_find,:))'; %[1]x[rs]
    
    % ==============================
    % e_prod
    i_find = strcmp(i_target, eprod_id{1});
    rs_find = strcmp(rs_target, eprod_id{2});
    eprod_extract = e_prod(i_find, rs_find);
    
    % ==============================
    % stack up data
    tmp_evd_rs(rn) = evd_extract;
    tmp_export_rs(rn,:) = evt_exports;
    tmp_import_rs(rn,:) = evt_imports;
    tmp_eprod_rs(rn,:) = eprod_extract;
end

%% ==============================
color_code = rainbow_color(length(rs));
figure(4); clf; hold on;
hb_ex = bar(1:34, -tmp_export_rs, 'stack'); for rn = 1:length(rs), set(hb_ex(rn), 'facec', color_code(rn,:), 'edge', 'none'); end
hb_im = bar(1:34, tmp_import_rs, 'stack'); for rn = 1:length(rs), set(hb_im(rn), 'facec', color_code(rn,:), 'edge', 'none'); end
xlim([0.4 34.6]);
set(gca, 'fontsize', 7);
set(gca, 'tickdir', 'out');
box off;
set(gca, 'xtick', 1:34);
set(gca, 'xticklabel', rs);
ylabel('Volume of Energy Trade (mtce)');
title(sector, 'fontsize', 10, 'fontweight', 'bold');
set(gcf, 'units', 'inch', 'pos', [0.7292    5.5938    9.35    3.15]);
set(gca, 'pos', [0.0602    0.1023    0.8574    0.8144]);

legend(fliplr(hb_ex), fliplr(rs));
set(legend, 'fontsize', 6, 'units', 'pixels', 'pos', [827.0000    4.3333   70.0000  294.6667]);

if in==1
    if current_yr==2007
        text(1, 50, 'Imports', 'color', [0.6 0.6 0.6], 'fontsize', 8, 'rotation', 90);
        text(1, -50, 'Exports', 'color', [0.6 0.6 0.6], 'fontsize', 8, 'rotation', 90, 'horizontalalignment', 'right');
    end
    if current_yr==2030
        text(1, 200, 'Imports', 'color', [0.6 0.6 0.6], 'fontsize', 8, 'rotation', 90);
        text(1, -200, 'Exports', 'color', [0.6 0.6 0.6], 'fontsize', 8, 'rotation', 90, 'horizontalalignment', 'right');
    end
    
    axx=[1 1]*4;
    axy=[0 -sum(tmp_export_rs(4,1:3))];
    [arrowx,arrowy] = dsxy2figxy(gca, axx, axy);
    annotation('doublearrow',arrowx,arrowy,'headwidth',4,'headlength',4, 'color', 'w');
end
if in==2
    text(1, 150, 'Imports', 'color', [0.6 0.6 0.6], 'fontsize', 8, 'rotation', 90);
    text(1, -150, 'Exports', 'color', [0.6 0.6 0.6], 'fontsize', 8, 'rotation', 90, 'horizontalalignment', 'right');
end
if in==3
    text(1, 50, 'Imports', 'color', [0.6 0.6 0.6], 'fontsize', 8, 'rotation', 90);
    text(1, -50, 'Exports', 'color', [0.6 0.6 0.6], 'fontsize', 8, 'rotation', 90, 'horizontalalignment', 'right');
end

% export_tiff(['evt_', sector]);

%% ==============================
if in > 1 % zoom-in on Chinese Provinces:
figure(5); clf; hold on;
hb_ex = bar(1:34, -tmp_export_rs, 'stack'); for rn = 1:length(rs), set(hb_ex(rn), 'facec', color_code(rn,:), 'edge', 'none'); end
hb_im = bar(1:34, tmp_import_rs, 'stack'); for rn = 1:length(rs), set(hb_im(rn), 'facec', color_code(rn,:), 'edge', 'none'); end
xlim([0.5 30.5]);
% if in==2, ylim([-60 60]); set(gca, 'ytick', -60:30:60); end
% if in==3, ylim([-12 12]); set(gca, 'ytick', -12:6:12); end
% if in==2, ylim([-60 60]); set(gca, 'ytick', -60:30:60); end
if in==2, ylim([-200 300]); set(gca, 'ytick', -200:100:300); end
if in==3, ylim([-40 40]); set(gca, 'ytick', -40:20:40); end
set(gca, 'fontsize', 7);
set(gca, 'tickdir', 'out');
box off;
set(gca, 'xtick', 1:34);
set(gca, 'xticklabel', rs);
set(gca, 'xcolor', [0.4 0.4 0.4], 'ycolor', [0.4 0.4 0.4], 'fontangle', 'italic', 'tickdir', 'out');
set(gcf, 'units', 'inch', 'pos', [2.5313    4.7917    6.8    1.3]);
set(gca, 'pos', [0.0513    0.1704    0.9351    0.7646]);
% if in==2, text(0.85, 49, 'Zoom-In on Chinese Provinces:', 'fontsize', 8, 'color', [0.3 0.3 0.3], 'fontangle', 'italic'); end
% if in==3, text(0.85, 10, 'Zoom-In on Chinese Provinces:', 'fontsize', 8, 'color', [0.3 0.3 0.3], 'fontangle', 'italic'); end
if in==2, text(0.85, 270, 'Zoom-In on Chinese Provinces:', 'fontsize', 8, 'color', [0.3 0.3 0.3], 'fontangle', 'italic'); end
if in==3, text(0.85, 35, 'Zoom-In on Chinese Provinces:', 'fontsize', 8, 'color', [0.3 0.3 0.3], 'fontangle', 'italic'); end
set(gca, 'color', [0.9 0.9 0.9]);
set(gcf, 'color', [0.9 0.9 0.9]);
% export_fig(['evt_zoomin_', sector_name]);
end

%% ==============================
tmp_combind = [tmp_eprod_rs, sum(tmp_import_rs-tmp_export_rs,2)];

figure(6); clf;
b1 = bar(1:34, tmp_eprod_rs, 0.8, 'edge', 'none', 'facec', [0.7 0.7 0.7]); hold on;

net_exports = (sum(tmp_import_rs-tmp_export_rs,2)<=0);
tmp = tmp_combind;
tmp(net_exports,:) = 0;
b2 = bar(1:34, tmp, 0.7, 'stack', 'edge', 'none'); hold on;
set(b2(1), 'facec', [0.7 0.7 0.7], 'edge', 'none');
set(b2(2), 'facec', [1 0.6 0.6], 'edge', 'none');

net_imports = (sum(tmp_import_rs-tmp_export_rs,2)>0);
tmp = tmp_combind;
tmp(net_imports,:) = 0;
b3 = bar(1:34, tmp, 0.6, 'stack', 'edge', 'none'); hold on;
set(b3(1), 'facec', [0.7 0.7 0.7], 'edge', 'none');
set(b3(2), 'facec', [0.8 0 0], 'edge', 'none');

b4 = bar(1:34, tmp_evd_rs, 0.45, 'edge', 'none', 'facec', [0.3 0.65 1], 'linewidth', 1); hold on;
xlim([0.4 34.6]);
set(gca, 'fontsize', 7);
set(gca, 'layer', 'top');
set(gca, 'xtick', 1:34);
set(gca, 'xticklabel', rs);
set(gcf, 'units', 'inch', 'pos', [0.7292     1.4583    9.35    3.15]);
set(gca, 'pos', [0.0602    0.1023    0.8574    0.8144]);
box off
set(gca, 'tickdir', 'out');
ylabel('Energy Volumn (mtce)');
title(sector, 'fontsize', 10, 'fontweight', 'bold');

legend([b1, b2(2), b3(2), b4], 'Local Production', 'Imports', 'Exports', 'Demand', 2);

if (in == 1 && current_yr==2030), text(34/2, 2350, 'Net Energy Porduction ~ Energy Demand (not exact match; only roughly close)', 'fontsize', 8, 'horizontalalignment', 'center'); end

% export_fig(['net_egy_', sector], '-w');

%% ==============================
if in>1 % zoom-in on Chinese Provinces:
figure(7); clf; hold on;
b1 = bar(1:34, tmp_eprod_rs, 0.8, 'edge', 'none', 'facec', [0.7 0.7 0.7]);

net_exports = (sum(tmp_import_rs-tmp_export_rs,2)<=0);
tmp = tmp_combind;
tmp(net_exports,:) = 0;
b2 = bar(1:34, tmp, 0.7, 'stack', 'edge', 'none'); hold on;
set(b2(1), 'facec', [0.7 0.7 0.7], 'edge', 'none');
set(b2(2), 'facec', [1 0.6 0.6], 'edge', 'none');

net_imports = (sum(tmp_import_rs-tmp_export_rs,2)>0);
tmp = tmp_combind;
tmp(net_imports,:) = 0;
b3 = bar(1:34, tmp, 0.6, 'stack', 'edge', 'none'); hold on;
set(b3(1), 'facec', [0.7 0.7 0.7], 'edge', 'none');
set(b3(2), 'facec', [0.8 0 0], 'edge', 'none');

b4 = bar(1:34, tmp_evd_rs, 0.45, 'edge', 'none', 'facec', [0.3 0.65 1]); hold on;
xlim([0.5 30.5]);
% if in==2, ylim([0 80]); end
% if in==3, ylim([0 20]); end
if in==2, ylim([0 300]); end
if in==3, ylim([0 100]); set(gca, 'ytick', 0:25:100); end
set(gca, 'fontsize', 7);
set(gca, 'xtick', 1:34);
set(gca, 'xticklabel', rs);
set(gcf, 'units', 'inch', 'pos', [0.7292    1.85    9.35    2.75]);
set(gca, 'pos', [0.0602    0.1023    0.8574    0.8144]);
box off
set(gca, 'xcolor', [0.4 0.4 0.4], 'ycolor', [0.4 0.4 0.4], 'fontangle', 'italic', 'tickdir', 'out');
set(gcf, 'units', 'inch', 'pos', [2.4688    1.4271    6.8    1.3]);
set(gca, 'pos', [0.0513    0.1704    0.9351    0.7646]);
% if in==2, text(0.85, 70, 'Zoom-In on Chinese Provinces:', 'fontsize', 8, 'color', [0.3 0.3 0.3], 'fontangle', 'italic'); end
% if in==3, text(0.85, 18, 'Zoom-In on Chinese Provinces:', 'fontsize', 8, 'color', [0.3 0.3 0.3], 'fontangle', 'italic'); end
if in==2, text(0.85, 275, 'Zoom-In on Chinese Provinces:', 'fontsize', 8, 'color', [0.3 0.3 0.3], 'fontangle', 'italic'); end
if in==3, text(0.85, 90, 'Zoom-In on Chinese Provinces:', 'fontsize', 8, 'color', [0.3 0.3 0.3], 'fontangle', 'italic'); end
set(gca, 'color', [0.9 0.9 0.9]);
set(gcf, 'color', [0.9 0.9 0.9]);
% export_fig(['net_egy_zoomin', sector_name]);
end

end % end of for-loop sector_filter


%% ================================================================== %%
%% CHN total evd
total_evd_CHN = sum(evd(:,1:30),2);
figure(8); clf;
bar(total_evd_CHN, 0.7, 'facec', [0.3 0.65 1], 'edge', 'none');
set(gca, 'fontsize', 7);
set(gca, 'tickdir', 'out');
set(gca, 'xtick', 1:3, 'xticklabel', evd_id{1});
xlim([0.4 3.55]);
box off;
ylabel('Total Energy Demand in China (mtce)');
set(gcf, 'units', 'inch', 'pos', [10.2500    1.4583    1.22    3.15]);
set(gca, 'pos', [0.0555    0.1023    0.5770    0.8144]);
set(gca, 'yaxislocation', 'right');
set(gca, 'xcolor', 'b', 'ycolor', 'b');
set(gca, 'color', [0.9 0.9 0.9]);
set(gcf, 'color', [0.9 0.9 0.9]);
% export_fig evd_CHN

