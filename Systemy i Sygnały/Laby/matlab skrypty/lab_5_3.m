clc
clear()
% w zeszycie obliczenia

kp = 100;   % jest blad i oscylacje
ki = 200;   % nie ma bledu
kd = 10;    % ucina oscylacje

%mianownik to licznik i odrowtnie

lHs = [kd kp ki];
mHs = [0.5 (6+kd) (kp+10.01) ki];

lHe = [0.5 6 10.01 0];
mHe = [0.5 (6+kd) (kp+10.01) ki];

polMian = polyval(mHe, 0);
polLicz = polyval(lHe, 0);
lim = polLicz/polMian;

figure(1)
skokowa(lHs, mHs)

figure(2)
skokowa(lHe, mHe)
