function [ Q ] = sampleSO( n )
%SAMPLESO Summary of this function goes here
%   Detailed explanation goes here

M = randn(n);
[Q,R] = qr(M);
if det(Q) ~= 1
    col = randi(n);
    Q(:,col) = Q(:,col) * det(Q);
end

end

