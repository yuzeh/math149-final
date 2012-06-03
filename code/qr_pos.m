function [ Q ] = qr_pos(M)
%QR_POS orthogonalizes a square matrix M, by forcing the diagonal entries
%  of R to be positive. Also discards R, so you can simply write 
%  Q = qr_pos(M).

[Q,R] = qr(M);
Q = Q * diag(sign(diag(R)));