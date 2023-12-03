function newP = standardEA(P,f)
miu = length(P(:,1));
n = length(P(1,:));
x = P(randi([1,miu]),:);% Choose x ∈ Pt uniformly at random
y = bitStringFlip(x,1/n);% Create y by flipping each bit in x independently with probability 1/n.
P = [P;y];
[~,score] = sort(f(P),"descend");
newP = P(score(1:miu),:);
end