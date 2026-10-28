clc
clear()

ap = 3; 
as = 50;
wp = [3 4];
ws = [1 8];

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
    
%-----------------------------------

M = 10^(-as/20);
x = [10^(-2) ws(1) ws(1)];
y = [M M 10^(2)]    
loglog(x,y,'r','LineWidth',2)    

hold on

M = 10^(-ap/20);
x = [wp(1) wp(1) wp(2) wp(2)];
y = [10^(-10) M M 10^(-10)]    
loglog(x,y,'b','LineWidth',2)

hold on

M = 10^(-as/20);
x = [ws(2) ws(2) 10^2];
y = [10^2 M M]    
loglog(x,y,'g','LineWidth',2)

