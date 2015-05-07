clear all
close all
clc
format compact

yr = [2007, 2010:5:2030];

r = {'BJ','TJ','HE','SX','SD','NM','LN','JL','HL','SH','JS','ZJ','AH','FJ','HA','HB','HN','JX','SC','CQ','SN','GS','QH','NX','XJ','GD','GX','YN','GZ','HI'};


%% population
gdx_filename = 'result_hhsplit.gdx';
pop2007 = getgdx(gdx_filename, 'pop2007');
[pop, pop_id] = getgdx(gdx_filename, 'pop_wm');

pop_no_mig = zeros(30,3,6);
pop_no_mig(:,[1,2,3],1) = pop2007(:,[2,3,1]) * 10000;
pop_no_mig(:,1:2,2:end) = pop(:,:,1:end-1);
pop_no_mig(:,3,2:end) = sum(pop_no_mig(:,1:2,2:end),2);

for t = 1:6
    a = pop_no_mig(:,:,t);
    disp('tt');
end

% ==============================
gdx_filename = 'result_hhsplit_w_mig.gdx';
[pop_wm, pop_wm_id] = getgdx(gdx_filename, 'pop_wm');

pop_w_mig = zeros(30,3,6);
pop_w_mig(:,[1,2,3],1) = pop2007(:,[2,3,1]) * 10000;
pop_w_mig(:,1:2,2:end) = pop_wm(:,:,1:end-1);
pop_w_mig(:,3,2:end) = sum(pop_w_mig(:,1:2,2:end),2);

for t = 1:6
    b = pop_w_mig(:,:,t);
    disp(num2str(t));
end
