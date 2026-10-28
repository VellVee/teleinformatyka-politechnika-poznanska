% Tworzy wykres sygnalu dyskretnego w postaci prazkow
% x - numer próbki,
% y - wartoœæ próbki
%
% Draw plot of discrete signal
% x - sample number (vector)
% y - sample value (vector)
% 
function p=showDiscr(x,y);

for k=1:length(x)-1;
X(3*k-2)=x(k);
X(3*k-1)=x(k);
X(3*k)=x(k+1);
X(3*k+1)=x(k+1);
Y(3*k-2)=y(k);
Y(3*k-1)=0;
Y(3*k)=0;
Y(3*k+1)=y(k+1);
end;
%X
%Y

%scaling
xmin=min(x)-1;
xmax=max(x)+1;
if min(y)<0 ymin=1.2*min(y);
else ymin=0; end
if max(y)<0 ymax=0.8*max(y);
else ymax=1.2*max(y); end

plot(x,y,'r*',X,Y,'r');
axis( [xmin xmax ymin ymax] );