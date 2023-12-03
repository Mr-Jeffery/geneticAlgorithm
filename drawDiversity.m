figure(2)
clf
title(t)
hold on
semilogy(DiversityK)
semilogy(DiversityE)
semilogy(DiversityU)
legend(sprintf('Inv K=%d',k),'Inv elitist','Uniform',Location='southeast')