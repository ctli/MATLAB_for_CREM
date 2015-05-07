%% read parameters from gdx, and then write them into csv files

clear all
close all
clc
format compact

r = {'BJ','TJ','HE','SX','SD','NM','LN','JL','HL','SH','JS','ZJ','AH','FJ','HA','HB','HN','JX','SC','CQ','SN','GS','QH','NX','XJ','GD','GX','YN','GZ','HI'};
g = {'AGR', 'COL', 'GAS', 'CRU', 'OIL', 'ELE', 'EIS', 'MAN', 'OMN', 'CON', 'TRN', 'WTR', 'SER', 'c', 'OTF'};
yr = [2007,2010,2015,2020,2025,2030];

% gdx_filename = 'result_urban_exo.gdx'; folder_name = 'no_policy';
% gdx_filename = 'result_egyint_n.gdx'; folder_name = 'egy_int';
% gdx_filename = 'result_ccap_r.gdx'; folder_name = 'co2_cap';

% gdx_filename = 'result_cint_n_2.gdx'; folder_name = 'cint_n_2';
% gdx_filename = 'result_cint_n_25.gdx'; folder_name = 'cint_n_25';
% gdx_filename = 'result_cint_n_3.gdx'; folder_name = 'cint_n_3';
% gdx_filename = 'result_cint_n_35.gdx'; folder_name = 'cint_n_35';
% gdx_filename = 'result_cint_n_4.gdx'; folder_name = 'cint_n_4';
% gdx_filename = 'result_cint_n_45.gdx'; folder_name = 'cint_n_45';
% gdx_filename = 'result_cint_n_5.gdx'; folder_name = 'cint_n_5';
% gdx_filename = 'result_cint_n_55.gdx'; folder_name = 'cint_n_55';
gdx_filename = 'result_cint_n_6.gdx'; folder_name = 'cint_n_6';

mkdir(folder_name);

%% Urban emission
[urban, urban_id] = getgdx(gdx_filename, 'urban'); % [urb]x[rs]x[g]x[t] = [9]x[30]x[8]x[6]
urban = urban*1e6;

header_string = 'r,AGR,COL,GAS,CRU,OIL,ELE,EIS,MAN,OMN,CON,TRN,WTR,SER,c,OTF';

cd(folder_name);
for i = 1:length(urban_id{1})
urb = squeeze(urban(strcmp(urban_id{1}(i), urban_id{1}),:,:,:)); % [30]x[8]x[6]

for t = 1:6
    urb_t = urb(:,:,t); % [30x8]
    [~,id_g] = ismember(urban_id{3},g);
    urb_print = zeros(length(r), length(g));
    urb_print(:,id_g) = urb_t;
    
    file_name = [char(urban_id{1}(i)), '_' num2str(yr(t)), '.csv'];
    fid = fopen(file_name, 'w');
    fprintf(fid,'%s\r\n',header_string); % print the header
    fclose(fid);
    
    fid = fopen(file_name, 'a'); % print the content (values)
    for rn = 1:length(r)
        fprintf(fid,'%s,', r{rn});
        dlmwrite(file_name, urb_print(rn,:),'-append','delimiter',',','roffset', 0,'coffset',0);
    end
    fclose(fid);
    
end % loop t
end
cd ..;


%% GDP
[report, report_id] = getgdx(gdx_filename, 'report'); % [*]x[yr]x[rs]
GDP = squeeze(report(strcmp('GDP', report_id{1}), :, 1:30));

cd(folder_name);
for t = 1:6
    GDP_t = GDP(t,:);
    
    file_name = ['GDP_', num2str(yr(t)), '.csv'];
    fid = fopen(file_name, 'w');
    for rn = 1:length(r)
        fprintf(fid,'%s,%f\r\n', r{rn}, GDP_t(rn));
    end
    fclose(fid);
end
cd ..;


%% CO2
co2_chk3 = getgdx(gdx_filename, 'co2_chk3'); % [r]x[t] = [30]x[6]

cd(folder_name);
for t = 1:6
    CO2_t = co2_chk3(:,t);
    
    file_name = ['CO2_', num2str(yr(t)), '.csv'];
    fid = fopen(file_name, 'w');
    for rn = 1:length(r)
        fprintf(fid,'%s,%f\r\n', r{rn}, CO2_t(rn));
    end
    fclose(fid);
end

fid = fopen('units.txt', 'a');
fprintf(fid, 'CO2: mega ton\r\n');
fclose(fid);
cd ..;
