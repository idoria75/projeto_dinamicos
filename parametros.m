%% Clear environment
clc;
clear all;
close all;

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
passo_integracao = 1e-1;
t_sim = 30;
% Condicoes iniciais
x1_0 = 0;
x2_0 = 0;
x3_0 = 0;
x4_0 = 0;
% Atrito
Kat = .3;

limite_quadrado = 3;

% Executa Simulacao
open_system('projeto_2016/estados')
open_system('projeto_2016/saida_ger')
simOut = sim('projeto_2016');