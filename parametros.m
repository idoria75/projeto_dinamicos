%% Clear environment
clc;
clear all;
close all;

% t = [0.1:0.1:7.2]
% y = [0.499238938966419	,0.496961548004645	,0.493185159449869	,
%     0.487938513923859	,0.481261541601284	,0.473205058316713	,
%     0.463830378825103	,0.453208850159087 ,0.441421308634512	,
%     0.428557464636740	,0.414715219869858	,0.399999922264960	,
%     0.384523564218093	,0.368403930259767	,0.351763700642797	,
%     0.334729517670695   ,0.317431021872450	,0.299999865358979	,
%     0.282568709870209	,0.265270217138267	,0.248236039250733	,
%     0.231595816697899	,0.215476191729518	,0.199999844529981 ,
%     0.185284559547247	,0.171442329081300	,0.158578500954394	,
%     0.146790976749831	,0.136169466721154	,0.126794807042371	,
%     0.118738344595326	,0.112061393976391  ,0.106814770854956	,
%     0.103038405235178	,0.100761037564275	,0.100000000000181	,
%     0.100761084503248	,0.103038498755889	,0.106814910245656	,
%     0.112061578176231   ,0.118738572202434	,0.126795076324517	,
%     0.136169775628937	,0.146791322932274	,0.158578881776838	,
%     0.171442741645453	,0.185285000713244	,0.200000310940279 ,
%     0.215476679834450	,0.231596322782690	,0.248236559463768	,
%     0.265270747520407	,0.282569246384923	,0.300000403923062	,
%     0.317431558387100	,0.334730048052709 ,0.351764220855644	,
%     0.368404436344310	,0.384524052322719	,0.400000388674896	,
%     0.414715661035439	,0.428557877200426	,0.441421689456443	,
%     0.453209196340974 ,0.463830687732292	,0.473205327598231	,
%     0.481261769207735	,0.487938698123018	,0.493185298839869	,
%     0.496961641524642	,0.499238985904669	,0.499999999999275];
%% Parametros fixos
% m1 = 2.2;
% m2 = 2.2;
% mp = 2;
% 
% L1 = 0.6;
% L2 = 0.6;
% l1 = 0.3;
% l2 = 0.3;
% I1 = 0.066;
% I2 = 0.066;
% g = 9.81;

%% Parametros variaveis
% Passo de integracao
passo_integracao = 1e-4;
t_sim = 30;
% Condicoes iniciais
x1_0 = 0;
x2_0 = 0;
x3_0 = 0;
x4_0 = 0;
% Atrito
Kat = .3;

limite_quadrado = 3;

%% Geracao de trajetoria

L1 = 0.6;
L2 = 0.6;

circulo = 360;
num_pontos = 120;

tempo_d = 30;
intervalo = tempo_d/num_pontos;
lista_tempos = 0:intervalo:tempo_d

theta_passo = circulo/num_pontos;

lista_thetas = [0:theta_passo:circulo];

raio = 1;
lista_posx = [];
lista_posy = [];

for i = 1:num_pontos+1
    lista_posx(i) = raio*cosd(lista_thetas(i));
    lista_posy(i) = raio*sind(lista_thetas(i));
end

% figure; hold on;
% xlim([-1.5 1.5]);
% ylim([-1.5 1.5]);

lista_theta1 = [];
lista_theta2 = [];
for i = 1:num_pontos+1
    xd = lista_posx(i);
    yd = lista_posy(i);

    aux1 = (xd^2+yd^2-L1^2-L2^2)/(2*L1*L2);
    theta2 = acosd(aux1);
    lista_theta2(i) = theta2;
    aux2_num = yd*(L1+L2*cosd(theta2))-xd*L2*sind(theta2);
    aux2_den = xd*(L1+L2*cosd(theta2))+yd*L2*sind(theta2);
    aux2 = aux2_num/aux2_den;
    % theta1 = atan2d(L2*cosd(theta2),L2*sind(theta2))
    theta1 = atan2d(aux2_num, aux2_den);
    lista_theta1(i) = theta1;

    px1 = L1*cosd(theta1);
    py1 = L1*sind(theta1);
    px2 = px1+L2*cosd(theta1+theta2);
    py2 = py1+L2*sind(theta1+theta2);
    r = sqrt(px2^2+py2^2);
    L1_calc = sqrt(px1^2+py1^2);
    L2_calc = sqrt((px2-px1)^2+(py2-py1)^2);
    
%     plot([0 px1],[0 py1]);
%     plot([px1 px2],[py1 py2]);
end

% plot(lista_posx,lista_posy);

%% Executa Simulacao
open_system('projeto_2016/estados')
simOut = sim('projeto_2016');