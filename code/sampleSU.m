function [ U ] = sampleSU( n )
%SAMPLESU Summary of this function goes here
%   Detailed explanation goes here

U = sampleU(n);
num = conj(det(U)) ^ (1 / n);
U = U * num;

end

