% H(s) = s/(5s+1)    <-- dana jest transmitancja układu
% H(jw) = jw/(5jw+1) <-- obliczamy charakterystykę amplitudową
% figure(n) - funkcja tworzy nowe okno (n-te)
% atan(..) - to samo co arctg(...)

w = logspace(-2,2,1000);
s = i*w;

B=[1 0]
A=[5 1]
h = polyval(B,s)./polyval(A,s); 
M = abs(h);
A = angle(h);

figure(1);
loglog(w,11);
figure(2);
semilogx(w,A);
freqs(B,A,w)