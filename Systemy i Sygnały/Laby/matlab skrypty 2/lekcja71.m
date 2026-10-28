w=logspace(-2,2,1000);
s=i*w;
lp=3;
fp=3000;
n=2;
[a5,b5]=cheby1(n,lp,fp,'s');
y5=polyval(a5,s)./polyval(b5,s);
h5=abs(y5);
loglog(w,h5,'b');

C1=100*10^(-9);
C2=100*10^(-9);
R1=a2+sqrt(a2^(2)-4*(C1./C2)*(b3+a3))./(2*C2(b3+a3));
R2=1./(C1*C2*R3*b3);
R2=1./(C1*C2*R3*a3);