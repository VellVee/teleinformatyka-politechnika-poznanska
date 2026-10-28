clc
clear

x = -100 : 0.02 : 100;
z = log(x+11)+1;
y = x+z;

plot(x, y)