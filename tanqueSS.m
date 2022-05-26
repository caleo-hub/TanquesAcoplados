clear
close all
clc
syms qin1 qin2 h1 h2

h1_barra = 25;
h2_barra = 20;
k1 = 25; 
k2 = 25;
kac = 20;

[A1_barra,A2_barra] = secao_tanque(h1_barra,h2_barra);

qin1_barra = k1*sqrt(h1_barra) + kac*sqrt(h1_barra-h2_barra);
qin2_barra = k2*sqrt(h2_barra) - kac*sqrt(h1_barra-h2_barra);

f1 = (qin1 - k1*sqrt(h1) - kac*sqrt(abs(h1-h2)))/A1_barra;
f2 = (qin2 - k2*sqrt(h2) + kac*sqrt(abs(h1-h2)))/A2_barra;

df1_h1 = diff(f1,h1);
df1_h2 = diff(f1,h2);
df1_q1 = diff(f1,qin1);
df1_q2 = diff(f1,qin2);

df2_h1 = diff(f2,h1);
df2_h2 = diff(f2,h2);
df2_q1 = diff(f2,qin1);
df2_q2 = diff(f2,qin2);


A = [df1_h1, df1_h2; df2_h1, df2_h2];
B = [df1_q1, df1_q2; df2_q1, df2_q2];

A = subs(A,{qin1,qin2,h1,h2},{qin1_barra,qin2_barra,h1_barra,h2_barra});
B = subs(B,{qin1,qin2,h1,h2},{qin1_barra,qin2_barra,h1_barra,h2_barra});
C = [1 0;0 1];
D = [0 0;0 0];