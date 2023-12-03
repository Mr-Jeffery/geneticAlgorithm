% This is used to simulate evolutionary algorithms
% global n;
% global miu;
% n = 200;%length of each sequence
% miu = 1000;%group size
% k = 2;%inverse tournament size
% T = 1e5;
% % S0 = generator(n,1);
% % S1 = generator(n,1);
% f = @(x)twomax(x);
% Species = generator(n,miu);
% %%
% SpeciesU = Species;
% SpeciesK = Species;
% SpeciesE = Species;
% s = linspace(0,1,miu);
% DiversityU = zeros(T,1);
% DiversityK = DiversityU;
% DiversityE = DiversityU;
% HistorygramE = zeros(n,T);
% HistorygramK = HistorygramE;
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
%         figure(1)
%         clf
%         hold on
%         scatter(hammingDist(zeros(1,n),SpeciesK),f(SpeciesK)+0.3,'filled')
%         scatter(hammingDist(zeros(1,n),SpeciesE),f(SpeciesE)+0.6,'filled')  
%         scatter(hammingDist(zeros(1,n),SpeciesU),f(SpeciesU),'filled')
%         xlim([0,n])
%         ylim([0,n*0.55])
%         title(t)
%         legend(sprintf('Inv K=%d',k),'Inv elitist','Uniform',Location='north')
%         drawnow
%         figure(3)
%         subplot(1,2,1)
%         bar(HistorygramE(:,t))
%         subplot(1,2,2)
%         bar(HistorygramK(:,t))
%         drawnow
disp(t)
    end
end
%%
% figure(2)
% clf
% title(t)
% hold on
% semilogy(DiversityK)
% semilogy(DiversityE)
% semilogy(DiversityU)
% legend(sprintf('Inv K=%d',k),'Inv elitist','Uniform',Location='southeast')
%%
% figure(1)
% clf
% hold on
% scatter(hammingDist(zeros(1,n),SpeciesK),f(SpeciesK)+0.3,'filled')
% scatter(hammingDist(zeros(1,n),SpeciesE),f(SpeciesE)+0.6,'filled')  
% scatter(hammingDist(zeros(1,n),SpeciesU),f(SpeciesU),'filled')
% xlim([0,n])
% ylim([0,n*0.55])
% title(t)
% legend(sprintf('Inv K=%d',k),'Inv elitist','Uniform',Location='north')
%%
% figure(5)
% [X,Y] = meshgrid(1:t,1:n);
% colormap jet
% subplot(1,2,1)
% surf(X,Y,HistorygramE,EdgeColor="none")
% subplot(1,2,2)
% surf(X,Y,HistorygramK,EdgeColor="none")
% %bar3(HistorygramK)
contour3(HistorygramE_GPU(60:140,1:1e5))
set(gcf,'RendererMode','auto')
set(gcf,"Renderer","opengl")
set(gca,'Color','k')
function newP = standardEA(P,f)
global miu;
x = P(randi([1,miu]),:);% Choose x ∈ Pt uniformly at random
y = arrayfun(@(bit)bitFlipping(bit),x);% Create y by flipping each bit in x independently with probability 1/n.
P = [P;y];
[~,score] = sort(f(P),"descend");
newP = P(score(1:miu),:);
end

function newP = inverseK_EA(P,f,k)
global miu;
X = P(randperm(miu,k),:);% Choose Xs ∈ P_t uniformly at random
Score = f(X);
minimum = min(Score);%perform inverse tournament
Location = find(Score==minimum);
Candidate = X(Location,:);
x = Candidate(randperm(length(Location),1),:);%pick one of the worst
y = arrayfun(@(bit)bitFlipping(bit),x);% Create y by flipping each bit in x independently with probability 1/n.
P = [P;y];
[~,Rank] = sort(f(P),"descend");%pop out the worst
newP = P(Rank(1:miu),:);
end


function newP = InverseElitistEA(P,f)
global miu;
Value = f(P);%Compute all value
[~,score] = sort(f(P),"descend");
P = P(score,:);
Value = Value(score,:);%Rearrange the value as well
min_x_num = sum(Value==Value(miu));%Get the list of the inverse elitist
x = P(miu-randi([0,min_x_num-1]),:);% Choose one of the inverse elitist, which is from miu-min_x_num+1:miu
y = arrayfun(@(bit)bitFlipping(bit),x);% Create y by flipping each bit in x independently with probability 1/n.
if f(y)>f(x)
    P(miu,:) = y;
end
newP = P;
end

% function Y = generator(n,miu)
% % This function is used to generate miu binary sequences whose length is n.
% Y = logical(randi([0,1],miu,n));
% end

function Y = twomax(X)
% This function is used as test function.
global n;
O = false(1,n);
Y = abs(hammingDist(O,X)-n/2);
end

function Y = truncatedTwomax(X,k)
% This function is used as test function.
global n;
Dist = hammingDist(false(1,n),X);
Y = abs(Dist-n/2).*(Dist>n/2-k);
end

function H = hammingDist(x,Y)
% This function is used to calculate the hamming distances between x and Ys, where Y could be multiple points.
X = repmat(x,height(Y),1);
H = sum(bitxor(X,Y),2);
end

function newbit = bitFlipping(bit)
global n;
probability = rand*n<1;
if probability
    newbit = ~bit;
else
    newbit = bit;
end
end