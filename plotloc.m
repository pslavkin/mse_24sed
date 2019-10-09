function plotloc(P,AP,plano)
   imshow(plano,'XData',[0 100],'YData',[0 100])
   dim = size(P);
   if(dim(2)~=2)
       disp('Error! El vector de posiciones P debe ser de Nx2, donde N es la cantidad de puntos medidos.')
   else
      hold on
      plot(P(:  ,1) ,P(:  ,2) ,'o' ,'MarkerEdgeColor' ,'r' ,'MarkerFaceColor' ,'r' ,'LineWidth' ,2 ,'MarkerSize' ,8)
      plot(AP(: ,1) ,AP(: ,2) ,'s' ,'MarkerEdgeColor' ,'k' ,'MarkerFaceColor' ,'y' ,'LineWidth' ,2 ,'MarkerSize' ,13)
      hold off
      legend('Target','Anclas','Location','NorthWest')
   end
end

