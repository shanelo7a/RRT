function  pltRRT(xOrg,yOrg,xMax,yMax,xGoal,yGoal,rGoal,tr,OBS )
%plot OBStecales
figure; hold on; grid on;
axis ([xOrg xMax yOrg yMax]);
plot(tr.V(1).x, tr.V(1).y, 'ko', 'MarkerSize',7, 'MarkerFaceColor','k');
plot(xGoal, yGoal, 'go', 'MarkerSize',7, 'MarkerFaceColor','c');
circles(xGoal, yGoal,rGoal,'facecolor','none');
for i = 1:length(OBS)
    circles(OBS(i,1), OBS(i,2),OBS(i,3),'facecolor','green');
end
drawnow

for j=1:length(tr.V)
    if tr.V(j).flag == 1
        plot([tr.V(j).xPrev tr.V(j).x] ,[tr.V(j).yPrev tr.V(j).y],'b')
    else
        plot([tr.V(j).xPrev tr.V(j).x] ,[tr.V(j).yPrev tr.V(j).y],'r')
        drawnow
    end
end

