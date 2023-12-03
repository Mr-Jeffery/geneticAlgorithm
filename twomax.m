function Y = twomax(X)
% This function is used as test function.
n = length(X(1,:));
O = false(1,n);
Y = abs(hammingDist(O,X)-n/2);
end