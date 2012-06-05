function [ Q ] = sampleSO( n )
%SAMPLESO Summary of this function goes here
%   Detailed explanation goes here

Q = sampleO(n);
if det(Q) < 0
    Q(:,1) = -Q(:,1);
end

end