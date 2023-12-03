function Child = crossover(Parent1,Parent2)
n = length(Parent1);
Choice = logical(randi([0,1],1,n));%Choose from parent1 or parent2
Child = Parent1;
Child(Choice) = Parent2(Choice);
end