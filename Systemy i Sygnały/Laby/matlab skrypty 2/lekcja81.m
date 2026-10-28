x = [0:31];
%y = sin(2*pi*x/32);
%y = sin(2*pi*x/32)+sin(2*pi*x/8)*0.5-2;
y = sin(2*pi*x/21);
figure(1);
showDiscr(x,y);
figure(2);
Y=fft(y);
showDiscr(x,fftshift(abs(Y)));
figure(3);
y1=ifft(Y);     %funkcja wylicza odwrotną transformatę fouriera

showDiscr(x,y1);