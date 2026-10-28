clear()
clc

%sygnal sinwT od 0 do T/2 i zero do T
%SzeregFouriera(przebieg, Fk)

k = 2 : 20;
syg = [sin(0 : 0.01 : pi) zeros(1, 314)];


%Fk = 1/T calka od 0 do T/2 z (sin 2pi/T * t e^-jkwt) dt   w = 2pi/2
  


Fn = (1 + (-1).^k)./(2*pi - 2*pi*(k.^2));
Fo = 1/pi;
F1 = -i/4;
Fk = [Fo F1 Fn];

SzeregFouriera(syg, Fk)


