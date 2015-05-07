clear
close all
clc
format compact

r = {'BJ','TJ','HE','SX','SD','NM','LN','JL','HL','SH','JS','ZJ','AH','FJ','HA','HB','HN','JX','SC','CQ','SN','GS','QH','NX','XJ','GD','GX','YN','GZ','HI'};
yr = [2007,2010,2015,2020,2025,2030];

disp('========================');
disp('No Policy:')
gdx_filename = 'result_default.gdx';

[Y, Y_id] = getgdx(gdx_filename, 'Y'); % [18x34]
Y_ele = Y(strcmp('ELE', Y_id{1}),1:30);

eleprod = getgdx(gdx_filename, 'eleprod'); % [30x1]

ELE = (Y_ele').*eleprod; % mtce

ELE_TWh = sum(ELE)/0.12 % TWh




%%
disp('========================');
disp('CE:');
gdx_filename = 'result_cint_n_3_ex.gdx';

[Y, Y_id] = getgdx(gdx_filename, 'Y'); % [18x34]
Y_ele = Y(strcmp('ELE', Y_id{1}),1:30);

eleprod = getgdx(gdx_filename, 'eleprod'); % [30x1]

ELE = (Y_ele').*eleprod;

ELE_TWh = sum(ELE)/0.12

disp('========================');
disp('AE:');
gdx_filename = 'result_cint_n_4_ex.gdx';

[Y, Y_id] = getgdx(gdx_filename, 'Y'); % [18x34]
Y_ele = Y(strcmp('ELE', Y_id{1}),1:30);

eleprod = getgdx(gdx_filename, 'eleprod'); % [30x1]

ELE = (Y_ele').*eleprod;

ELE_TWh = sum(ELE)/0.12


