clc
clear()

ap = 3; 
as = 80;
wp = 8;
ws = 3;

w=logspace(-2,2,10000);

[rzadB, wx] = buttord(wp,ws,ap,as,'s');

[rzadC1, wx] = cheb1ord(wp,ws,ap,as,'s');

[rzadC2, wx] = cheb2ord(wp,ws,ap,as,'s');

[rzadE, wx] = ellipord(wp,ws,ap,as,'s');


[b,a] = butter(rzadB, wp,'high', 's')
    [h] = freqs(b,a,w);
    loglog(w, abs(h));
    hold on
    
[b,a] = cheby1(rzadC1, ap, wp,'high', 's')
    [h] = freqs(b,a,w);
    loglog(w, abs(h));
    hold on

[b,a] = cheby2(rzadC2, as, ws,'high', 's')
    [h] = freqs(b,a,w);
    loglog(w, abs(h));
    hold on

[b,a] = ellip(rzadE, ap, as, wp,'high', 's');
    [h] = freqs(b,a,w);
    loglog(w, abs(h));
    hold on

%-----------------------------------%teraz jest odwrotnie itd bo high 

Mp = 10^(-as/20);
x = [min(w) ws ws];
y = [Mp Mp 10^(2)];    
loglog(x,y,'r','LineWidth',2)    

hold on

Ms = 10^(-ap/20);
x = [wp wp max(w)];
y = [10^(-10) Ms Ms];    
loglog(x,y,'r','LineWidth',2)    
    
    
    