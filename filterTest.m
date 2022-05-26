clc,clear
load('dados_tanque.mat');
fc = 0.002;
Fs = 2;
h1 = h1_ruido(1:end-1);

% lowpass(h1,0.002,Fs);
% [Y,D] = lowpass(h1,0.002);
% fvtool(D);  
fc = 0.05;
fs = 2;
[b,a] = cheby2(6,60,fc/(fs/2));
freqz(b,a,[],fs)
h = fvtool(b,a); 
 

