function [ Q ] = sampleSO( n )
%SAMPLESO Summary of this function goes here
%   Detailed explanation goes here

M = randn(n);
Q = qr_pos(M);
while det(Q) < 0
    M = randn(n);
    Q = qr_pos(M);
end

end

