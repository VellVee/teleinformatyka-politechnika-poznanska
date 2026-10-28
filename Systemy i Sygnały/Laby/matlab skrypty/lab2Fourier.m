clear()
clc

%SzeregFouriera(przebieg, Fk)

syg = [ones(1, 100) zeros(1, 200) ones(1, 100)];
k = 1 : 20;

% Fk = 1/T calka od -T/4 do T/4 1*e^(-jk(2pi/T) *t) dt  = sin (kpi/2) /k*pi

Fn = (sin(k*pi/2)./(k*pi));
Fo = 0.5;
Fk = [Fo Fn];

SzeregFouriera(syg, Fk)






