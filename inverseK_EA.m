function newP = inverseK_EA(P,f,k)
miu = length(P(:,1));
n = length(P(1,:));
X = P(randperm(miu,k),:);% Choose Xs ∈ P_t uniformly at random
Score = f(X);
minimum = min(Score);%perform inverse tournament
Location = find(Score==minimum);
Candidate = X(Location,:);
x = Candidate(randperm(length(Location),1),:);%pick one of the worst
y = bitStringFlip(x,1/n);% Create y by flipping each bit in x independently with probability 1/n.
P = [P;y];
[~,Rank] = sort(f(P),"descend");%pop out the worst
newP = P(Rank(1:miu),:);
end