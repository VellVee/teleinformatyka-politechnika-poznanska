function SzeregFouriera(przebieg,Fk)

%  APROKSYMACJA PRZEBIEGU OKRESOWEGO RZECZYWISTEGO
%  SZEREGIEM HARMONICZNYM
%
%  wywolanie: SzeregFouriera(przebieg, Fk)
%
%  przebieg - wektor próbek pojedynczego okresu aproksymowanego
%  przebiegu
%  Fk - wspó³czynniki zespolonego szeregu Fouriera aproksymowanego
%  przebiegu ([F0 F1 F2 ...])

f_f=przebieg; 
t=[0:1/(length(f_f)-1):1.0];
w=2*pi*t;
y=zeros(1,length(f_f));

C=Fk;


dy=max(f_f)-min(f_f);
lowx=min(f_f)-(0.1*dy);
highx=max(f_f)+(0.1*dy);

hFig = figure();
FigPos = get(hFig, 'Position');
NewFigPos = [FigPos(1) (FigPos(2)-FigPos(4)) FigPos(3) 2*FigPos(4)];
set(hFig, 'Position', NewFigPos)

subplot(2,1,1);
plot(t,f_f);  title('Aproksymowany przebieg');
xlabel('prosze nacisnac dowolny klawisz aby kontynuowac...');
axis( [ 0.0 1.0 lowx  highx] );

disp('');
disp('    prosze przejsc do okna wykresu ...');
pause;
C(1)=C(1)/2;
e =zeros(1,length(C));
em=zeros(1,length(C));
for k=1:length(C)
    if(abs(C(k)) < eps)
        C(k)=0;
    end
end
for k=1:length(C),    
    YkPlus  = C(k)*exp(j*(k-1)*w);
    YkMinus = C(k)'*exp(-j*(k-1)*w);
    Yk = YkPlus + YkMinus;
    if C(k)~=0       
        y=y+Yk;
    end

    if max(f_f)>max(y),  newmax=max(f_f); else newmax=max(y); end;
    if min(f_f)< min(y), newmin=min(f_f); else newmin=min(y); end;
    newd=newmax-newmin;
    subplot(2,1,1); plot(t,f_f,t,y); axis([0 1 newmin-0.1*newd newmax+0.1*newd]); 
    title(sprintf('Suma czesciowa skladnikow 0..%g',k-1));
    xlabel('czas');
    subplot(2,1,2); plot(t,Yk); axis([0 1 -1 1]);
    title(sprintf('Dodawany sk³adnik skladnik |k|=%g F(k)=%g', k-1, C(k)));
    xlabel({'czas';'prosze nacisnac dowolny klawisz aby kontynuowac...'});
    pause;
    e(k)=sqrt(1/length(f_f)*sum((f_f-y).^2)/sum(f_f.^2));
    em(k)=max(abs(f_f-y));	
end

clc
disp('Blad sredniokwadratowy:');
e
disp('Blad maksymalny:');
em

%set(hFig, 'Position', FigPos)
subplot(2,1,1);
plot(e);
if (max(e)-min(e))~=0, axis([1 length(C) 0 1.1*max(e)]); end;
title('Blad sredniokwadratowy');
xlabel({'liczba wyrazow szeregu'});
subplot(2,1,2);
plot(em);
if (max(em)-min(em))~=0, axis([1 length(C) 0 1.1*max(em)]); end;
title('Blad maksymalny');
xlabel({'liczba wyrazow szeregu';'prosze nacisnac dowolny klawisz aby kontynuowac...'});
pause;

close(hFig);