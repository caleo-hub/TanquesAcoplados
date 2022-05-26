%% Consumindo dados
dadosTanque

A = A;
B2 = B2;
C = C;
D = D;

ssMA = ss(A,B2,C,D);
zerosMA = tzero(A,B2,C,D)
polosMA = eig(A)


%% Sistema Aumentado 


[n,m] = size(B2); % m = numero de saidas
[q,n] = size(C); % q = numero de saidas




 Aa = [A zeros(n,q); -C zeros(q,q)];
 B2a = [B2;-D];
 

 
 
 

 alfa = 0;
 rho = 0.5;

 %ksi*wn = 0.1754*0.4560
 Aalfa = Aa + alfa*eye(size(Aa,1)); 
 Qa = eye(size(Aalfa,1));
 R = rho*eye(m);
 
 
 Pa = are(Aalfa,B2a*inv(R)*B2a',Qa);
 Ka = -inv(R)*B2a'*Pa;
 K = Ka(:,1:n);
 Ki = Ka(:,n+1:n+q);
 
 [NUM,DEN] = ss2tf(A+B2*K, B2*Ki, -(C+D*K), -D*Ki,m);
 
 ssMF = ss(A+B2*K,B2*Ki,-(C+D*K),-D*Ki);
 zerosMF= tzero(A+B2*K,B2*Ki,-(C+D*K),-D*Ki)
 polosMF = eig([A+B2*K,B2*Ki;-(C+D*K),-D*Ki])
 

