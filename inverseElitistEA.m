function newP = inverseElitistEA(P,f)
miu = length(P(:,1));
n = length(P(1,:));
Value = f(P);%Compute all value
[~,score] = sort(f(P),"descend");
P = P(score,:);
Value = Value(score,:);%Rearrange the value as well
min_x_num = sum(Value==Value(miu));%Get the list of the inverse elitist
x = P(miu-randi([0,min_x_num-1]),:);% Choose one of the inverse elitist, which is from miu-min_x_num+1:miu
% y = arrayfun(@(bit)bitFlipping(bit,n),x);% Create y by flipping each bit in x independently with probability 1/n.
y = bitStringFlip(x,1/n);
if f(y)>f(x)
    P(miu,:) = y;
end
newP = P;
end