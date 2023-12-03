% This is used to simulate evolutionary algorithms
resetPlayground
%%
f = @(x)twomax(x);
for t = 1:T
    SpeciesK = inverseK_EA(SpeciesK,f,k);
    DiversityK(t) = sum(var(SpeciesK))*miu;
    HistorygramK(:,t) = histcounts(hammingDist(0,SpeciesK),0:n);

    SpeciesE = InverseElitistEA(SpeciesE,f);
    DiversityE(t) = sum(var(SpeciesE))*miu;
    HistorygramE(:,t) = histcounts(hammingDist(0,SpeciesE),0:n);

    SpeciesU = standardEA(SpeciesU,f);
    DiversityU(t) = sum(var(SpeciesU))*miu;


    if mod(t,1e3)==0
    %drawLocation
    disp(t)
    end
end
%%
drawDiversity
%%
drawLocation
%%
drawHistorygram
