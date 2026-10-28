clc
clear()

ap = 3; %alfa p
as = 80;
wp = 3;
ws = 8;

w=logspace(-2,2,10000);

[rzadB, wx] = buttord(wp,ws,ap,as,'s');

[rzadC1, wx] = cheb1ord(wp,ws,ap,as,'s');

[rzadC2, wx] = cheb2ord(wp,ws,ap,as,'s');

[rzadE, wx] = ellipord(wp,ws,ap,as,'s');


[b,a] = butter(rzadB, wp, 's')
    [h] = freqs(b,a,w);
    loglog(w, abs(h));
    hold on
    
[b,a] = cheby1(rzadC1, ap, wp, 's')
    [h] = freqs(b,a,w);
    loglog(w, abs(h));
    hold on

[b,a] = cheby2(rzadC2, as, ws, 's')
    [h] = freqs(b,a,w);
    loglog(w, abs(h));
    hold on

[b,a] = ellip(rzadE, ap, as, wp, 's');
    [h] = freqs(b,a,w);
    loglog(w, abs(h));
    hold on

