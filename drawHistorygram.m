figure(5)
[X,Y] = meshgrid(1:t,1:n);
colormap jet
subplot(1,2,1)
surf(X,Y,HistorygramE,EdgeColor="none")
subplot(1,2,2)
surf(X,Y,HistorygramK,EdgeColor="none")
%bar3(HistorygramK)

% figure(5)
% [X,Y] = meshgrid(1:t,1:n);
% colormap jet
% subplot(1,2,1)
% surf(X,Y,HistorygramE,EdgeColor="none")
% subplot(1,2,2)
% surf(X,Y,HistorygramK,EdgeColor="none")
% %bar3(HistorygramK)
% contour3(HistorygramE_GPU(60:140,1:1e5))
% set(gcf,'RendererMode','auto')
% set(gcf,"Renderer","opengl")
% set(gca,'Color','k')
