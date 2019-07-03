%% Parametros
clc; clear; close all;
% m1 = 2.2;
% m2 = 2.2;
% mp = 2;
% 
L1 = 0.6;
L2 = 0.6;
% l1 = 0.3;
% l2 = 0.3;
% I1 = 0.066;
% I2 = 0.066;
% g = 9.81;

x = 0.72;
y = 1;

r = sqrt(x^2+y^2);
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
plot(px,py);