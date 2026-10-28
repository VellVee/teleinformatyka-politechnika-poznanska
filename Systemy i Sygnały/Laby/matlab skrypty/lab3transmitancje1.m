clear()
clc

%zeszyt z panda - obliczenia

w = logspace(-2, 2, 10000);
Mw = (sqrt(25.*(w.^4) + (w.^2)) ./ (25*(w.^2)+1));
FIw = atan(1./(5.*w));

subplot(2,1,1)
loglog(w, Mw);

subplot(2,1,2)
semilogx(w, FIw); 



