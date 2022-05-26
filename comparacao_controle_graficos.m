%% Importando Dados
close all
controleLQR


%% Rodar modelo Simulink

stepValueh1 = 1;
stepValueh2 = 1;
stepTime = 0;
Simulation_Time = 300 + stepTime;

out = sim('ControleTanqueModelos',Simulation_Time); 


%% Modelo não-linear
tempo = out;
uNL_controle = uNL_controle.data;
yNL_controle = yNL_controle.data;
h1NL = yNL_controle(:,1);
h2NL = yNL_controle(:,2);
v1NL = uNL_controle(:,1);
v2NL = uNL_controle(:,2);


step_h1NL = stepinfo(h1NL,tempo);
step_h2NL = stepinfo(h2NL,tempo);
saidasNL = ['h1';'h2'];
overshootNL = [step_h1NL.Overshoot; step_h2NL.Overshoot];
undershootNL = [step_h1NL.Undershoot; step_h2NL.Undershoot];
acomodacaoNL = [step_h1NL.SettlingTime;step_h2NL.SettlingTime];
tabela = table(saidasNL,overshootNL,undershootNL,acomodacaoNL,'VariableNames',{'Saida','OvershootPerc','UndershootPerc','TempoAcomodacao'})
    
    


    


%% Modelo Linear

uL_controle = uL_controle.data;
yL_controle = yL_controle.data;
h1L = yL_controle(:,1);
h2L = yL_controle(:,2);
v1L = uL_controle(:,1);
v2L = uL_controle(:,2);

figure = figure(1);
subplot(4,1,1)
plot(tempo,h1L,'--','LineWidth',2)
hold on
plot(tempo,h1NL,'LineWidth',1)
title('Resposta a entrada - Modelo Fenomenológico e Não-Linear')
xlabel('tempo [s]')
ylabel('Nível [cm]')
legend('H1 Fm','H1 Não-Linear','Location','east')
grid on


subplot(4,1,2)
plot(tempo,h2L,'--','LineWidth',2)
hold on
plot(tempo,h2NL,'LineWidth',1)
legend('H2 Fm','H2 Não-Linear','Location','east')
xlabel('tempo [s]')
ylabel('Nível [cm]')
grid on

subplot(4,1,3)
plot(tempo,v1NL,tempo,v2NL,'LineWidth',1)
legend('v1 Não Linear','v2 Não Linear','Location','southeast')
xlabel('tempo [s]')
ylabel('Vazão [cm3/s]')
grid on

subplot(4,1,4)
plot(tempo,v1L,tempo,v2L,'LineWidth',1)
legend('v1 Fm','v2 Fm','Location','southeast')
xlabel('tempo [s]')
ylabel('Vazão [cm3/s]')
grid on

