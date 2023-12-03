function newX = bitStringFlip(X,p)
% p is the probability of filping, p \in [0,1]
Choice = rand(size(X))>p;
newX = ~X; %Flip all bits first
newX(Choice) = X(Choice); %Keep the bits that should be kept
end