clear all
close all
clc

fid = fopen('REASv2.1_BC__2007_CHN_ANHU_test.txt','r');

% combustion = importdata('REASv2.1_BC__2007_CHN_ANHU.txt', ' ', 7);
% header = textscan(fid, '%s', 22);
% column = header{1}(3:end); % sector, [20]x[1]
% row = combustion.textdata(8:end); % fuel type, [18]x[1]
% combustion_data = combustion.data; %[18]x[20]

industry = importdata('REASv2.1_BC__2007_CHN_ANHU.txt', ' ', 31);

