
%Funkcja wykresla odpowiedz skokowa ukladu o zadanych liczniku i
%mianowniku transmitancji.
%
%  wywolanie: [f,ze,bi]=skokowa(B,A)
%    B oraz A to wektory zawierajace kolejne wspolczynniki wielomianow
%    licznika i mianownika transmitancji, rozpoczynajace sie od
%    wspolczynnika przy najwyzszej potedze zmiennej s
%
%                                       B(s)  
%     gdzie transmitancja ukladu H(s)= ------
%                                       A(s)
%
%    Jako wynik funkcja daje: f - wektor odpowiedzi skokowej
%                             ze - zera transmitancji
%                             bi - bieguny transmitancji

function [f,ze,bi]=skokowa(a,b)
% Krzysztof Klimaszewski, 2006


% zmienna osie wybiera sposob skalowania osi wykresu polozenia zer i biegunow. Mozliwe
% wartosci: 0 - staly zakres x -10:10 i y -10:10
%           1 - zakres dopasowywany do danych, podaje wspolrzedne punktow
%           na wykresie
osie=0;
stare_b=b;
b=[b 0];

[A,B,C,D]=tf2ss(a,b)
t=0:0.001:10;
f=zeros(1,length(t));
for i=1:length(t)
    f(i)=C*expm(A*t(i))*B;
end

f(1)=f(1)+D;
clf
subplot(2,1,1)
plot(t,f)
grid
xlabel('t')
title('ODPOWIEDZ SKOKOWA')
subplot(2,1,2)
if ~isempty(roots(stare_b))
    plot(real(roots(stare_b)),imag(roots(stare_b)),'rx')
    hold on
end
if ~isempty(roots(a))
    plot(real(roots(a)),imag(roots(a)),'bo')
end

disp('Zera transmitancji:')
ze=roots(a);
if isempty(ze)
    disp('Nie ma')
else
    disp(ze)
end

disp('Bieguny transmitancji:')
bi=roots(stare_b);
disp(bi)


%set(gca,'XMinorTick','on')
%set(gca,'YMinorTick','on')

%set(gca,'XMinorGrid','on')
%set(gca,'YMinorGrid','on')
xlabel('Re')
ylabel('Im')
set(gca,'GridLineStyle','-')

if osie==1
    wart=[roots(a) ; roots(stare_b)];
    set(gca,'Xtick',unique(sort([0 real(wart)'])))
    set(gca,'Ytick',unique(sort([0 imag(wart)'])))
    odstx=max(real(wart))-min(real(wart));
    odsty=max(imag(wart))-min(imag(wart));
    if (odstx~=0)&&(odsty~=0)
        axis([min(real(wart))-0.1*odstx max(real(wart))+0.1*odstx min(imag(wart))-0.1*odsty max(imag(wart))+0.1*odsty])
    elseif(odstx==0)&&(odsty~=0)
        if max(real(wart))==0
            axis([min(imag(wart))-0.1 max(imag(wart))+0.1 min(imag(wart))-0.1*odsty max(imag(wart))+0.1*odsty])
        else
            axis([min(real(wart))-0.1*abs(min(real(wart))) max(real(wart))+0.1*abs(max(real(wart))) min(imag(wart))-0.1*odsty max(imag(wart))+0.1*odsty])
        end
    elseif(odsty==0)&&(odstx~=0)
        if max(imag(wart))==0
            axis([min(real(wart))-0.1*odstx max(real(wart))+0.1*odstx min(real(wart))-0.1 max(real(wart))+0.1])
        else
            axis([min(real(wart))-0.1*odstx max(real(wart))+0.1*odstx min(imag(wart))-0.1*abs(min(imag(wart))) max(imag(wart))+0.1*abs(max(imag(wart)))])
        end
    else
        axis([min(real(wart))-0.1 max(real(wart))+0.1 min(imag(wart))-0.1 max(imag(wart))+0.1])
    end
else
    set(gca,'Xtick',[0])
    set(gca,'Ytick',[0])
    axis([-10 10 -10 10])
end
grid
title('POLOZENIE BIEGUNOW I ZER')
legend('biegun','zero',-1)

