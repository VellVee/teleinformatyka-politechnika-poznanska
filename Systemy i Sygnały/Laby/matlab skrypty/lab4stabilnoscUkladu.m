clear()
clc

w = logspace(-2, 2, 1000);
s = i.*w;

l1 = [1 6 8];
m1 = [1 2 3];
x1 = polyval(l1, s)./polyval(m1, s);
Mw1 = abs(x1);
Ow1 = angle(x1);

l2 = [1 -2 -8];
m2 = [1 2 3];
x2 = polyval(l2, s)./polyval(m2, s);
Mw2 = abs(x2);
Ow2 = angle(x2);

l3 = [1 -6 8];
m3 = [1 2 3];
x3 =polyval(l3, s)./polyval(m3, s);
Mw3 = abs(x3);
Ow3 = angle(x3);

l4 = [1 2 -8];
m4 = [1 2 3];
x4 = polyval(l4, s)./polyval(m4, s);
Mw4 = abs(x4);
Ow4 = angle(x4);

subplot(1, 2, 1)
loglog(w, Mw1);
hold on;
loglog(w, Mw2);
hold on;
loglog(w, Mw3);
hold on;
loglog(w, Mw4);

subplot(1, 2, 2)
semilogx(w, Ow1);
hold on;
semilogx(w, Ow2);
hold on;
semilogx(w, Ow3);
hold on;
semilogx(w, Ow4);
hold on;

%te same charakterystyki amplitudowe
%rozne charakterystyki fazowe ----- system minimalno fazowy
% nie ma zer w prawej otwartej polplaszczyznie
% ma w lewej zamkietej - wszystkie
% zamknieta - wliczamy Oy, otwarta - nie wliczamy OY

figure(1)
Odpowiedz(l1, m1);
figure(2)
Odpowiedz(l2, m2);
figure(3)
Odpowiedz(l3, m3);
figure(4)
Odpowiedz(l4, m4);

%tylko pierwszy jest minimalnie fazowy

