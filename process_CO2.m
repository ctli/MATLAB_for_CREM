clear all
close all
clc
format compact

yr = [2007, 2010:5:2030];

r = {'BJ','TJ','HE','SX','SD','NM','LN','JL','HL','SH','JS','ZJ','AH','FJ','HA','HB','HN','JX','SC','CQ','SN','GS','QH','NX','XJ','GD','GX','YN','GZ','HI'};


%% CO2
gdx_filename = 'result_urban_exo.gdx';
[report2, report2_id] = getgdx(gdx_filename, 'report2');
% report2_id{1} %Wchange/welfare/CO2emis
% report2_id{2} %2007/2010/2015/2020/2025/2030
% report2_id{3} %AGR/COL/...
% report2_id{4} %r+s+CHN
co2 = squeeze(report2(strcmp('CO2emis', report2_id{1}),:,1:13,1:30));
co2_r = squeeze(sum(co2,2));
co2_n = squeeze(sum(co2_r,2));

figure(1); clf;
h1 = plot(yr, co2_n/1e3, '^-', 'markersize', 7, 'color', [0.5 0.5 0.5], 'linewidth', 1);
set(gca, 'fontsize', 10);
ylabel('CO2 (Billion tons)', 'Fontsize', 12, 'fontweight', 'bold');
set(gcf, 'unit', 'inch', 'pos', [8.2188    0.9688    4.0000    3.0000]);
ylim([0 20]);
set(gca, 'yminortick', 'on');
set(gca, 'ytick', 0:5:20);
% for yn = 3:length(yr)
%     text(yr(yn), co2_n(yn)/1e3+0.5, num2str(co2_n(yn)/1e3, '%2.1f'), 'fontsize', 8, 'horizontalalignment', 'center');
% end

% ==============================
gdx_filename = 'result_egyint_n.gdx';
[report2, report2_id] = getgdx(gdx_filename, 'report2');
co2 = squeeze(report2(strcmp('CO2emis', report2_id{1}),:,1:13,1:30));
co2_r = squeeze(sum(co2,2));
co2_n = squeeze(sum(co2_r,2));
figure(1); hold on;
h2 = plot(yr, co2_n/1e3, 'o-', 'markersize', 7, 'color', [0 0.8 0], 'linewidth', 1);

% ==============================
gdx_filename = 'result_ccap_n_old.gdx';
[report2, report2_id] = getgdx(gdx_filename, 'report2');
co2 = squeeze(report2(strcmp('CO2emis', report2_id{1}),:,1:13,1:30));
co2_r = squeeze(sum(co2,2));
co2_n = squeeze(sum(co2_r,2));
figure(1); hold on;
h3 = plot(yr, co2_n/1e3, 'x-', 'markersize', 7, 'color', 'r', 'linewidth', 1);

% ==============================
co2_n_old = co2_n(end);

gdx_filename = 'result_ccap_n.gdx';
[report2, report2_id] = getgdx(gdx_filename, 'report2');
co2 = squeeze(report2(strcmp('CO2emis', report2_id{1}),:,1:13,1:30));
co2_r = squeeze(sum(co2,2));
co2_n = squeeze(sum(co2_r,2));
figure(1); hold on;
h4 = plot(yr, co2_n/1e3, 'x-', 'markersize', 7, 'color', 'm', 'linewidth', 1);
% text(2030, co2_n(end)/1e3-0.9, [' (', num2str((co2_n(end)-co2_n_old)/co2_n_old*100, '%0.1f'), '%)'], 'fontsize', 8, 'horizontalalignment', 'center', 'color', 'm');

ax1 = gca;
legend(ax1, [h1 h2], 'No Policy', 'Action Plan', 2);
set(legend, 'units', 'pixels');
set(legend, 'pos', [57.6667  224.0000  109.3333   36.3333]);
legendObj = findobj(gcf,'tag','legend');
childs = get(legendObj,'children');
n_childs = length(childs);
all_markers = childs(1:3:n_childs);
all_lines = childs(2:3:n_childs);
all_text = childs(3:3:n_childs);
dx = 0.07;
for it = 1:length(all_lines)
    xcor = get(all_lines(it),'xdata');
    set(all_lines(it),'xdata',[xcor(1) xcor(2)-dx]);
end
for it = 1:length(all_markers)
    pos = get(all_markers(it),'xdata');
    set(all_markers(it),'xdata',pos-dx/2);
end
for it = 1:length(all_text)
    pos = get(all_text(it),'Position');
    set(all_text(it),'Position',[pos(1)-dx pos(2)]);
end

ax2 = axes('position',get(gca,'position'), 'visible','off');
legend(ax2, [h3, h4], 'CO2 Cap & Trade (Equiv. to Action Plan)', 'CO2 Cap & Trade (More Stringent)', 4);
set(legend, 'units', 'pixels');
set(legend, 'pos', [57.6667   37.1667  275.0000   36.3333]);
legendObj = findobj(gcf,'tag','legend');
childs = get(legendObj(1),'children');
n_childs = length(childs);
all_markers = childs(1:3:n_childs);
all_lines = childs(2:3:n_childs);
all_text = childs(3:3:n_childs);
dx = 0.04;
for it = 1:length(all_lines)
    xcor = get(all_lines(it),'xdata');
    set(all_lines(it),'xdata',[xcor(1) xcor(2)-dx]);
end
for it = 1:length(all_markers)
    pos = get(all_markers(it),'xdata');
    set(all_markers(it),'xdata',pos-dx/2);
end
for it = 1:length(all_text)
    pos = get(all_text(it),'Position');
    set(all_text(it),'Position',[pos(1)-dx pos(2)]);
end

% Gray grid lines;.
old_order = get(ax1,'children');
for i = 5:5:20
    plot(ax1, [2005 2030], [1 1]*i, 'color', [0.9 0.9 0.9]);
end
for j = 2010:5:2030
    plot(ax1, [1 1]*j, [0 20], 'color', [0.9 0.9 0.9]);
end
new_order = get(ax1,'children');
z = ismember(new_order,old_order);
manipulate_order = [new_order(z);new_order(~z)];
set(ax1,'children',manipulate_order);
set(ax1, 'layer', 'top');

% export_fig CO2 -painters;


%% GDP
gdx_filename = 'result_urban_exo.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
figure(2); clf; hold on; box on;
h1  = plot(yr, GDP_n, '^-', 'markersize', 7, 'color', [0.5 0.5 0.5], 'linewidth', 1);
set(gca, 'fontsize', 10);
ylabel('GDP (Billion US dollor in 2007 value)', 'Fontsize', 12, 'fontweight', 'bold');
set(gcf, 'unit', 'inch', 'pos', [12.4167    0.9688    4.0000    3.0000]);

% ==============================
gdx_filename = 'result_egyint_n.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
h2 = plot(yr, GDP_n, 'o-', 'markersize', 7, 'color', [0 0.8 0], 'linewidth', 1);

% ==============================
gdx_filename = 'result_ccap_n_old.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
h3 = plot(yr, GDP_n, 'x-', 'markersize', 7, 'color', 'r', 'linewidth', 1);

% ==============================
GDP_n_old = GDP_n(end);

gdx_filename = 'result_ccap_n.gdx';
[report, report_id] = getgdx(gdx_filename, 'report');
GDP = squeeze(report(strcmp('GDP', report_id{1}),:,1:30));
GDP_n = sum(GDP,2);
h4= plot(yr, GDP_n, 'x-', 'markersize', 7, 'color', 'm', 'linewidth', 1);
% text(2030, GDP_n(end)-850, [' (', num2str((GDP_n(end)-GDP_n_old)/GDP_n_old*100, '%0.1f'), '%)'], 'fontsize', 8, 'horizontalalignment', 'center', 'color', 'm');
ylim([0 16000]);

ax1 = gca;
legend(ax1, [h1 h2], 'No Policy', 'Action Plan', 2);
set(legend, 'units', 'pixels');
set(legend, 'pos', [75.6667  224.0000  109.3333   36.3333]);
legendObj = findobj(gcf,'tag','legend');
childs = get(legendObj,'children');
n_childs = length(childs);
all_markers = childs(1:3:n_childs);
all_lines = childs(2:3:n_childs);
all_text = childs(3:3:n_childs);
dx = 0.07;
for it = 1:length(all_lines)
    xcor = get(all_lines(it),'xdata');
    set(all_lines(it),'xdata',[xcor(1) xcor(2)-dx]);
end
for it = 1:length(all_markers)
    pos = get(all_markers(it),'xdata');
    set(all_markers(it),'xdata',pos-dx/2);
end
for it = 1:length(all_text)
    pos = get(all_text(it),'Position');
    set(all_text(it),'Position',[pos(1)-dx pos(2)]);
end

ax2 = axes('position',get(gca,'position'), 'visible','off');
legend(ax2, [h3, h4], 'CO2 Cap & Trade (Equiv. to Action Plan)', 'CO2 Cap & Trade (More Stringent)', 4);
set(legend, 'units', 'pixels');
set(legend, 'pos', [73.0000   37.1667  285.0000   36.3333]);
legendObj = findobj(gcf,'tag','legend');
childs = get(legendObj(1),'children');
n_childs = length(childs);
all_markers = childs(1:3:n_childs);
all_lines = childs(2:3:n_childs);
all_text = childs(3:3:n_childs);
dx = 0.04;
for it = 1:length(all_lines)
    xcor = get(all_lines(it),'xdata');
    set(all_lines(it),'xdata',[xcor(1) xcor(2)-dx]);
end
for it = 1:length(all_markers)
    pos = get(all_markers(it),'xdata');
    set(all_markers(it),'xdata',pos-dx/2);
end
for it = 1:length(all_text)
    pos = get(all_text(it),'Position');
    set(all_text(it),'Position',[pos(1)-dx pos(2)]);
end

% Gray grid lines:
old_order = get(ax1,'children');
for i = 2000:2000:14000
    plot(ax1, [2005 2030], [1 1]*i, 'color', [0.9 0.9 0.9]);
end
for j = 2010:5:2030
    plot(ax1, [1 1]*j, [0 16000], 'color', [0.9 0.9 0.9]);
end
new_order = get(ax1,'children');
z = ismember(new_order,old_order);
manipulate_order = [new_order(z);new_order(~z)];
set(ax1,'children',manipulate_order);
set(ax1, 'layer', 'top');

% export_fig GDP -painters;

