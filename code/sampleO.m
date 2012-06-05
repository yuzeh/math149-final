function [ Q ] = sampleO( n )
%SAMPLEO Summary of this function goes here
%   Detailed explanation goes here

M = randn(n);
Q = qr_pos(M);

end