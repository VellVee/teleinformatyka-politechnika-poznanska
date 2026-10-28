f=3*10^9
c=3*10^8
a1=1
a2=-0.9
sufit=(-0.7)
podloga=(-0.9)

a3=sufit*sufit*podloga
GT=1.6      %zalozylem wartosc z poprzednich zadan
GR=GT
P0=GT*GR*(c/(4*pi*f))^2

for szerokosc=3:40

  d1=szerokosc
  d2=sqrt(16+szerokosc^2)
  d3=sqrt(1296+szerokosc^2)

  dFi2=(-2*pi*f*(d2-d1))/c
  dFi3=(-2*pi*f*(d3-d1))/c

  Prx=(abs(a1/d1+a2/d2*exp(i*dFi2)+a3/d3*exp(i*dFi3)))^2
  P(szerokosc)=10*log10(Prx*P0)

end

szerokosc=0:1:39
plot(szerokosc,P)   % wykres 
xlabel("odleglosc miedzy terminalami")
ylabel("spadek mocy")
grid minor on