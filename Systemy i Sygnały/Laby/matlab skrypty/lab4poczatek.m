clear()
clc

wielomian = [4 5 1];        %obliczenia w zeszycie
bieguny = roots(wielomian); %bieguny (miejsca zerowe mianownika)

t = 0 : 0.01 : 50;

B = [1];
A = [4 5 1];
Odpowiedz(B,A);

figure(2)

ht = (-1/3).*exp(-t) + (1/3).*exp((-1/4).*t)


plot(t, ht)
