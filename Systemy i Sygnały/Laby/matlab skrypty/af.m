%Funkcja wyswietla charakterystyki ukladu o podanej transmitancji.
%Uzycie : af(b,a,w); gdzie:
%b : wspolczynniki wielomianu zmiennej s z licznika (od najwyzszej potegi)
%a : wspolczynniki wielomianu zmiennej s z mianownika (od najwyzszej potegi)
%                        s^2 + 1             b=[1 0 1]
%     przyklad   H(s)= -----------        
%                        s^2 + 2s            a=[1 2 0]
%w : probki pulsacji dla ktorych zostanie wykonane badanie charakterystyk:
%    amplitudowej i fazowej.

%Function displays system characteristics for a given transmitance.
%Usage : af(b,a,w); where:
%b : the coefficients of polynomial b beeing a numerator of s
%a : the coefficients of polynomial a beeing a denominator of s
%                       s^2 + 1             b=[1 0 1]
%     example   H(s)= -----------       
%                       s^2 + 2s            a=[1 2 0]
%w : pulsation samples used to calculate and draw characteristics: 
%    amplitude and phase characteristics


function y=af(b,a,wo)
if(wo(1)==0),
  wo(1)=1e-20;
end;
zo=freqs(b,a,wo);
waf=[wo max(wo):1000:100000];
z=freqs(b,a,waf);
axis('square');
sc=1.1*max(abs(z));
if (sc>0), 
 x0=real(z(1))+.05;
 y0=imag(z(1));
 xn=real(z(length(z)))+.05;
 yn=imag(z(length(z)));
 if(abs(xn-x0)<.2),
  if(abs(yn-y0)<.2),xn=xn+.2;
  end;
 end;
 axis([-sc sc -sc sc]);
 plot(z),title('Charakterystyka amplitudowo-fazowa / amplitude-phase characteristic'),xlabel('Re')
 ylabel('Im'),grid,text(x0,y0,'w=0'),text(xn,yn,'w=ì')
 pause
 axis;
else
 z(1)=z(2);
 x0=real(z(1))+.05;
 y0=imag(z(1));
 xn=real(z(length(z)))+.05;
 yn=imag(z(length(z)));
 if(abs(xn-x0)<.2),
  if(abs(yn-y0)<.2),xn=xn+.2;
  end;
 end;
 plot(z),title('Charakterystyka amplitudowo-fazowa / amplitude-phase characteristic'),xlabel('Re');
 ylabel('Im'),grid,text(x0,y0,'w=0'),text(xn,yn,'w=ì')
 pause;
end; 
 
axis('normal');
plot(wo,abs(zo)),title('Charakterystyka amplitudowa / amplitude characteristic');xlabel('w')
ylabel('M(w)');
pause;
plot(wo,angle(zo)),title('Charakterystyka fazowa / phase characteristic');xlabel('w')
ylabel('F(w)');
pause;
clc;
