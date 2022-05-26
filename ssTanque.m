function [ssT]  = ssTanque()
%% Carregando dados
load('dados_tanque.mat');
h1 = h1_ruido(1:end-1);
h2 = h2_ruido(1:end-1);

%% Visualizando Dados
fs = 2;
T = 0.5;
L = size(h1,2);
t = (0:L-1)*T;


%% Filtrando Ruido

% Especificação do Filtro
 Wc = 0.2;%Wc = 0.1;
 ordem = 5;
 atenuacao_rejeicao = 60;
[b,a] = cheby2(ordem,atenuacao_rejeicao,Wc);


% fatiando dados no momento dos degraus e filtrando

h1_qin1 = h1(600:1200);
h2_qin1 = h2(600:1200);
d1_qin1 = qin1(600:1200);
L1 = size(h1_qin1,2);
t1 = (0:L1-1)*T;

h1_qin2 = h1(1800:2400);
h2_qin2 = h2(1800:2400);
d2_qin2 = qin2(1800:2400);
L2 = size(h1_qin2,2);
t2 = (0:L2-1)*T;

f_h1_qin1 = filtfilt(b,a,h1_qin1);
f_h2_qin1 = filtfilt(b,a,h2_qin1);

f_h1_qin2 = filtfilt(b,a,h1_qin2);
f_h2_qin2 = filtfilt(b,a,h2_qin2);


%% Modelagem do sistema
% Utilizando técnica de Smith

% ============= Em relação a qin1 =============================:

h1_inic_qin2 = 25;
h2_inic_qin2 = 20;

h1_perm_qin2 = mean(f_h1_qin1(end-50:end));
h2_perm_qin2 = mean(f_h2_qin1(end-50:end));

qin2_inic = d1_qin1(1);
qin2_final = d1_qin1(end);

Kp_h1_qin2 = (h1_perm_qin2-h1_inic_qin2)/(qin2_final-qin2_inic);
Kp_h2_qin2 = (h2_perm_qin2-h2_inic_qin2)/(qin2_final-qin2_inic);

y_t1_h1_qin2 = h1_inic_qin2 + 0.283*(h1_perm_qin2-h1_inic_qin2);
y_t1_h2_qin2 = h2_inic_qin2 + 0.283*(h2_perm_qin2-h2_inic_qin2);

y_t2_h1_qin2 = h1_inic_qin2 + 0.632*(h1_perm_qin2-h1_inic_qin2);
y_t2_h2_qin2 = h2_inic_qin2 + 0.632*(h2_perm_qin2-h2_inic_qin2);


tolerance = 0.05;
h1_qin2_interp = spline(t1, f_h1_qin1,t1);
h2_qin2_interp = spline(t1, f_h2_qin1 ,t1);


t1_h1_qin2 = min(t1(find(h1_qin2_interp>= (y_t1_h1_qin2 - tolerance) & h1_qin2_interp<= (tolerance + y_t1_h1_qin2))));
t1_h2_qin2 = min(t1(find(h2_qin2_interp>= (y_t1_h2_qin2 - tolerance) & h2_qin2_interp<= (tolerance + y_t1_h2_qin2))));


t2_h1_qin2 = min(t1(find(h1_qin2_interp>=(y_t2_h1_qin2 - tolerance) & h1_qin2_interp<= tolerance + y_t2_h1_qin2)));
t2_h2_qin2 = min(t1(find(h2_qin2_interp>=(y_t2_h2_qin2 - tolerance) & h2_qin2_interp<= tolerance + y_t2_h2_qin2)));


tau_h1_qin2 = 1.5*(t2_h1_qin2-t1_h1_qin2);
tau_h2_qin2 = 1.5*(t2_h2_qin2-t1_h2_qin2);

teta_h1_qin1 = 0;
teta_h2_qin1 = 1.5*t1_h2_qin2 - 0.5*t2_h2_qin2;


[num_h1_qin1,den_h1_qin1] = pade(teta_h1_qin1,1);
tf_h1_qin1 = tf([Kp_h1_qin2],[tau_h1_qin2 1],'IODelay',teta_h1_qin1) ;
[num_h2_qin1,den_h2_qin1] = pade(teta_h2_qin1,1);
tf_h2_qin1 = tf([Kp_h2_qin2],[tau_h2_qin2 1],'IODelay',teta_h2_qin1) ;

[y_h1_qin1] = (qin2_final - qin2_inic)*step(tf_h1_qin1,t1) + h1_inic_qin2;
[y_h2_qin1] = (qin2_final - qin2_inic)*step(tf_h2_qin1,t1) + h2_inic_qin2;

figure(2)
subplot(2,1,1)
hold on
plot(t1,f_h1_qin1)

plot(t1,y_h1_qin1, 'LineWidth',0.75)

title('Resposta ao degrau em Qin1')
xlabel('tempo [s]')
ylabel('Altura [cm]')
grid on
legend('h1','h1 Modelo', 'Location','east')

% ============== Em relação a qin2 ==========================:

h1_inic_qin2 = 25;
h2_inic_qin2 = 20;

h1_perm_qin2 = mean(f_h1_qin2(end-50:end));
h2_perm_qin2 = mean(f_h2_qin2(end-50:end));

qin2_inic = d2_qin2(1);
qin2_final = d2_qin2(end);

Kp_h1_qin2 = (h1_perm_qin2-h1_inic_qin2)/(qin2_final-qin2_inic);
Kp_h2_qin2 = (h2_perm_qin2-h2_inic_qin2)/(qin2_final-qin2_inic);

y_t1_h1_qin2 = h1_inic_qin2 + 0.283*(h1_perm_qin2-h1_inic_qin2);
y_t1_h2_qin2 = h2_inic_qin2 + 0.283*(h2_perm_qin2-h2_inic_qin2);

y_t2_h1_qin2 = h1_inic_qin2 + 0.632*(h1_perm_qin2-h1_inic_qin2);
y_t2_h2_qin2 = h2_inic_qin2 + 0.632*(h2_perm_qin2-h2_inic_qin2);


tolerance = 0.005;
h1_qin2_interp = spline(t2, f_h1_qin2, t2);
h2_qin2_interp = spline(t2, f_h2_qin2, t2);

t1_h1_qin2 = min(t2(find(h1_qin2_interp>= (y_t1_h1_qin2 - tolerance) & h1_qin2_interp<= (tolerance + y_t1_h1_qin2))));
t1_h2_qin2 = min(t2(find(h2_qin2_interp>= (y_t1_h2_qin2 - tolerance) & h2_qin2_interp<= (tolerance + y_t1_h2_qin2))));


t2_h1_qin2 = min(t2(find(h1_qin2_interp>=(y_t2_h1_qin2 - tolerance) & h1_qin2_interp<= tolerance + y_t2_h1_qin2)));
t2_h2_qin2 = min(t2(find(h2_qin2_interp>=(y_t2_h2_qin2 - tolerance) & h2_qin2_interp<= tolerance + y_t2_h2_qin2)));


tau_h1_qin2 = 1.5*(t2_h1_qin2-t1_h1_qin2);
tau_h2_qin2 = 1.5*(t2_h2_qin2-t1_h2_qin2);

teta_h1_qin2 = 1.5*t1_h1_qin2 - 0.5*t2_h1_qin2;
teta_h2_qin2 = 1.5*t1_h2_qin2 - 0.5*t2_h2_qin2;


tf_h1_qin2 = tf([Kp_h1_qin2],[tau_h1_qin2 1],'IODelay',teta_h1_qin2) ;

tf_h2_qin2 = tf([Kp_h2_qin2],[tau_h1_qin2 1],'IODelay',teta_h2_qin2);

[y_h1_qin2] = (qin2_final - qin2_inic)*step(tf_h1_qin2,t1) + h1_inic_qin2;
[y_h2_qin2] = (qin2_final - qin2_inic)*step(tf_h2_qin2,t1) + h2_inic_qin2;

figure(2)
subplot(2,1,2)
hold on
grid on

plot(t1,f_h2_qin2);

plot(t1,y_h2_qin2, 'LineWidth',0.75);
title('Resposta ao degrau em Qin2')
legend('h2','h2 Modelo', 'Location','east')


%% Desacoplmento
G = [tf_h1_qin1 tf_h2_qin1; tf_h1_qin2 tf_h1_qin2];
T = [tf_h1_qin1 0; 0 tf_h2_qin2];


ssT = ss(T,'min');


end

