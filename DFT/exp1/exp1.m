clear;clc;

% 按键
tm = [1, 2, 3, 65; 4, 5, 6, 66; 7, 8, 9, 67; 42, 0, 35, 68]; % ASCII码代替* #
% 按键频率
f1 = [697, 770, 852, 941];
f2 = [1209, 1336, 1477, 1633];
% 查表法
N = 205; % 采样点数
K = [17.861, 19.531, 21.833, 24.113, 30.981, 34.235, 37.848, 41.846];

TN = input("Please enter an 8-digit phone number: ");

TNr = 0;

for l = 1:8
    d = fix(TN / 10 ^ (8 - l));
    TN = TN - d * 10 ^ (8 - l);

    for p = 1:4
        for q = 1:4
            if tm(p, q) == abs(d); break, end %检测码相符的列号q
        end
        if tm(p, q) == abs(d); break, end %检测码相符的行号p
    end

    n = 0:1023;
    x = sin(2 * pi * n * f1(p) / 8000) + sin(2 * pi * n * f2(q) / 8000);
    sound(x, 8000);
    pause(0.1)
    %接收检测端的程序
    X = goertzel(x(1:205), K + 1);
    val = abs(X);
    subplot(4, 2, l);
    stem(K, val, ".");
    grid;
    xlabel("k");
    ylabel("|X(k)|")
    axis([10 50 0 120])
    limit = 80;

    for s = 5:8
        if val(s) > limit, break, end
    end

    for r = 1:4
        if val(r) > limit, break, end
    end

    TNr = TNr + tm(r, s - 4) * 10 ^ (8 - l);
end

disp("The number detected by the receiving end is: ")
disp(TNr)
