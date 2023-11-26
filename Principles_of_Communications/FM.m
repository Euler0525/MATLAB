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

figure(2)
%% FM信号时域波形
Kf = 3000;                       % 调频系数
fm = Am * cos(2 * pi * fc * t + Kf * Am / 2/ pi / fm .* sin(2 * pi * fm * t));
% SNR = 18;                        % 加噪声(BPF)
% fm = awgn(fm, SNR, "measured");
subplot(2, 1, 1)
plot(t, fm, "LineWidth", 2);
xlabel("t/时间"); ylabel("幅度"); title("FM调制信号时域波形");
axis([0 0.02 -2 2]);
line([0, 0.02], [0, 0], "color", "b", "LineWidth", 2);

%% FM信号频域波形
[ms, msf] = T2F(t, fm);
subplot(2, 1, 2);
plot(mf, abs(msf), "LineWidth", 2)
xlabel("t/时间"); ylabel("幅度/H(f)"); title("FM调制信号频域波形");
axis([-2500 2500 -inf inf]);


figure(3)
% 非相干解调(BPF + 微分器 + 移相器 + 包络检波)
for i  = 1 : N-1
    diff_fm(i) = (fm(i + 1) - fm(i)) / dt; % 微分器
end
diff_fm = abs(hilbert(diff_fm)); % 移相
subplot(2, 1, 1);
plot([1 : N - 1] * dt, diff_fm, "LineWidth", 2);
xlabel("t/时间"); ylabel("幅度"); title("包络检波后波形");
axis([0 0.1 1000 15000]);
line([0, 0.1], [0, 0], "color", "b", "LineWidth", 2);

diff_fm = (diff_fm / Am - 2 * pi * fc) / Kf;
subplot(2, 1, 2);
plot([1 : N - 1] * dt, diff_fm, "LineWidth", 2);
xlabel("t/时间"); ylabel("幅度"); title("去除偏置后波形");
axis([0 0.1 -1.1 1.1]);
line([0, 0.1], [0, 0], "color", "b", "LineWidth", 2);