%% Ponto qualquer
clc; close all; clear;

L1 = 0.6;
L2 = 0.6;

x = 0.72;
y = 1;

r = sqrt(x^2+y^2)
beta = (r^2-L1^2-L2^2)/(2*L1*L2);
alpha = y/x;
gama = (L1^2+r^2-L2^2)/(2*L1*r);

theta1 = rad2deg(alpha-gama);
theta2 = rad2deg(beta);

px1 = L1*cosd(theta1);
px2 = px1+L2*cosd(theta1+theta2);
py1 = L1*sind(theta1);
py2 = py1+L2*sind(theta1+theta2);

L1_calc = sqrt(px1^2+py1^2)
L2_calc = sqrt((px2-px1)^2+(py2-py1)^2)

px = [0 px1 px2];
py = [0 py1 py2];
hold on;
xlim([0 1.5]);
ylim([0 1.5]);
plot(x,y,'x');
plot(px,py);

%% Teste
clc; close all; clear;

L1 = 0.6;
L2 = 0.6;

t1 = 30;
t2 = 45;

px1 = L1*cosd(t1);
py1 = L1*sind(t1);
px2 = px1+L2*cosd(t1+t2);
py2 = py1+L2*sind(t1+t2);
r = sqrt(px2^2+py2^2)
L1_calc = sqrt(px1^2+py1^2)
L2_calc = sqrt((px2-px1)^2+(py2-py1)^2)
figure; hold on;
xlim([0 1.5]);
ylim([0 1.5]);
plot([0 px1],[0 py1]);
plot([px1 px2],[py1 py2]);

xd = 0.6749;
yd = 0.8796;

aux1 = (xd^2+yd^2-L1^2-L2^2)/(2*L1*L2);
theta2 = acosd(aux1)
aux2_num = yd*(L1+L2*cosd(theta2))-xd*L2*sind(theta2);
aux2_den = xd*(L1+L2*cosd(theta2))+yd*L2*sind(theta2);
aux2 = aux2_num/aux2_den;
% theta1 = atan2d(L2*cosd(theta2),L2*sind(theta2))
theta1 = atan2d(aux2_num, aux2_den)

px1 = L1*cosd(theta1);
py1 = L1*sind(theta1);
px2 = px1+L2*cosd(theta1+theta2);
py2 = py1+L2*sind(theta1+theta2);
r = sqrt(px2^2+py2^2)
L1_calc = sqrt(px1^2+py1^2);
L2_calc = sqrt((px2-px1)^2+(py2-py1)^2);
figure; hold on;
xlim([0 1.5]);
ylim([0 1.5]);
plot([0 px1],[0 py1]);
plot([px1 px2],[py1 py2]);

%% Circulo
clc; close all; clear;

L1 = 0.6;
L2 = 0.6;

circulo = 360;
num_pontos = 12;

tempo_d = 10;
intervalo = 10/num_pontos;
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

figure; hold on;
xlim([-1.5 1.5]);
ylim([-1.5 1.5]);

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
    
    plot([0 px1],[0 py1]);
    plot([px1 px2],[py1 py2]);
end
plot(lista_posx,lista_posy);