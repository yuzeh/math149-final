function [ U] = sampleU( n )
%SAMPLEU Summary of this function goes here
%   Detailed explanation goes here

M = zeros(n);
for row=1:n
    for col=1:n
        M(row,col) = 0.5 * randn() + 0.5 * i * randn();
    end
end

[U,R] = qr(M);

end

