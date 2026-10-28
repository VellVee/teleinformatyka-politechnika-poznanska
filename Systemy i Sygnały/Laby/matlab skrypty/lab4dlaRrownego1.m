clear()
clc

wielomian = [4 1 1];        %obliczenia w zeszycie
bieguny = roots(wielomian); %bieguny (miejsca zerowe mianownika)

t = 0 : 0.01 : 50;

B = [1];
A = [4 1 1];
Odpowiedz(B,A); %oscylacje malejace

figure(2)

B = [1];
A = [2 0.5 1];
Odpowiedz(B,A); %oscylacje malejace ale z wieksza czestotliwoscia oscylacji

figure(3)
B = [1];
A = [2 0 1];
Odpowiedz(B,A); %oscylator (generator sygnalu sinusoidalnego)\

figure(4)
B = [1];
A = [2 -1 1];
Odpowiedz(B,A);

figure(5)
B = [1];
A = [2 -5 1];
Odpowiedz(B,A);

