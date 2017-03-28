%~~~~ 
% Written by: 
%~~~~ 

clear all; close all;

K=2000;
x=0; y=0;                           %map origin
X=100; Y=100;                       %map max

xStart=0; yStart=0;                 %start V
xGoal=100; yGoal=0;rGoal=20;         %goal V
epslo=5;                            %epslon
OBS = csvread('obstacles.txt');
for i = 1:length(OBS)
    circles(OBS(i,1), OBS(i,2),OBS(i,3),'facecolor','green')
    axis ([0 100 0 100])
end

tree.V(1).x = xStart;
tree.V(1).y = yStart;
tree.V(1).xPrev = xStart;
tree.V(1).yPrev = yStart;
tree.V(1).dist=0;
tree.V(1).ind = 1; 
tree.V(1).indPrev = 0;

xArray=xStart; yArray = yStart;

figure(1); hold on; grid on;
plot(xStart, yStart, 'ko', 'MarkerSize',10, 'MarkerFaceColor','k');
plot(xGoal, yGoal, 'go', 'MarkerSize',rGoal, 'MarkerFaceColor','c');
circles(xGoal, yGoal,rGoal,'facecolor','none')
axis ([0 100 0 100])
for iter = 1:K
    xRand = (X-x)*rand;
    yRand = (Y-y)*rand;
    dist = ones(1,length(tree.V));
    for j = 1:length(tree.V)
        dist(j) = sqrt( (xRand-tree.V(j).x)^2 + (yRand-tree.V(j).y)^2 );
    end
    [val, ind] = min(dist);
       
    tree.V(iter).x = xRand; 
    tree.V(iter).y = yRand;
    tree.V(iter).dist = val;
    tree.V(iter).xPrev = tree.V(ind).x;
    tree.V(iter).yPrev = tree.V(ind).y;
    tree.V(iter).ind = iter; 
    tree.V(iter).indPrev = ind;
    
    if sqrt( (xRand-xGoal)^2 + (yRand-yGoal)^2 ) <= epslo
        
        plot([tree.V(iter).x; tree.V(ind).x],[tree.V(iter).y; tree.V(ind).y], 'g');
        break
        if chkOBS(tree.V(iter).x,tree.V(iter).y,OBS)==1
            return;
        else
            plot([tree.V(iter).x; tree.V(ind).x],[tree.V(iter).y; tree.V(ind).y], 'b');
            plot(tree.V(iter).x, tree.V(iter).y, 'ko', 'MarkerSize',2, 'MarkerFaceColor','r')
            pause(0);

        end
    end
%     if chkOBS(tree.V(iter).x,tree.V(iter).y,OBS)==1
%         return;
%     else
    plot([tree.V(iter).x; tree.V(ind).x],[tree.V(iter).y; tree.V(ind).y], 'b');
    plot(tree.V(iter).x, tree.V(iter).y, 'ko', 'MarkerSize',2, 'MarkerFaceColor','r')
    pause(0);
%     end
end

if iter < K
    path.pos(1).x = xGoal; path.pos(1).y = yGoal;
    path.pos(2).x = tree.V(end).x; path.pos(2).y = tree.V(end).y;
    pathIndex = tree.V(end).indPrev;

    j=0;
    while 1
        path.pos(j+3).x = tree.V(pathIndex).x;
        path.pos(j+3).y = tree.V(pathIndex).y;
        pathIndex = tree.V(pathIndex).indPrev;
        if pathIndex == 1
            break
        end
        j=j+1;
    end
    writetable(struct2table(path.pos), 'somefile.txt')
    path.pos(end+1).x = xStart; path.pos(end).y = yStart;

    for j = 2:length(path.pos)
        plot([path.pos(j).x; path.pos(j-1).x;], [path.pos(j).y; path.pos(j-1).y], 'r--', 'Linewidth', 2);
%         plot([tree.V(i).x; tree.V(ind).x],[tree.V(i).y; tree.V(ind).y], 'r');
%         pause(0);
    end
else
    disp('No path found. Increase number of iterations and retry.');
end
