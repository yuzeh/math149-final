function [ output ] = norm1vec( X )
    output = sum(sum(abs(X)));
end

