close all;clear;clc;

M = 200;
x = randi([0, 1], 1, M);
x = 2 * x - 1;
h = [0.01 0.02 0.3 -0.02 1 -0.02 0.1 0.03 0.01];

x1 = conv(x, h);

eyediagram(x1, 2);
title("Before ZF")

N = 5;
C = force_zero(h, N);
y = conv(x1, C);
eyediagram(y, 2);
title("After ZF");