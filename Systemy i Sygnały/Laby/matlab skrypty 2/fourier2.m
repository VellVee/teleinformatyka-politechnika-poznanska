% Fourier

x = [[0:0.01:0.99] [1:-0.01:0.01]]
F0 = 1/2;
k = [1:9]
Fk = (-sinc(k/2)/2).^2;
Fk = [F0 Fk]
SzeregFouriera(x,Fk);     