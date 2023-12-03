figure(1)
hold off
scatter(hammingDist(zeros(1,n),SpeciesK),f(SpeciesK)+0.3,'filled')
hold on
scatter(hammingDist(zeros(1,n),SpeciesE),f(SpeciesE)+0.6,'filled')  
scatter(hammingDist(zeros(1,n),SpeciesU),f(SpeciesU),'filled')
xlim([0,n])
ylim([0,n*0.55])
title(t)
legend(sprintf('Inv K=%d',k),'Inv elitist','Uniform',Location='north')