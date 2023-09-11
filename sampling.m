f = 1;  % 信号频率
t = -5:0.01:5;
x = cos(2 * pi * f * t);

fs = 10;  % 采样频率
dt = 1 / fs;
T = -5:dt:5;  % 定义采样的时间点
x1 = cos(2 * pi * f * T);  % 对信号进行采样
subplot(2,1,1);
plot(t, x);
subplot(2,1,2);
stem(T, x1);