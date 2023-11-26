close all;clear;clc;

% 调制信号
fm = 100;                        % 基带信号频率
T = 2;                           % 信号持续时间
fs = 20000;                      % 采样频率
dt = 1 / fs;                     % 采样间隔
N = T / dt;                      % 采样点数
t = (0 : N-1) * dt;              % 采样点的时间序列

figure(1);
%% 调制信号时域波形
subplot(2, 2, 1);
Am = 1;                          % 基带信号幅度
mt = Am * cos(2 * pi * fm * t);  % 基带信号
plot(t, mt, "LineWidth", 2);
xlabel("t/时间"); ylabel("幅度"); title("基带信号时域波形");
axis([0, 0.1, -1.1, 1.1]);
line([0, 0.1], [0, 0], "color", "b");

%% 调制信号频域波形
subplot(2, 2, 2);
[mf, msf] = T2F(t, mt);          % 傅里叶变换
plot(mf, abs(msf), "LineWidth", 2);
xlabel("f/Hz"); ylabel("幅度/H(f)"); title("基带信号频谱");
axis([-150 150 -inf inf]);


% 载波信号
%% 载波信号时域波形
subplot(2, 2, 3);
fc = 1000;                       % 载波频率
carrier = cos(2 * pi * fc * t);
plot(t, carrier, "r", "LineWidth", 2);
xlabel("t/时间"); ylabel("幅度"); title("载波信号");
axis([0, 0.01, -1.1, 1.1]);
line([0, 0.01], [0, 0], "color", "b");

%% 载波信号频域波形
subplot(2, 2, 4);
[mf, msf] = T2F(t, carrier);
plot(mf, abs(msf), "r", "LineWidth", 2);
xlabel("f/Hz"); ylabel("幅度/H(f)"); title("载波信号频谱");
axis([-1500 1500 -inf inf]);


% DSB信号
figure(2);
%% DSB信号时域波形
dsb = mt .* carrier;
SNR = 8;                        % 加噪声
dsb = awgn(dsb, SNR, "measured");
subplot(2, 1, 1);
plot(t, dsb, "LineWidth", 2);    % DSB调制信号
xlabel("t/时间"); ylabel("幅度"); title("DSB调制信号");
axis([0, 0.02, -3.1, 3.1]);
line([0, 0.02], [0, 0], "color", "b", "Linewidth", 2);

%% DSB信号频域波形
[mf, msf] = T2F(t, dsb);
subplot(2, 1, 2);
plot(mf, abs(msf), "Linewidth", 2);
xlabel("f/Hz"); ylabel("幅度/H(f)"); title("DSB信号频域波形");
axis([-1500 1500 -inf inf]);


% 相干解调
figure(3);

st = dsb .* carrier;
subplot(2, 2, 1);
plot(t, st, "Linewidth", 2);
xlabel("t/时间"); ylabel("幅度"); title("已调信号与载波信号相乘");
axis([0 0.02 -1.5 3.5]);
line([0, 0.02], [0, 0], "color", "b", "Linewidth", 2);

[f, sf] = T2F(t, st);
subplot(2, 2, 2);
plot(f, sf, "Linewidth", 2);
xlabel("f/Hz"); ylabel("幅度/H(f)"); title("已调信号与载波信号相乘的频谱");
axis([-2500 2500 -inf inf]);


% 解调信号
[t, st] = lpf(f, sf, 2 * fm);    % 低通滤波
subplot(2, 2, 3);
plot(t, 2 * st, "Linewidth", 2);
xlabel("t/时间"); ylabel("幅度"); title("相干解调信号波形");
axis([0 0.1 -1.1 1.1]);
line([0, 0.1], [0, 0], "color", "b", "Linewidth", 2);

subplot(2, 2, 4);
plot(t, mt, "r", "Linewidth", 2);
xlabel("t/时间"); ylabel("幅度"); title("原始基带信号");
axis([0 0.1 -1.1 1.1]);
line([0, 0.1], [0, 0], "color", "b", "Linewidth", 2);