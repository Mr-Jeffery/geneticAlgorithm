global n;
global miu;
n = 200;%length of each sequence
miu = 1000;%group size
k = 2;%inverse tournament size
T = 1e4;
% S0 = generator(n,1);
% S1 = generator(n,1);
% f = @(x)twomax(x);
Species = speciesGenerator(n,miu);
%%
SpeciesU = Species;
SpeciesK = Species;
SpeciesE = Species;
s = linspace(0,1,miu);
DiversityU = zeros(T,1);
DiversityK = DiversityU;
DiversityE = DiversityU;
HistorygramE = zeros(n,T);
HistorygramK = HistorygramE;

function Y = speciesGenerator(n,miu)
% This function is used to generate miu binary sequences whose length is n.
Y = logical(randi([0,1],miu,n));
end

