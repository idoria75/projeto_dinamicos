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

%% Circulo
clc; close all; clear;

L1 = 0.6;
L2 = 0.6;

circulo = 360;
num_pontos = 360/12;

theta_passo = circulo/num_pontos;

lista_thetas = [0:theta_passo:circulo];

raio = 1;
lista_posx = [];
lista_posy = [];

for i = 1:num_pontos+1
    lista_posx(i) = raio*cosd(lista_thetas(i));
    lista_posy(i) = raio*sind(lista_thetas(i));
end

% plot(lista_posx,lista_posy)

% lista_px1 = [];
% lista_py1 = [];
% lista_px2 = [];
% lista_py2 = [];

figure; hold on;
for i = 1:num_pontos+1
    r = sqrt(lista_posx(i)^2+lista_posy(i)^2)
    beta = (r^2-L1^2-L2^2)/(2*L1*L2);
    alpha = lista_posy(i)/lista_posx(i);
    gama = (L1^2+r^2-L2^2)/(2*L1*r);
    
    theta1 = rad2deg(alpha-gama);
    theta2 = rad2deg(beta);
    
%     lista_px1(i) = L1*cosd(theta1);
%     lista_px2(i) = px1+L2*cosd(theta1+theta2);
%     lista_py1(i) = L1*sind(theta1);
%     lista_py2(i) = py1+L2*sind(theta1+theta2);
    
    px1 = L1*cosd(theta1);
    px2 = px1+L2*cosd(theta1+theta2);
    py1 = L1*sind(theta1);
    py2 = py1+L2*sind(theta1+theta2);

    px = [0 px1 px2];
    py = [0 py1 py2];
    plot(lista_posx(i), lista_posy(i), 'x');
    plot(px,py);
end
% lista_px1 = [];
% lista_py1 = [];
% lista_px2 = [];
% lista_py2 = [];
% 
% for i = 1:20
% %     lista_px1(i) = theta_passo*i;
%     lista_px1(i) = L1*cosd(lista_thetas(i));
%     lista_py1(i) = L1*sind(lista_thetas(i));
%     lista_px2(i) = lista_px1(i)+L2*cosd(theta1+theta2);
%     lista_py2(i) = lista_py1(i)+L2*sind(theta1+theta2);
% end
% 
% lista_px1
% lista_py1
% lista_px2
% lista_py2