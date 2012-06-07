function [ U ] = sampleU( n )
%SAMPLEU Summary of this function goes here
%   Detailed explanation goes here

M = randn(n) + 1i* randn(n);
U = qr_pos(M);

end

