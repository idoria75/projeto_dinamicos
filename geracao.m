%% Clear environment
clc;
clear all;
close all;

%% Parametros variaveis
% Passo de integracao
passo_integracao = 1e-4;
t_sim = 10;
% Condicoes iniciais
x1_0 = -pi;
% x1_0 = 0;
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
%% Gera circulo

L1 = 0.6;
L2 = 0.6;
% r = sqrt(L1^2+L2^2);

circulo = 360;
num_pontos = 90;

% lim_teste = 90;

tempo_d = t_sim;
intervalo = tempo_d/num_pontos;
lista_tempos = 0:intervalo:tempo_d;

theta_passo = circulo/num_pontos;

lista_thetas = -180:theta_passo:180;

raio = .7;
r = raio
lista_posx = [];
lista_posy = [];

for i = 1:num_pontos+1
    lista_posx(i) = raio*cosd(lista_thetas(i));
    lista_posy(i) = raio*sind(lista_thetas(i));
%     r = sqrt(lista_posx(i)^2+lista_posy(i)^2)
end

% figure; hold on;
% xlim([-1.5 1.5]);
% ylim([-1.5 1.5]);

lista_theta1 = [];
lista_theta2 = [];

% Cinematica Inversa
close all; figure; hold on;
%for i = 1:num_pontos+1
disp('Raio: '); r
for i = 1:num_pontos+1
    xd = lista_posx(i);
    yd = lista_posy(i);
    
    cos_beta = (L1^2+L2^2-r^2)/(2*L1*L2);
    sin_beta = sqrt(1-cos_beta^2);
    beta = atan2(real(sin_beta),real(cos_beta));
    theta2 = pi-beta;
    lista_theta2(i) = theta2;

    alpha = atan2(yd,xd);
    cos_gama = (r^2+L1^2-L2^2)/(2*r*L1);
    sin_gama = sqrt(1-cos_gama^2); % deu valor complexo
    gama = atan2(real(sin_gama),real(cos_gama));
    theta1 = alpha-gama;
    lista_theta1(i) = theta1;
    
    px1 = L1*cosd(theta1);
    py1 = L1*sind(theta1);
    px2 = px1+L2*cosd(theta1+theta2);
    py2 = py1+L2*sind(theta1+theta2);
    raio_calc = sqrt(px2^2+py2^2);
    L1_calc = sqrt(px1^2+py1^2);
    L2_calc = sqrt((px2-px1)^2+(py2-py1)^2);

end

plot(lista_posx,lista_posy);

%% Executa Simulacao
% open_system('projeto_2016/compara_in_out')
simOut = sim('projeto_2016');

%% Gera grafico resultados
close all; figure; hold on; grid on;
title('Comportamento do sistema');
xlabel('Tempo (s)');
ylabel('Posicao (m)');
plot(compara_in_out(:,1),compara_in_out(:,2),'');
plot(compara_in_out(:,1),compara_in_out(:,3),'');
plot(compara_in_out(:,1),compara_in_out(:,4),'--');
plot(compara_in_out(:,1),compara_in_out(:,5),'--');
legend({'Theta 1','Theta 2', 'Ref Theta 1', 'Ref Theta 2'},'Location','southeast')
%%
figure;
hold on;
grid on;
plot(referencia(:,1),referencia(:,2), '-');
plot(referencia(:,1),referencia(:,3), '--');
title('Referencias do Sistema')
xlabel('Tempo (s)')
ylabel('Ângulo (rad)');
legend({'Theta 1','Theta 2'},'Location','southeast')