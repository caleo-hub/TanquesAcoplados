clc, clear

stepValueh1 = 1;
stepValueh2 =1;
stepTime = 100;
h1 = 25;
h2 = 20;

k1 = 25; 
k2 = 25;
kac = 20;

[A1, A2] = secao_tanque(h1,h2);

qin1 = k1*sqrt(h1) + kac*sqrt(h1-h2);
qin2 = k2*sqrt(h2) - kac*sqrt(h1-h2);

ssT = ssTanque();
A = ssT.A;
B2 = ssT.B;
C = ssT.C;
D = ssT.D;


% Modelo Linearizado pelo modelo não Linear
% A =[ -0.0553, 0.0355;
%     0.0355,-0.0577];
%  
%  
% B2 = [0.0079,     0;
%         0,  0.0079];
%  
% 
% C = [1,0;0,1];
% 
% 
% D = [0,0;0,0];
