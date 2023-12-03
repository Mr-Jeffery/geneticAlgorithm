function Y = truncatedTwomax(X,k)
% This function is used as test function.
n = length(X(1,:));
Dist = hammingDist(false(1,n),X);
Y = abs(Dist-n/2).*(Dist>n/2-k);
end