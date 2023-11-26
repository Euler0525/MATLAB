function [ c ] = force_zero(h, N)
    H = length(h);
    MID = find(h == 1);
    if (MID - 1  < H - MID)
        for i = 1: (H - MID)- (MID - 1)
            h = [0, h];
        end
    else
        for i = 1: (MID - 1) - (H - MID)
            h = [h, 0];
        end
    end

L = max(MID - 1, H - MID);
x = zeros(1, 4 * N + 1);
if 2 * N  >= L
    x([2 * N + 1 - L : 2 * N + 1 + L]) = h;
else
    x = h([MID - 2 * N: MID + 2 * N]);
end

X = [];
for i = 1: 2 * N + 1
    X = [X;fliplr(x(i: 2 * N + i))];
end

d = zeros(2 * N  + 1, 1);
d(N + 1) = 1;
c = X ^ (-1) * d;

end