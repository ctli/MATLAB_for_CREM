clear all
close all
clc

fileID = fopen('reas_map.csv');
mapping_header = textscan(fileID, '%s%s%s%s', 1, 'delimiter',',');
mapping_content = textscan(fileID, '%s%s%s%s', 'delimiter',',');

mapping_set = mapping_content{1};
mapping_crem = mapping_content{2}; % no transportation disaggregation
mapping_reas = mapping_content{4};

tmp = strcmp(mapping_set, 'r');
mapping_province = {mapping_crem(tmp), mapping_reas(tmp)};
r = {'BJ','TJ','HE','SX','SD','NM','LN','JL','HL','SH','JS','ZJ','AH','FJ','HA','HB','HN','JX','SC','CQ','SN','GS','QH','NX','XJ','GD','GX','YN','GZ','HI'};

tmp = strcmp(mapping_set, 'i');
mapping_sector = {mapping_crem(tmp), mapping_reas(tmp)};
tmp = strcmp(mapping_set, 'e');
mapping_fuel = {mapping_crem(tmp), mapping_reas(tmp)};

fe = {'COL', 'CRU', 'GAS', 'OIL', 'OTF'};
ii = unique(mapping_sector{1}); % note that the ORDER is slightly different!!
% ii = {'AGR', 'COL', 'CRU', 'GAS', 'OMN', 'OIL', 'EIS', 'MAN', 'ELE', 'WTR', 'CON', 'TRN', 'SER', 'c', 'OTF'};


%% cannot process NH3, NMV, NOx yet; their industry process emissions have multiple segments
urban = {'BC_', 'CO_', 'NH3', 'NMV', 'NOx', 'OC_', 'PM2.5', 'PM10_', 'SO2'};

file_id_ouptut = fopen('reas_output.dat','w');
fprintf(file_id_ouptut,'%6s\n', 'parameter reasEmissions_new /');

tic;
for u = [1,2,6]
    switch u
        case 1
            folder_name = urban{1} % BC
            urb = 'BC';
        case 2
            folder_name = urban{2} % CO
            urb = 'CO';
        case 6
            folder_name = urban{6} % OC
            urb = 'OC';
    end
    cd(folder_name);
    
    inconsistent_log = []; % check if total sum matches REAS
    for r_count = 1:4%length(r)
        province_name_crem = r{r_count}
        [~, id] = ismember(province_name_crem, mapping_province{1});
        province_name_reas = char(mapping_province{2}(id));
        file_name = ['REASv2.1_', folder_name, '_2007_CHN_', province_name_reas, '.txt'];
        
        % ==========
        % Combustion emissions
        file_id = fopen(file_name,'r');
        all_content = textscan(file_id, '%s','delimiter', '\n');
        
        header_line = all_content{1}(7);
        header = strsplit(char(header_line));
        column = header(3:end-1)'; % sector
        
        combustion = importdata(file_name, ' ', 7);
        combustion_data = combustion.data; % [18]x[20]
        row = combustion.textdata(8:end); % fuel type
        
        if ~all(ismember(column(1:end-1), mapping_sector{2}))
            disp('unclassified sector (combustion: column)');
            break;
        end
        if ~all(ismember(row(1:end-1), mapping_fuel{2}))
            disp('unclassified sector (combustion: column)');
            break;
        end
        
        curb = zeros(length(mapping_province{2}), length(ii),length(fe)); %[r]x[i]x[fe]
        for m = 1:size(combustion_data,1)-1 % row; skip last row of sub-total
            for n = 1:size(combustion_data,2)-1 % column; skip last column of sub-total
                fuel_reas = row{m};
                [~,id] = ismember(fuel_reas, mapping_fuel{2});
                fuel_crem = mapping_fuel{1}(id);
                [~,id_col] = ismember(fuel_crem, fe);
                
                sector_reas = column{n};
                [~,id] = ismember(sector_reas, mapping_sector{2});
                sector_crem = mapping_sector{1}(id);
                [~,id_row] = ismember(sector_crem, ii);
                
                curb(r_count, id_row, id_col) = curb(r_count, id_row, id_col) + combustion_data(m,n);
            end
        end
        
        % ==========
        % industrial process emissions
        industry = importdata(file_name, ' ', 31);
        industry_data = industry.data(1:16);
        row = industry.textdata(32:47);
        
        if ~all(ismember(row(1:end-1), mapping_sector{2}))
            disp('unclassified sector (process: row)');
            break;
        end
        
        ourb = zeros(length(mapping_province{2}), length(ii)); %[r]x[i]
        for m = 1:length(industry_data)-1
            sector_reas = row{m};
            [~,id] = ismember(sector_reas, mapping_sector{2});
            
            sector_crem = mapping_sector{1}(id);
            [~,id_row] = ismember(sector_crem, ii);
            
            ourb(r_count, id_row) = ourb(r_count, id_row) + industry_data(m);
        end
        
        % ==========
        % total sum
        total_sum = importdata(file_name, ' ', 50);
        total_data = total_sum.data;
        
        total_emission = sum(curb(:)) + sum(ourb(:));
        
        inconsistency = (total_emission-total_data)/total_data;
        if inconsistency > 0.03
            disp('inconsistent!');
            inconsistent_log = [inconsistent_log, r_count];
            disp('==');
        end
        
        for i_count = 1:length(ii)
            sector_name = ii{i_count};
            for fe_count = 1:length(fe)
                fe_name = fe{fe_count};
                if curb(r_count,i_count,fe_count)>0
                    header_string = [urb, '.', province_name_crem, '.', sector_name, '.' fe_name];
                    fprintf(file_id_ouptut,'%6s  %E\n',header_string,curb(r_count,i_count,fe_count));
                end
            end
            if ourb(r_count,i_count)>0
                header_string = [urb, '.', province_name_crem, '.', sector_name, '.' 'process'];
                fprintf(file_id_ouptut,'%6s  %E\n',header_string,curb(r_count,i_count));
            end
        end
        
    end
    cd ..
    
end
fprintf(file_id_ouptut,'%6s\n', '/;');
fclose(file_id_ouptut);


