clear()
clc

%sygnal trojkatny okres od 0 do T
%SzeregFouriera(przebieg, Fk)

syg = [linspace(0,1, 500) linspace(1, 0, 500)];
k = 1 : 9;

%Fk = 1/T (calka od 0 to T/2 z 2/T e^-jkwt dt +
% calka od T/2 do 0 z -2/T +2 e&-jkwt dt



Fn = ((-1).^k-1)./(pi.^2*k.^2);
Fo = 0.5;
Fk = [Fo Fn];

SzeregFouriera(syg, Fk)
%SzeregFouriera(syg, abs(Fk))     %Fk = |Fk|*e^j(FIk) //za malo danych
%SzeregFouriera(syg, angle(Fk))   %                   //za malo danych


