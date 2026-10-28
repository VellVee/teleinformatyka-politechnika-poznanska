clear()
clc

%zeszyt z panda - tlumacznie?

w = logspace(-2, 2, 10000);

s=i*w;

l=[2];
m=[1 3];

H = (polyval(l,s)./polyval(m,s));

Mw=abs(H);
FIw=angle(H);

subplot(2,1,1)
loglog(w, Mw);

subplot(2,1,2)
semilogx(w, FIw); 



