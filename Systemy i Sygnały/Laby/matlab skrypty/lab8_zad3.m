clc
clear()

%zad 3 z lab8

%[b,a] = cheby1(rzad, ap, wp, 's')

    w = logspace(-2,2,10000);
    [b,a] = butter(5, 1,'s');
    [h] = freqs(b,a,w);
    
    figure(1)
    loglog(w, abs(h));
    hold on
    figure(2)
    semilogx(w, angle(h))
    hold on
    
    [b,a] = cheby1(5, 1,1,'s');
    [h] = freqs(b,a,w);
    figure(1)
    loglog(w, abs(h));
    figure(2)
    semilogx(w, angle(h))
    
