clc
clear()

%[b,a] = butter (rzad, wp, 's')
%                rzad,     typ
%b - licznik
%a - mianownik

for rzad=1:5
    w = logspace(-2,2,10000);
    [b,a] = cheby1(rzad, 1, 1, 's');
    [h] = freqs(b,a,w);
    
    loglog(w, abs(h));
    hold on
    
ws = [5,10,50];
[h]=freqs(b,a,ws);
slope= -20*log10(abs(h));
oct(rzad) = slope(2)-slope(1);
dec(rzad) = slope(3)-slope(1);

end





