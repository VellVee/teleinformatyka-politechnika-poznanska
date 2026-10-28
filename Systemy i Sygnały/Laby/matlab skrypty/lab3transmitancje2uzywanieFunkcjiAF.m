clear()
clc

%zeszyt z panda - tlumacznie?

w = logspace(-2, 2, 10000);

l=[2];
m=[1 3];

figure(1);
freqs(l,m,w);

figure(2)
af(l,m,w) % charakterystyka amplitudowo - fazowa
            % nie okreslimy na tej podstawie jaki to typ filtru





