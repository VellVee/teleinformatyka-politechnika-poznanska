clc
clear()

x = [-7 : 0.1 : 5];

y = ((x.^12) + (6.*(x.^6)) - 12);

%plot(x, y)


xx = [1 0 0 0 0 0 6 0 0 0 0 0 -12];
yy = polyval(xx, x)

%plot(x, yy)

subplot(2, 1, 1)
plot(x, y)
title eloTytul

subplot(2, 1, 2)
plot(x, yy)