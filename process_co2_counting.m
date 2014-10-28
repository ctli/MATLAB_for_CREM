clear all
close all
clc
format compact

r = {'BJ','TJ','HE','SX','SD','NM','LN','JL','HL','SH','JS','ZJ','AH','FJ','HA','HB','HN','JX','SC','CQ','SN','GS','QH','NX','XJ','GD','GX','YN','GZ','HI'};


%% CO2
figure(1); clf; hold on; box on;

yr = [2007,2010,2015,2020,2025,2030];
gdx_filename = 'result_urban_exo.gdx';

% ==========
% raw
co2_chk = getgdx(gdx_filename, 'co2_chk');
co2_chk_n = sum(co2_chk);
plot(yr, co2_chk_n/1e3, 'xb', 'markersize', 7, 'linewidth', 1);

% ==========
% Exclude ele_trade (i.e. excluding ele export)
% This calculation is basically meanless, because total ele export adds up almost to zero
% (i.e. even the ELEemisfactor(r) is very wrong, it will still cancel out itself)
co2_chk2 = getgdx(gdx_filename, 'co2_chk2');
co2_chk2_n = sum(co2_chk2);
plot(yr, co2_chk2_n/1e3, 'sr', 'markersize', 7, 'linewidth', 1);

% ==========
% Exclude ele production, then add it back when its used
% This calculation has noticable discrepancy, 
% becuase we multiplied ele use in the current period with out-dated ELEemisfactor(r) in the previous period
co2_chk3 = getgdx(gdx_filename, 'co2_chk3');
co2_chk3_n = sum(co2_chk3);
plot(yr, co2_chk3_n/1e3, 'dg', 'markersize', 7, 'linewidth', 1);

% ==========
legend('chk(raw)', 'chk2 (exclude ele export)', 'chk3 (exclude ele prod)', 2)
ylim([0 20]);

discrepancy = co2_chk3_n./co2_chk2_n;
for yn = 1:length(yr)
    text(yr(yn), co2_chk3_n(yn)/1e3-0.75, num2str(discrepancy(yn), '%2.2f'), 'fontsize', 8, 'color', 'g', 'horizontalalignment', 'center');
end