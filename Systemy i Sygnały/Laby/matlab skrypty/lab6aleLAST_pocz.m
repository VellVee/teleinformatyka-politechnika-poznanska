clc
clear

x = 0:19;
y = sin(x*pi/10);

subplot(2,1,1)
showDiscr(x,y)
wynik=ifft(y);
%wynik=fftshift(wynik)

subplot(2,1,2)
showDiscr(x,abs(wynik))