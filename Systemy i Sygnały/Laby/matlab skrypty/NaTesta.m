%funckja na test A - licznik, B - mianownik

function NaTesta(A,B)

w = logspace(-2,2,10000);
s=1i*w;

H = (polyval(A,s))./(polyval(B,s));

M = abs(H);
O = angle(H);

subplot(2,1,1)
loglog(w,M, 'r')

subplot(2,1,2)
semilogx(w,O, 'b')

end