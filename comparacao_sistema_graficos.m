close all, clear, clc

%% Consumindo dados
dadosTanque

%% Rodar modelo Simulink
stepValueh1 = 1;
stepValueh2 = -1;
Simulation_Time = 500;
stepTime = 20;

out = sim('tanqueModelos',Simulation_Time); 

%% Modelo n�o-linear
tempo = out;
uNL = u_NL.data;
yNL = y_NL.data;
h1NL = yNL(:,1);
h2NL = yNL(:,2);
v1NL = uNL(:,1);
v2NL = uNL(:,2);


%% Modelo Linear

uL = u_L.data;
yL = y_L.data;
h1L = yL(:,1);
h2L = yL(:,2);
v1L = uL(:,1);
v2L = uL(:,2);

figure = figure(2);
subplot(4,1,1)
plot(tempo,h1L,'--','LineWidth',2)
hold on
plot(tempo,h1NL,'LineWidth',1)
title('Resposta a entrada - Modelo Linear e N�o-Linear')
xlabel('tempo [s]')
ylabel('N�vel [cm]')
legend('H1 Linear','H1 N�o-Linear','Location','east')
grid on


subplot(4,1,2)
plot(tempo,h2L,'--','LineWidth',2)
hold on
plot(tempo,h2NL,'LineWidth',1)
legend('H2 Linear','H2 N�o-Linear','Location','east')
xlabel('tempo [s]')
ylabel('N�vel [cm]')
grid on


subplot(4,1,3)
plot(tempo,v1NL,'LineWidth',2)
legend('Qin1','Location','southeast')
xlabel('tempo [s]')
ylabel('Vaz�o [cm3/s]')
grid on

subplot(4,1,4)
plot(tempo,v2NL,'LineWidth',2)
legend('Qin2','Location','southeast')
xlabel('tempo [s]')
ylabel('Vaz�o [cm3/s]')
grid on




