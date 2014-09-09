clear all
close all
clc

%% ==============================
yr = 2010:5:2100;
t = 1:length(yr);

alpha = [-0.03 %SO2
         -0.01];%NOx
ef = exp(alpha*(t-1)); % emission factor

lo_bnd = [0.85 %SO2
          0.6];%NOx

alpha = [-3.75 %SO2
         -0.3];%NOx

lo_bnd = repmat(lo_bnd,1,length(t));
ef2 = exp(alpha*(t-1)).*(1-lo_bnd)+lo_bnd; % emission factor

figure(1); clf;
plot(yr, ef, 'mx:', yr, ef2, 'cx:');
ylim([0 1]);
grid on;

%% Emissions in CREM
yr = 2010:5:2030;

gdx_filename = 'merge_urban_exo.gdx';

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
curb_SO2_ele = curb_SO2_ele/(SO2_ele*0.358)

curb_SO2_agr = curb(:,strcmp('SO2', curb_id{2}),1,strcmp('AGR', curb_id{4}),1);
curb_SO2_agr = curb_SO2_agr/(SO2_agr*0.89)

figure(1); hold on;
plot(yr, curb_SO2_ele(2:end), 's-', yr, curb_SO2_agr(2:end), 'rx-');


%%
curb_NOX_ele = curb(:,strcmp('NOX', curb_id{2}),1,strcmp('ELE', curb_id{4}),1);
curb_NOX_ele = curb_NOX_ele/(NOX_ele*0.8656)

figure(1); hold on;
plot(yr, curb_NOX_ele(2:end), 'o-');


%%
curb_BC_ele = curb(:,strcmp('BC', curb_id{2}),1,strcmp('ELE', curb_id{4}),1);
curb_BC_ele = curb_BC_ele/BC_ele

curb_VOC_ele = curb(:,strcmp('VOC', curb_id{2}),1,strcmp('ELE', curb_id{4}),1);
curb_VOC_ele = curb_VOC_ele/VOC_ele

figure(1); hold on;
plot(yr, curb_BC_ele(2:end), '^-');
plot(yr, curb_VOC_ele(2:end), 'v-');


