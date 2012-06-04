function [ output ] = norm2vec( X )
    output = sum(sum(X.^2));
end