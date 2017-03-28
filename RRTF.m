%%declare variables
clear All close All
xMin=0;     yMin=0;
xMax=100;   yMax=100;
xStart=0;   yStart=0;
xGoal=80;   yGoal=90;
rGoal=20;
k=1000;
epsl=5;
V=cell(1,5);
xCurrent=0;
yCurrent=0;
V{1,1}(1)=0; V{1,2}(1)=0;
V{1,3}(1)=0; V{1,4}(1)=0;
obsArray = csvread('obstacles.txt');

figure(1); hold on; grid on;
plot(xStart, yStart, 'ko', 'MarkerSize',10, 'MarkerFaceColor','k');
plot(xGoal, yGoal, 'go', 'MarkerSize',10, 'MarkerFaceColor','c');
circles(xGoal, yGoal,rGoal,'facecolor','none')
axis ([0 100 0 100])
axis equal
for i = 1:k
while euclidean(V{1,1}(i),V{1,2}(i),xGoal,yGoal)>rGoal %LABEL start 
    [V{1,1}(i),V{1,2}(i)]=randPnt(xStart,yStart,xGoal,yGoal);
    EpsiChk = epsChk(V{1,1}(i),V{1,2}(i),V{1,3}(i),V{1,4}(i),epsl);
    if EpsiChk == 0
        OBS=chkOBS(V{1,1}(i),V{1,2}(i),obsArray);
        if OBS == 0
            plot([V{1,1}(i); V{1,2}(i)],[V{1,3}(i); V{1,4}(i)], 'b');
            plot(V{1,1}(i), V{1,2}(i), 'ko', 'MarkerSize',2, 'MarkerFaceColor','r')
        else
            break
        end
    else
        break
    end    
end
end
