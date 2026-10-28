clear()
clc

%zeszyt z panda - obliczenia

w = logspace(-2, 2, 10000);

Mw = sqrt((36.+(4.*w))./((w.^2)+9));

FIw = atan(-w./3);

subplot(2,1,1)
loglog(w, Mw);

subplot(2,1,2)
semilogx(w, FIw); 



