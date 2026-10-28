% function fiber bragg_mirror

clear all
wavelength = 1564.68;       % d³ugoœæ fali [nm]

N = 4500;                   % Liczba okres?w - number of periods
n_L = 1.45;                 % Dolna warto?? wsp?czynnika za?amania - Low refractive index
n_H = 1.451;                % G?rna warto?? wsp?czynnika za?amania - High refractive index
deltan = n_H - n_L;                    % ró¿nica wsp. za³amania
delta = deltan/n_H;                    % kontrast wsp. za³amania
a_L = wavelength/(4*n_L);              % Grubo?? warstwy - thickness (nm)
a_H = wavelength/(4*n_H);              % Grubo?? warstwy - thickness (nm)

Lambda = a_L + a_H;     % period of the structure
lambda = 1000:0.01:2200;

k_L = 2*pi*n_L./lambda;
k_H = 2*pi*n_H./lambda;

a = exp(1i*a_H*k_H) .* (cos(k_L*a_L)+(1i/2) * (k_H./k_L+k_L./k_H) .* sin(k_L*a_L));
d = exp(-1i*a_H*k_H) .* (cos(k_L*a_L)-(1i/2) * (k_H./k_L+k_L./k_H) .* sin(k_L*a_L));
b = exp(-1i*a_H*k_H) .* ((1i/2)*(k_L./k_H - k_H./k_L) .* sin(k_L*a_L));
c = exp(1i*a_H*k_H) .* ((1i/2)*(k_H./k_L - k_L./k_H) .* sin(k_L*a_L));

K = (1/Lambda)*acos((a+d)/2);
tt = (sin(K*Lambda)./sin(N*K*Lambda)).^2;
denom = abs(c).^2 + tt;
R = abs(c).^2 ./ denom;

figure(1)
plot(lambda, R, 'LineWidth', 1.5);
axis([1560 1570 0 1.2]);
xlabel('Wavelenght (nm)', 'FontSize', 14);
ylabel('Reflectivity', 'FontSize', 14);
set(gca, 'FontSize',10);
xtickangle(90);

display(max(R));        % Max 
half = real(max(R))/2;  % Po³owa maks. wartosci dla pasma 3dB

%Obliczanie szerokoœci pasma 3dB w [nm] i [GHz]
list = []; 
for i = 1000:length(R)
    if real(R(i)) >= half
        list(end+1) = i/100 + 1000;
    end
end
bandwidth3dB = list(end)-list(1);
display(bandwidth3dB);
f1 = 3*10^8/list(end);
f2 = 3*10^8/list(1);
bandwidth3dBinGHz = f2 - f1;
display(bandwidth3dBinGHz);



%Obliczanie wykresu zale¿nosci R(N) (czasoch³onne)
%R2=[];
%for N = 1:5000
%    tt = (sin(K*Lambda)./sin(N*K*Lambda)).^2;
%    denom = abs(c).^2 + tt;
%    R = abs(c).^2 ./ denom;
%    R2(end+1)=max(R);
%end
%figure(2)
%plot(1:5000, R2)
%xlabel('Number of periods', 'FontSize', 11);
%ylabel('Reflectivity', 'FontSize', 11);


% end