%function wykres(A,B)

A=[1]
B=[1 2 3]

w=logspace(-2,2,10000)
s=1i*w

H=(polyval(A,s)./polyval(B,s))

Io = angle(H)

semilogx(w, Io)


%end

