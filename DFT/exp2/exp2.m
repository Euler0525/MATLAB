tic;  % 开始计时

N = 12;  % 周期
n = 0: N-1;
k = 0: N-1;
xn = cos(n * pi / 6);
subplot(3, 1, 1);
stem(n, xn);
title("cos(n * pi / 6)");

W = exp(-1i * 2 * pi / N);
kn = n .* k;
Xk = xn * (W .^ kn);
subplot(3, 1, 2);
stem(n, Xk);
title("N = 12");