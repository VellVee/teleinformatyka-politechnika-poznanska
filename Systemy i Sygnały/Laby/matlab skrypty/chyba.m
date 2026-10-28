clc
clear()

licznik = [2];
mianownik = [1 3];

w= logspace(-2, 2, 10000);
s = 1i*w;

H = (polyval(licznik,s))./(polyval(mianownik,s));

M = abs(H);
O = angle(H);

subplot(2,1,1)
loglog(w,M);
title amplitduowa

subplot(2,1,2)
semilogx(w,O)
title fazowa
