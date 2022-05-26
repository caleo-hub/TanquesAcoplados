clear, close all
load('dados_tanque.mat');
h1 = h1_ruido(500:1200);

Fs = 2;
fs = Fs;
T = 0.5;
L = size(h1,2);
t = (0:L-1)*T;

S = h1;
Y = fft(S);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);


f = (Fs*(0:(L/2))/L);
figure(1)

plot(f,mag2db(P1)) 
title('Single-Sided Amplitude Spectrum of S(t)[dB]')
xlabel('f (Hz)')
ylabel('|P1(f)|')
grid on

figure(2)
Wc = 0.1;
[b,a] = cheby2(5,60,Wc);
f_h1 = filtfilt(b,a,h1);
plot(t,f_h1);
hold on
plot(t,S);
grid on
title('Sinal Filtrado')
xlabel('tempo [s]')
ylabel('h1')
legend('H1 filtrado', 'Original')
ylim([24 30])
