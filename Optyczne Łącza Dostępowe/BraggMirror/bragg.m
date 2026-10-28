% function fiber bragg_mirror

clear all
N = 14;                 % Liczba okres�w - number of periods
n_L = 1.45;             % Dolna warto�� wsp�czynnika za�amania - Low refractive index
n_H = 2.25;             % G�rna warto�� wsp�czynnika za�amania - High refractive index
a_L = 259;              % Grubo�� warstwy - thickness (nm)
a_H = 167;              % Grubo�� warstwy - thickness (nm)

Lambda = a_L + a_H;     % period of the structure
lambda = 1000:10:2200;

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
plot(lambda, R, 'LineWidth', 1.5);
axis([1000 2200 0 1.2]);
xlabel('Wavelenght (nm)', 'FontSize', 14);
ylabel('Reflectivity', 'FontSize', 14);
set(gca, 'FontSize', 14);
pause (20)

close all

display(max(R));      % Max 

% end