function [ Q ] = sampleSO( n )
%SAMPLESO Summary of this function goes here
%   Detailed explanation goes here

M = randn(n);
[Q,R] = qr(M);
while det(Q) ~= 1
    M = randn(n);
    [Q,R] = qr(M);
end

end

