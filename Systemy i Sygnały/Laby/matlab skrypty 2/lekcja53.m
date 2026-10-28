%wykresy  dla piwerwszego przykladu  
w=[4 5 1]; 
pierw=roots(w); 
r=real(pierw);  
i=imag(pierw); 
figure(1) 
plot(r,i,'rx')   
hold on;

t = [0:1/10:30];
h = (2/sqrt(15)).*exp(-t/8).*sin(sqrt(15).*t/8);
plot(t,h);

hold off;