% Read TMY csv 
% NREL Typical Meteorological Year/National Solar Radiation Data Base
% http://rredc.nrel.gov/solar/old_data/nsrdb/1991-2005/tmy3/
%
% The data is not sorted in year, but already sorted in month, date, and hr,
% because its a processed data
% So, it is already good to go
% --


% ===================================================================== %%
clear all
clc
close all
format compact

% ===================================================================== %%
interested_location = 'OR';

file_list = dir('csv/*.csv');
cd('csv');
file_count = length(file_list);

% ===================================================================== %%
tic;
k = 0;
for j = 1:file_count
    disp(['j = ', num2str(j)]);
    
    file_name = file_list(j).name;

    % Exam state name, not read in whole file
    fid = fopen(file_name);
    s = fgetl(fid);
    [site.number, site.name, site.state, site.timezone, site.lat, site.lon, site.elev] = strread(s, '%s%s%s%f%f%f%f', 1, 'delimiter', ',');
    
    if strcmp(site.state, interested_location) && (site.lon < -120)  % California, then read in the whole file
        k = k+1
        data = importdata(file_name, ',', 2);
        % The header is in the 2nd line
        % So "importdata" will start recognize data from the 3rd line

        var_length = length(data.textdata) - 2;
        % 1st line: site info, 2nd line: header
        % Ture data start from 3rd line!!

        month = single(zeros(var_length,1));
        day = single(zeros(var_length,1));
        year = single(zeros(var_length,1));
        hr = single(zeros(var_length,1));
        ETR = single(zeros(var_length,1));
        ETRN = single(zeros(var_length,1));
        GHI = single(zeros(var_length,1));
        direct = single(zeros(var_length,1));
        diffuse = single(zeros(var_length,1));
        cloud = single(zeros(var_length,1));
        temperature = single(zeros(var_length,1));
        pressure = single(zeros(var_length,1));
        wdir = single(zeros(var_length,1));
        wsp = single(zeros(var_length,1));
        albedo = single(zeros(var_length,1));

        for i = 1:var_length
            time_stamp = data.textdata{i+2,1};
            month(i) = str2double(time_stamp(1:2));
            day(i) = str2double(time_stamp(4:5));
            year(i) = str2double(time_stamp(7:10));

            hr_stamp = data.textdata{i+2,2};
            hr(i) = str2double(hr_stamp(1:2));

            ETR(i) = str2double(data.textdata{i+2,3});
            ETRN(i) = str2double(data.textdata{i+2,4});
            GHI(i) = str2double(data.textdata{i+2,5});
            direct(i) = str2double(data.textdata{i+2,8});
            diffuse(i) = str2double(data.textdata{i+2,11});
            cloud(i) = str2double(data.textdata{i+2,26});
            temperature(i) = str2double(data.textdata{i+2,32});
            pressure(i) = str2double(data.textdata{i+2,41});
            wdir(i) = str2double(data.textdata{i+2,44});
            wsp(i) = str2double(data.textdata{i+2,47});
            albedo(i) = str2double(data.textdata{i+2,62});
        end
        % Data sorting
        table = [year, month, day, hr, ETR, ETRN, GHI, direct, diffuse, cloud, temperature, wdir, wsp, albedo];
        %table = sort(table, 2);
        %isequal(table, table2)
        
        save_file_name = [interested_location, num2str(k),'.mat'];
        save(save_file_name, 'table', 'year', 'month', 'day', 'hr', 'ETR', 'GHI', 'cloud', 'temperature', 'wdir', 'wsp', 'albedo');
        disp(' ');
    end
    fclose(fid);

    toc;
    disp('====================================');
    
end

cd ..
