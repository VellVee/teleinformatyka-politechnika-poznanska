% R = 4
% H(s) = 1/(4s^2+4s+1)
%s --> 1/2

w = [4 5 1];
pierw=roots(w);
r=real(w);
i=imag(w);
figure(1)
plot(r,i,'x');
hold on;

t = [0:1/10:30];
h = (exp(-t/2).*t)/4;
plot(t,h);

hold off;