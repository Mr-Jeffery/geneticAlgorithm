figure(5)
[X,Y] = meshgrid(1:t,1:n);
colormap jet
subplot(1,2,1)
surf(X,Y,HistorygramE,EdgeColor="none")
subplot(1,2,2)
surf(X,Y,HistorygramK,EdgeColor="none")
%bar3(HistorygramK)