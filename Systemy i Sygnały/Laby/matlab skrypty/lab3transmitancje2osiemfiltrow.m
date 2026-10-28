clear()
clc

%zeszyt z panda - wypisane

w = logspace(-2, 2, 10000);

l1=[1];
m1=[5 1];

l2=[2];
m2=[1 3];

l3=[1 2];
m3=[1 3];

l4=[1 2];
m4=[1 1];

l5=[1 1];
m5=[1 2];

l6=[2];
m6=[2 4];

l7=[2 3];
m7=[2 4];

l8=[2 1];
m8=[1 4];


figure(1);
freqs(l1,m1,w);

figure(2);
freqs(l2,m2,w);

figure(3);
freqs(l3,m3,w);

figure(4);
freqs(l4,m4,w);

figure(5);
freqs(l5,m5,w);

figure(6);
freqs(l6,m6,w);

figure(7);
freqs(l7,m7,w);

figure(8);
freqs(l8,m8,w);






