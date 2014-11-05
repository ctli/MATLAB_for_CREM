clear all
close all
clc

fileID = fopen('reas_map.csv');
mapping_header = textscan(fileID, '%s%s%s%s', 1, 'delimiter',',');
mapping_content = textscan(fileID, '%s%s%s%s', 'delimiter',',');

mapping_set = mapping_content{1};
mapping_crem = mapping_content{3}; % no transportation disaggregation
mapping_reas = mapping_content{4};

tmp = strcmp(mapping_set, 'r');
mapping_province = {mapping_crem(tmp), mapping_reas(tmp)};
tmp = strcmp(mapping_set, 'i');
mapping_sector = {mapping_crem(tmp), mapping_reas(tmp)};
tmp = strcmp(mapping_set, 'e');
mapping_fuel = {mapping_crem(tmp), mapping_reas(tmp)};

fe = {'COL', 'CRU', 'GAS', 'OIL', 'OTF'};
ii = {'AGR', 'COL', 'CRU', 'GAS', 'OMN', 'OIL', 'EIS', 'MAN', 'ELE', 'WTR', 'CON', 'TRN', 'SER', 'c', 'OTF'};


% ==========
urban = {'BC_', 'CO_', 'NH3', 'NMV', 'NOx', 'OC_', 'PM10', 'PM25', 'SO2'};
folder_name = urban{2}
cd(folder_name);

file_list = dir('*.txt');
file_count = length(file_list);

BC_ourb = zeros(length(file_list), length(ii)); %[r]x[i]
BC_curb = zeros(length(file_list), length(ii),length(fe)); %[r]x[i]x[fe]
for f = 1:length(file_count)
    province_name = char(mapping_province{2}(f));
file_name = ['REASv2.1_', folder_name, '_2007_CHN_', province_name, '.txt'];
industry = importdata(file_name, ' ', 31);
industry_data = industry.data(1:16);
row = industry.textdata(32:47);

for m = 1:length(industry_data)-1
    sector_reas = row{m};
    [~,id] = ismember(sector_reas, mapping_sector{2});
    
    sector_crem = mapping_sector{1}(id);
    [~,id_row] = ismember(sector_crem, ii);
    
    BC_ourb(f, id_row) = BC_ourb(f, id_row) + industry_data(m);
end

% ==========
combustion = importdata(file_name, ' ', 7);
combustion_data = combustion.data; %[18]x[20]
row = combustion.textdata(8:end); % fuel type, [18]x[1]

fid = fopen(file_name,'r');
header = textscan(fid, '%s', 34);
column = header{1}(15:end); % sector, [20]x[1]
province_name = header{1}(9);

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

        BC_curb(f, id_row, id_col) = BC_curb(f, id_row, id_col) + combustion_data(m,n);
    end
end
end


%%
% industry2 = importdata('REASv2.1_BC__2007_CHN_ANHU.txt', ' ', 39);
% 
% measrows = 32;
% meascols = 21;
% a = fscanf(fid, '%f', [measrows, meascols]);


%% 
% fuel_type_list = { % [18x1]
% 'HARD_COAL'; ...
% 'BROWN_COAL'; ...
% 'DERIVED_COAL'; ...
% 'NATURAL_GAS'; ...
% 'COKE_OVEN_GAS'; ...
% 'OTHER_GAS'; ...
% 'MOTOR_GASOLINE'; ...
% 'KEROSENE'; ...
% 'OTHER_LF'; ...
% 'DIESEL_OIL'; ...
% 'CRUDE_OIL'; ...
% 'HEAVY_FUEL_OIL'; ...
% 'OTHER_HF'; ...
% 'FUELWOOD'; ...
% 'CROP_RESIDUE'; ...
% 'ANIMAL_WASTE'; ...
% 'OTHERS'; ...
% 'SUB_TOTAL'; ...
% };
% 
% sector_list = { % [20x1]
% 'POWER_PLANTS'; ...
% 'ENERGY'; ...
% 'IRON_STEEL'; ...
% 'CHEM_PETRCHEM'; ...
% 'NON_FERR_MET'; ...
% 'NON_MET_MINE'; ...
% 'OTHERS'; ...
% 'ROAD_CARS'; ...
% 'ROAD_BUSES'; ...
% 'ROAD_L_TRUCKS'; ...
% 'ROAD_H_TRUCKS'; ...
% 'ROAD_MC'; ...
% 'ROAD_OTHERS'; ...
% 'DOM_NAVI'; ...
% 'RAILWAY_ETC'; ...
% 'RESIDENT'; ...
% 'COMM_PUB'; ...
% 'AGR_FORE_FISH'; ...
% 'OTHERS'; ...
% 'SUB_TOTAL'; ...
% };
