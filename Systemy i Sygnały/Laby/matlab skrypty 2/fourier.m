% Fourier 2 
% Sygnał prostokątny
%-----|     |----
%     |     |
%     |     |
%     -------
%    T/4   3/4T
%        T/2     T

x = [ones(1,50) zeros(1,100) ones(1,50)];

F0 = 1/2;
k = 1:9
Fk = sinc(k/2)/2;
Fk = [F0 Fk]
SzeregFouriera(x,Fk);