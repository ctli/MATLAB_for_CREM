clear
close all

yr = 2010:5:2030;

a = (0.98).^(0:5:20); % use this one!!!

b = (0.9).^(0:1:4);

figure(10); clf;
plot(yr, a, 'x-', yr, b, 'o-');
set(gca, 'xtick', 2010:5:2030);
set(gca, 'yminorgrid', 'on');
grid on;

legend('a (use this)', 'b');
title('2% Reduction (Yearly Compound)');

xlabel('Time (Year)');
ylabel('Carbon Intensity');


pctg = 1-(b(2:end)./b(1:end-1));
for i = 2:5, text(yr(i)-0.75, b(i)-0.005, [num2str(-pctg(i-1)*100, '%2.0f'), '%'], 'fontsize', 8, 'horizontalalignment', 'center', 'color', [0.2 0.5 1]); end
