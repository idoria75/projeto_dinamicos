%% Clear environment
clc;
clear all;
close all;

%% Parametros variaveis
% Passo de integracao
passo_integracao = 1e-4;
t_sim = 10;
% Condicoes iniciais
x1_0 = 0;
% x1_0 = -0.5857;
x2_0 = 0;
x3_0 = 0;
% x3_0 = 1.1714
x4_0 = 0;
% Atrito
Kat = .3;

limite_quadrado = 3;

%% Geracao de trajetoria

L1 = 0.6;
L2 = 0.6;

lista_quad_x = [];
lista_quad_y = [];
pos0_x = 0.5;
posx = pos0_x;
pos0_y = 0;
posy = pos0_y;
lado = 1;
pontos_por_lado = 20;
incremento = lado/pontos_por_lado;
total_pontos = 4*pontos_por_lado;

for i = 1:total_pontos+1
    if i < 10
        posy = posy+incremento;
        lista_quad_x(i) = posx;
        lista_quad_y(i) = posy;
    end
    if i >= 10 && i < 30
        posx = posx-incremento;
        lista_quad_x(i) = posx;
        lista_quad_y(i) = posy;
    end
    if i >= 30 && i < 50
        posy = posy-incremento;
        lista_quad_x(i) = posx;
        lista_quad_y(i) = posy;
    end
    if i>= 50 && i<70
        posx = posx+incremento;
        lista_quad_x(i) = posx;
        lista_quad_y(i) = posy;
    end
    if i <= 81 && i >= 70
        posy = posy+incremento;
        lista_quad_x(i) = posx;
        lista_quad_y(i) = posy;
    end
end

tempo_d = t_sim;
intervalo = tempo_d/total_pontos;
lista_tempos_quadrado = 0:intervalo:tempo_d;

% lista_quad_x
% lista_quad_y
%%

L1 = 0.6;
L2 = 0.6;

circulo = 360;
num_pontos = 180;

tempo_d = t_sim;
intervalo = tempo_d/num_pontos;
lista_tempos = 0:intervalo:tempo_d;

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

% Confere Cinematica Inversa
for i = 1:num_pontos+1
    xd = lista_posx(i);
    yd = lista_posy(i);

    aux1 = (xd^2+yd^2-L1^2-L2^2)/(2*L1*L2);
    theta2 = acos(aux1);
    lista_theta2(i) = theta2;
    aux2_num = yd*(L1+L2*cosd(theta2))-xd*L2*sind(theta2);
    aux2_den = xd*(L1+L2*cosd(theta2))+yd*L2*sind(theta2);
    aux2 = aux2_num/aux2_den;
%     theta1 = atan2d(L2*cosd(theta2),L2*sind(theta2))
%     theta1 = atan2(aux2_num, aux2_den);
    theta1 = atan(aux2);
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
open_system('projeto_2016/compara_in_out')
simOut = sim('projeto_2016');

%% Gera grafico resultados
close all; figure; hold on;
title('Comportamento do sistema');
xlabel('Tempo (s)');
ylabel('Posicao (m)');
plot(compara_in_out(:,1),compara_in_out(:,2),'');
plot(compara_in_out(:,1),compara_in_out(:,3),'');
plot(compara_in_out(:,1),compara_in_out(:,4),'--');
plot(compara_in_out(:,1),compara_in_out(:,5),'--');