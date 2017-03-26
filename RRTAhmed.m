clear all; close all;

K=2000;
x=0; y=0;                           %map origin
X=100; Y=100;                       %map max

xStart=0; yStart=0;                 %start Vertex
xGoal=100; yGoal=0;rGoal=20;         %goal Vertex
epslo=5;                            %epslon
OBS = csvread('obstacles.txt');
for i = 1:length(OBS)
    circles(OBS(i,1), OBS(i,2),OBS(i,3),'facecolor','green')
    axis ([0 100 0 100])
end

tree.Vertex(1).x = xStart;
tree.Vertex(1).y = yStart;
tree.Vertex(1).xPrev = xStart;
tree.Vertex(1).yPrev = yStart;
tree.Vertex(1).dist=0;
tree.Vertex(1).ind = 1; 
tree.Vertex(1).indPrev = 0;

xArray=xStart; yArray = yStart;

figure(1); hold on; grid on;
plot(xStart, yStart, 'ko', 'MarkerSize',7, 'MarkerFaceColor','k');
plot(xGoal, yGoal, 'go', 'MarkerSize',7, 'MarkerFaceColor','c');
circles(xGoal, yGoal,rGoal,'facecolor','none')
for iter = 1:K
    xRand = (X-x)*rand;
    yRand = (Y-y)*rand;
    dist = ones(1,length(tree.Vertex));
    for j = 1:length(tree.Vertex)
        dist(j) = sqrt( (xRand-tree.Vertex(j).x)^2 + (yRand-tree.Vertex(j).y)^2 );
        
    end
    [val, ind] = min(dist);

    tree.Vertex(iter).x = xRand; 
    tree.Vertex(iter).y = yRand;
    tree.Vertex(iter).dist = val;
    tree.Vertex(iter).xPrev = tree.Vertex(ind).x;
    tree.Vertex(iter).yPrev = tree.Vertex(ind).y;
    tree.Vertex(iter).ind = iter; 
    tree.Vertex(iter).indPrev = ind;
    
%     if sqrt( (tree.Vertex(iter).x-xGoal)^2 + (tree.Vertex(iter).y-yGoal)^2 )<= rGoal %This Line 
%            disp('We Got there.');
%            break
%     end
    if sqrt( (xRand-xGoal)^2 + (yRand-yGoal)^2 ) <= epslo
            plot([tree.values(iter).x; tree.values(ind).x],[tree.values(iter).y; tree.values(ind).y], 'g');
            break
    end
    if chkOBS(tree.Vertex(iter).x,tree.Vertex(iter).y,OBS)==1
        return;
    else
    plot([tree.Vertex(iter).x; tree.Vertex(ind).x],[tree.Vertex(iter).y; tree.Vertex(ind).y], 'b');
    plot(tree.Vertex(iter).x,tree.Vertex(iter).y,'MarkerSize',5, 'MarkerFaceColor','k' );
    pause(0);
    end
end
 
