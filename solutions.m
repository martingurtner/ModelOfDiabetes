syms a b c d

lambda1=0.5*((-a-d)+sqrt((a-d)^2-4*b*c))
lambda2=0.5*((-a-d)-sqrt((a-d)^2-4*b*c))

a=2.92;
b=4.34;
c=0.208;
d=0.780;

lam1=subs(lambda1,{'a','b','c','d'},{a,b,c,d})
lam2=subs(lambda2,{'a','b','c','d'},{a,b,c,d})
%%
A=[-a -b;...
    c -d];

B=[0 ; 0];

C=[1 0];
D=0

sys=ss(A,B,C,D);
initial(sys,[1 ;0])
