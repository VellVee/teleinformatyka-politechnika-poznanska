clc
clear()

x1 = [-4 : 0.05 : 5]
x2 = [-1 : 0.05 : 7]

y1 = [1 0 0 0 0 0 0 0 0 0 -1 -3 2];
y2 = [-2 -3 2];

yy1 = polyval(y1, x1);
yy2 = polyval(y2, x2);

% subplot(1, 2, 1)

% plot(x1, yy1);
% title tytul-1

% subplot(1, 2, 2)
% plot(x2, yy2);
% title tytul-2

ax = [1 0 0 0 0 0 0 0 0 0 -1 -3 2];
bx = [-2 -3 2];

ex = conv(ax, bx)





