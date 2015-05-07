% source EIA website (http://www.eia.gov/cfapps/ipdbproject/IEDIndex3.cfm?tid=93&pid=44&aid=33)

clear
clc
close all

data = [
%population (million), CO2 intensity (ton CO2/kUSD)
1336.71801	1.93722 %China
1189.17291	1.30508 %India
1049.47859	0.90665 %Africa
608.85225	0.27229 %Europe
311.59192	0.4123  %USA
288.49886	1.92046
246.06516	1.12107
197.5955	0.42157
187.34272	1.03222
165.82257	0.48305
158.57054	0.71431
142.52559	1.81573
127.46954	0.26249
113.72423	0.46608
101.83394	0.60931
90.54939	1.71724
88.58876	0.32915
82.07964	1.5588
81.47183	0.25935
78.78555	0.48713
77.89122	2.47036
71.71287	0.27961
66.72015	1.36483
65.29609	0.16721
62.69836	0.20777
61.0168	0.23496
53.9998	0.67742
49.00403	1.58518
48.75466	0.61688
46.75478	0.26804
45.59086	0.33987
45.13471	3.14279
44.72554	0.36813
43.69745	0.47715
41.9435	0.53959
41.76973	0.7179
38.44159	0.77543
36.65429	1.01136
34.03059	0.44804
32.56022	0.2247
31.96836	0.55036
30.39957	1.32587
29.75757	0.68911
29.39188	0.35793
29.24894	0.35208
28.72861	1.09538
28.1286	5.31298
27.63574	0.9455
26.1317	1.43916
24.45749	2.58137
24.13349	0.86078
24.10786	0.54714
23.17427	0.6659
22.94886	0.36448
22.51775	1.81689
21.90455	0.78519
21.76671	0.49689
21.50416	0.39985
21.42095	0.3487
21.28391	0.40203
19.71129	0.39
17.54473	0.52877
17.30451	2.53782
16.91502	0.53092
16.75146	0.231
16.65373	0.34431
15.87925	0.23405
15.80175	0.28899
15.0324	0.10151
15.00734	0.76195
14.70172	0.49586
13.82446	0.37373
13.4246	0.2499
12.6438	0.58436
12.0843	2.24932
11.37043	0.19353
11.08733	0.42787
10.76031	0.27614
10.76014	0.38716
10.75895	0.03784
10.62919	0.51326
10.60101	0.38412
10.43148	0.34359
10.21619	0.19289
10.19021	0.65208
10.11868	1.1519
9.97606	0.47064
9.95665	0.41871
9.92564	0.46133
9.71993	0.44546
9.66151	1.521
9.39728	1.1378
9.32503	0.96143
9.08873	0.13054
8.21728	0.20634
8.14356	0.67121
7.8501	0.10016
7.6272	0.86358
7.47305	0.43454
7.31056	1.54797
7.12251	0.4163
7.09364	1.6593
6.77199	0.57942
6.50827	1.03942
6.47721	0.33904
6.45906	0.39243
6.18759	0.48231
6.07177	0.33876
5.93948	0.42023
5.76716	1.41235
5.6663	0.83261
5.52989	0.17363
5.47704	0.56545
5.45078	2.62039
5.36367	0.67423
5.25925	0.24284
5.24679	1.14769
5.14866	1.02768
4.9975	1.82245
4.95003	0.18696
4.69185	0.13185
4.67098	0.18553
4.58587	0.68001
4.57656	0.25951
4.4838	0.37812
4.29035	0.30972
4.24393	1.08
4.22571	0.42148
4.1431	0.68297
3.88236	1.82009
3.78676	0.7362
3.70669	0.35764
3.69412	1.7857
3.53555	0.52263
3.46046	0.68424
3.30854	0.33923
3.28163	0.68602
3.13332	2.35236
3.02796	1.23959
2.99467	0.3816
2.96798	1.85475
2.86838	0.85684
2.59563	1.00755
2.20471	0.4993
2.14759	0.35697
2.07733	1.20607
2.0654	0.36597
2.00009	0.40593
1.92489	0.27977
1.84926	0.67827
1.82563	1.55598
1.79786	0.66373
1.59668	1.15838
1.57667	0.6157
1.37042	0.34538
1.30372	0.59948
1.28296	0.37302
1.22751	2.75934
1.2147	1.65099
1.12049	0.45901
1.11542	0.57839
];

%%
figure(100); clf;
plot(data(:,1), data(:,2), 'o', 'markersize', 4, 'markerf', [0 0.5647 0.7412]);
xlabel('Population (Million)');
ylabel('CO2 Intensity (ton CO2/kUSD)');
grid on;
defaultratio;

hold on;
China = 1;
India = 2;
Africa = 3;
Europe = 4;
USA = 5;

text(data(China,1), data(China,2)+0.25, 'China', 'fontsize', 9, 'horizontalalignment', 'center')
text(data(India,1), data(India,2)+0.25, 'India', 'fontsize', 9, 'horizontalalignment', 'center')
text(data(USA,1), data(USA,2)+0.25, 'US', 'fontsize', 9, 'horizontalalignment', 'center')
text(data(Africa,1), data(Africa,2)+0.25, 'Africa', 'fontsize', 9, 'horizontalalignment', 'center')
text(data(Europe,1), data(Europe,2)+0.25, 'Europe', 'fontsize', 9, 'horizontalalignment', 'center')

export_fig CO2int_vs_population;

