function [ U ] = sampleSU( n )
%SAMPLESU Summary of this function goes here
%   Detailed explanation goes here

U = sampleU(n);
index = randi(n);
U(:,index) = U(:,index) / det(U);

end

