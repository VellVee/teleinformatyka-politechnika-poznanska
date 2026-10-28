clc;
x = videoinput('winvideo', 1, 'YUY2_640x480');
src = getselectedsource(x);
x.FramesPerTrigger = 1;
x.ReturnedColorspace = 'rgb';    %inicjalizacja kamerki

H=480;              %wymiary jednej klatki
W=640;

bity=8;
ileliczb=12000000;

sublist=[];
list=[];
listOrg=[];
y=0;
flip=false;

tic
while length(list) < ileliczb;
    y=y+1;
    A=getsnapshot(x);       %pobieramy pojedyncze zdjęcie
    for i = 1:H
        for j = 1:W
            for k = 1:3
                a=A(i,j,k);
                listOrg(end+1)=bitget(a,1);
                if(a <= 253) && (a >= 2)%odrzucamy liczby spoza zakresu
                    sublist(end+1)= bitget(a,1);
                end
            end
        end   
    end
    if(flip)                        %odwracamy bity z parzystych obrazów
        sublist=~sublist;
        flip=false;
    else
        flip=true;
    end
    
    bok=floor(sqrt(length(sublist)));%bok dla macierzy kwadratowej
    sublist=sublist(1:bok*bok);      %skracamy wektor żeby pasował do macierzy kwadratowej
    
    res = reshape(sublist,[bok,bok]);%macierz kwadratowa z wektora bitów
    res=transpose(res);
    sublist=reshape(res,1,[]);      %wektor z macierzy ale bierzemy kolumny nie wiersze
    
    r=floor(bok*bok/bity)*bity;     %chcemy wektor o rozmiarze
    sublist=sublist(1:r);           %podzielnym przez 8
    
    res = reshape(sublist,[floor(length(sublist)/bity),bity]);%grupujemy w kolumnach 8-bitowe słowa
    
    sublist=[];                     %zerujemy wektor
    for i = 1:length(res)           %tworzymy 8-bitowe słowa
        word=res(i,:);              %pobieramy kolumnę
        str=num2str(word);          %zamieniamy na typ string
        str(isspace(word))='';      %ucinamy spacje
        m=bin2dec(str);             %zmieniamy na liczbę
        sublist(end+1)= m;          %dodajemy słowo do sublisty
        word=[];                    %zerujemy słowo 8bitowe
    end
    
    list = [list, sublist];         %dodajemy do listy uzyskany rezultat z jednej klatki
    if length(list)>ileliczb;
        list=list(1:ileliczb);
        break
    end
    sublist=[];                     %zerujemy rezultat pojedynczej klatki
end

bok=floor(sqrt(length(listOrg)));
r2=floor(bok*bok/bity)*bity;              %chcemy wektor o rozmiarze
listOrg=listOrg(1:r2);           %podzielnym przez 8
res2 = reshape(listOrg,[floor(length(listOrg)/bity),bity]);%grupujemy w kolumnach 8-bitowe słowa
listOrg=[];
for i = 1:length(res2)           %tworzymy 8-bitowe słowa
        word=res2(i,:);              %pobieramy kolumnę
        str=num2str(word);          %zamieniamy na typ string
        str(isspace(word))='';      %ucinamy spacje
        m=bin2dec(str);             %zmieniamy na liczbę
        listOrg(end+1)= m;          %dodajemy słowo do sublisty
        word=[];                    %zerujemy słowo 8bitowe
end
toc

fileID=fopen('generated.bin', 'w');             %zapis do pliku .bin
fwrite(fileID, list, 'uint8');
fclose(fileID);
  
figure(1);
h=hist(listOrg,2^bity);
h=h/sum(h);
bar(h);
title('Empiryczny rozkład zmiennych losowych generowanych przez kamerkę.');
xlabel('Wartość');
ylabel('Częstość wystepowania (pi)');

figure(2);
h=hist(list,2^bity);
h=h/sum(h);
bar(h);
title('Empiryczny rozkład zmiennych losowych po postprocessingu.');
xlabel('Wartość');
ylabel('Częstość wystepowania (pi)');

x_normalized = listOrg/max(abs(listOrg));
entropiaOrg = entropy(x_normalized)

x_normalized = list/max(abs(list));
entropia = entropy(x_normalized)

