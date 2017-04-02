clear all; close all;


x=0; y=0;                           %map origin
X=100; Y=100;                       %map max

xStart=75; yStart=85;               %start V
xGoal=100; yGoal=0;rGoal=20;        %goal V
EPS=5;                              %epslon
k=2000;                              %iteration
OBS = csvread('obstacles.txt');
for i = 1:length(OBS)
    circles(OBS(i,1), OBS(i,2),OBS(i,3),'facecolor','green')
    axis ([0 100 0 100])
end

% V=struct('x',zeroes(k,1),'y',zeroes(k,1),'xPrev',zeroes(k,1),'yPrev',zeroes(k,1),'dist',zeroes(k,1),'ind',zeroes(k,1),'indPrev',zeroes(k,1));
% tree=struct('V',V)

tree.V(1).x = xStart;
tree.V(1).y = yStart;
tree.V(1).xPrev = 0;
tree.V(1).yPrev = 0;
tree.V(1).dist=0;
tree.V(1).ind = 1; 
tree.V(1).indPrev = 0;

tree.V(2).x = 0;
tree.V(2).y = 0;
tree.V(2).xPrev = xStart;
tree.V(2).yPrev = yStart;
tree.V(2).dist=0;
tree.V(2).ind = 0; 
tree.V(2).indPrev = 0;

xArray=xStart; yArray = yStart;

figure(1); hold on; grid on;
plot(xStart, yStart, 'ko', 'MarkerSize',7, 'MarkerFaceColor','k');
plot(xGoal, yGoal, 'go', 'MarkerSize',7, 'MarkerFaceColor','c');
circles(xGoal, yGoal,rGoal,'facecolor','none')
drawnow

while tree.V(end).dist == 0 
    [x,y]=randPnt();
    disp(tree.V(end).x);
    i=2;
    disp('i='); disp(i);
    while epsChk(x,y,tree.V(i).xPrev,tree.V(i).yPrev,EPS) == 1
        disp('epsChk')
        disp(epsChk(x,y,tree.V(i).xPrev,tree.V(i).yPrev,EPS))
        while chkOBS(x,y,OBS) == 1
            disp('chkOBS')
            disp(chkOBS(x,y,OBS))
            tree.V(iter).x = xRand; 
            tree.V(iter).y = yRand;
            tree.V(iter).dist = euclidean(x,y,tree.V(i).xPrev,tree.V(i).yPrev);
            tree.V(iter).xPrev = tree.V(ind).x;
            tree.V(iter).yPrev = tree.V(ind).y;
            tree.V(iter).ind = iter; 
            tree.V(iter).indPrev = ind;
            i= i+1;
        end
    end
end
